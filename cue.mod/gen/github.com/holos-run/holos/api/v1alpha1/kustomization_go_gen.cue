// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/holos-run/holos/api/v1alpha1

package v1alpha1

// Kustomization holds the rendered flux kustomization api object content for git ops.
#Kustomization: {
	// KsContent is the yaml representation of the flux kustomization for gitops.
	ksContent?: string @go(KsContent)
}
