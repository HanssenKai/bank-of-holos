package holos

import (
	corev1 "k8s.io/api/core/v1"
	rbacv1 "k8s.io/api/rbac/v1"
	batchv1 "k8s.io/api/batch/v1"
)

// Produce a kubernetes objects build plan.
(#Kubernetes & Objects).BuildPlan

let BankName = #BankOfHolos.Name

let Objects = {
	Name:      "bank-secrets"
	Namespace: #BankOfHolos.Security.Namespace

	// Roles for reading and writing secrets
	let Reader = "jwt-key-reader"
	let Writer = "jwt-key-writer"

	Resources: [_]: [_]: metadata: namespace:    Namespace
	Resources: [_]: [ID=string]: metadata: name: string | *ID

	Resources: {
		// Kubernetes ServiceAccount used by the secret generator job.
		ServiceAccount: (Writer): corev1.#ServiceAccount
		// Role to allow the ServiceAccount to update secrets.
		Role: (Writer): rbacv1.#Role & {
			rules: [{
				apiGroups: [""]
				resources: ["secrets"]
				verbs: ["create", "update", "patch"]
			}]
		}
		// Bind the role to the service account.
		RoleBinding: (Writer): rbacv1.#RoleBinding & {
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "Role"
				name:     Role[Writer].metadata.name
			}
			subjects: [{
				kind:      "ServiceAccount"
				name:      ServiceAccount[Writer].metadata.name
				namespace: Namespace
			}]
		}

		let JobSpec = {
			serviceAccountName: Writer
			restartPolicy:      "OnFailure"
			securityContext: {
				seccompProfile: type: "RuntimeDefault"
				runAsNonRoot: true
				runAsUser:    8192 // app
			}
			containers: [
				{
					name:  "toolkit"
					image: "quay.io/holos-run/toolkit:2024-09-16"
					securityContext: {
						capabilities: drop: ["ALL"]
						allowPrivilegeEscalation: false
					}
					command: ["/bin/bash"]
					args: ["/config/entrypoint"]
					env: [{
						name:  "HOME"
						value: "/tmp"
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
						readOnly:  true
					}]
				},
			]
			volumes: [{
				name: "config"
				configMap: name: Writer
			}]
		}

		Job: (Writer): batchv1.#Job & {
			spec: template: spec: JobSpec
		}

		ConfigMap: (Writer): corev1.#ConfigMap & {
			data: entrypoint: ENTRYPOINT
		}

		// Allow the SecretStore in the frontend and backend namespaces to read the
		// secret.
		Role: (Reader): rbacv1.#Role & {
			rules: [{
				apiGroups: [""]
				resources: ["secrets"]
				resourceNames: ["jwt-key"]
				verbs: ["get"]
			}]
		}

		// Grant access to the bank-of-holos service account in the frontend and
		// backend namespaces.
		RoleBinding: (Reader): rbacv1.#RoleBinding & {
			roleRef: {
				apiGroup: "rbac.authorization.k8s.io"
				kind:     "Role"
				name:     Role[Reader].metadata.name
			}
			subjects: [{
				kind:      "ServiceAccount"
				name:      BankName
				namespace: #BankOfHolos.Frontend.Namespace
			}, {
				kind:      "ServiceAccount"
				name:      BankName
				namespace: #BankOfHolos.Backend.Namespace
			},
			]
		}
	}
}

let ENTRYPOINT = """
	#! /bin/bash
	#

	tmpdir="$(mktemp -d)"
	finish() {
	  status=$?
	  rm -rf "${tmpdir}"
	  return $status
	}
	trap finish EXIT

	set -euo pipefail

	cd "$tmpdir"
	mkdir jwt-key
	cd jwt-key
	echo "generating private key" >&2
	ssh-keygen -t rsa -b 4096 -m PEM -f jwtRS256.key -q -N "" -C bank-of-holos
	echo "generating public key" >&2
	ssh-keygen -e -m PKCS8 -f jwtRS256.key > jwtRS256.key.pub
	cd ..

	echo "copying keys into manifest secret.yaml" >&2
	kubectl create secret generic jwt-key --from-file=jwt-key --dry-run=client -o yaml > secret.yaml

	echo "applying secret" >&2
	kubectl apply --server-side=true -f secret.yaml

	echo "cleaning up" >&2
	rm -rf jwt-key
	rm -f secret.yaml

	echo "ok done" >&2
	"""
