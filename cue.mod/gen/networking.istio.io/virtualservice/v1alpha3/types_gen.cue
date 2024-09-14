// Code generated by timoni. DO NOT EDIT.

//timoni:generate timoni vendor crd -f deploy/clusters/aws2/components/istio-base/istio-base.gen.yaml

package v1alpha3

import "strings"

#VirtualService: {
	// Configuration affecting label/content routing, sni routing,
	// etc. See more details at:
	// https://istio.io/docs/reference/config/networking/virtual-service.html
	spec!:      #VirtualServiceSpec
	apiVersion: "networking.istio.io/v1alpha3"
	kind:       "VirtualService"
	metadata!: {
		name!: strings.MaxRunes(253) & strings.MinRunes(1) & {
			string
		}
		namespace!: strings.MaxRunes(63) & strings.MinRunes(1) & {
			string
		}
		labels?: {
			[string]: string
		}
		annotations?: {
			[string]: string
		}
	}
}

// Configuration affecting label/content routing, sni routing,
// etc. See more details at:
// https://istio.io/docs/reference/config/networking/virtual-service.html
#VirtualServiceSpec: {
	// A list of namespaces to which this virtual service is exported.
	exportTo?: [...string]

	// The names of gateways and sidecars that should apply these
	// routes.
	gateways?: [...string]

	// The destination hosts to which traffic is being sent.
	hosts?: [...string]

	// An ordered list of route rules for HTTP traffic.
	http?: [...{
		// Cross-Origin Resource Sharing policy (CORS).
		corsPolicy?: {
			// Indicates whether the caller is allowed to send the actual
			// request (not the preflight) using credentials.
			allowCredentials?: null | bool

			// List of HTTP headers that can be used when requesting the
			// resource.
			allowHeaders?: [...string]

			// List of HTTP methods allowed to access the resource.
			allowMethods?: [...string]
			allowOrigin?: [...string]

			// String patterns that match allowed origins.
			allowOrigins?: [...({} | {
				exact: _
			} | {
				prefix: _
			} | {
				regex: _
			}) & {
				exact?:  string
				prefix?: string

				// RE2 style regex-based match
				// (https://github.com/google/re2/wiki/Syntax).
				regex?: string
			}]

			// A list of HTTP headers that the browsers are allowed to access.
			exposeHeaders?: [...string]

			// Specifies how long the results of a preflight request can be
			// cached.
			maxAge?: string
		}

		// Delegate is used to specify the particular VirtualService which
		// can be used to define delegate HTTPRoute.
		delegate?: {
			// Name specifies the name of the delegate VirtualService.
			name?: string

			// Namespace specifies the namespace where the delegate
			// VirtualService resides.
			namespace?: string
		}

		// A HTTP rule can either return a direct_response, redirect or
		// forward (default) traffic.
		directResponse?: {
			// Specifies the content of the response body.
			body?: ({} | {
				string: _
			} | {
				bytes: _
			}) & {
				// response body as base64 encoded bytes.
				bytes?:  string
				string?: string
			}

			// Specifies the HTTP response status to be returned.
			status: uint32
		}

		// Fault injection policy to apply on HTTP traffic at the client
		// side.
		fault?: {
			// Abort Http request attempts and return error codes back to
			// downstream service, giving the impression that the upstream
			// service is faulty.
			abort?: ({} | {
				httpStatus: _
			} | {
				grpcStatus: _
			} | {
				http2Error: _
			}) & {
				// GRPC status code to use to abort the request.
				grpcStatus?: string
				http2Error?: string

				// HTTP status code to use to abort the Http request.
				httpStatus?: int
				percentage?: {
					value?: number
				}
			}

			// Delay requests before forwarding, emulating various failures
			// such as network issues, overloaded upstream service, etc.
			delay?: ({} | {
				fixedDelay: _
			} | {
				exponentialDelay: _
			}) & {
				exponentialDelay?: string

				// Add a fixed delay before forwarding the request.
				fixedDelay?: string

				// Percentage of requests on which the delay will be injected
				// (0-100).
				percent?: int
				percentage?: {
					value?: number
				}
			}
		}
		headers?: {
			request?: {
				add?: {
					[string]: string
				}
				remove?: [...string]
				set?: {
					[string]: string
				}
			}
			response?: {
				add?: {
					[string]: string
				}
				remove?: [...string]
				set?: {
					[string]: string
				}
			}
		}

		// Match conditions to be satisfied for the rule to be activated.
		match?: [...{
			// HTTP Authority values are case-sensitive and formatted as
			// follows: - `exact: "value"` for exact string match - `prefix:
			// "value"` for prefix-based match - `regex: "value"` for RE2
			// style regex-based match
			// (https://github.com/google/re2/wiki/Syntax).
			authority?: ({} | {
				exact: _
			} | {
				prefix: _
			} | {
				regex: _
			}) & {
				exact?:  string
				prefix?: string

				// RE2 style regex-based match
				// (https://github.com/google/re2/wiki/Syntax).
				regex?: string
			}

			// Names of gateways where the rule should be applied.
			gateways?: [...string]

			// The header keys must be lowercase and use hyphen as the
			// separator, e.g.
			headers?: {
				[string]: ({} | {
					exact: _
				} | {
					prefix: _
				} | {
					regex: _
				}) & {
					exact?:  string
					prefix?: string

					// RE2 style regex-based match
					// (https://github.com/google/re2/wiki/Syntax).
					regex?: string
				}
			}

			// Flag to specify whether the URI matching should be
			// case-insensitive.
			ignoreUriCase?: bool

			// HTTP Method values are case-sensitive and formatted as follows:
			// - `exact: "value"` for exact string match - `prefix: "value"`
			// for prefix-based match - `regex: "value"` for RE2 style
			// regex-based match (https://github.com/google/re2/wiki/Syntax).
			method?: ({} | {
				exact: _
			} | {
				prefix: _
			} | {
				regex: _
			}) & {
				exact?:  string
				prefix?: string

				// RE2 style regex-based match
				// (https://github.com/google/re2/wiki/Syntax).
				regex?: string
			}

			// The name assigned to a match.
			name?: string

			// Specifies the ports on the host that is being addressed.
			port?: uint32

			// Query parameters for matching.
			queryParams?: {
				[string]: ({} | {
					exact: _
				} | {
					prefix: _
				} | {
					regex: _
				}) & {
					exact?:  string
					prefix?: string

					// RE2 style regex-based match
					// (https://github.com/google/re2/wiki/Syntax).
					regex?: string
				}
			}

			// URI Scheme values are case-sensitive and formatted as follows:
			// - `exact: "value"` for exact string match - `prefix: "value"`
			// for prefix-based match - `regex: "value"` for RE2 style
			// regex-based match (https://github.com/google/re2/wiki/Syntax).
			scheme?: ({} | {
				exact: _
			} | {
				prefix: _
			} | {
				regex: _
			}) & {
				exact?:  string
				prefix?: string

				// RE2 style regex-based match
				// (https://github.com/google/re2/wiki/Syntax).
				regex?: string
			}

			// One or more labels that constrain the applicability of a rule
			// to source (client) workloads with the given labels.
			sourceLabels?: {
				[string]: string
			}

			// Source namespace constraining the applicability of a rule to
			// workloads in that namespace.
			sourceNamespace?: string

			// The human readable prefix to use when emitting statistics for
			// this route.
			statPrefix?: string

			// URI to match values are case-sensitive and formatted as
			// follows: - `exact: "value"` for exact string match - `prefix:
			// "value"` for prefix-based match - `regex: "value"` for RE2
			// style regex-based match
			// (https://github.com/google/re2/wiki/Syntax).
			uri?: ({} | {
				exact: _
			} | {
				prefix: _
			} | {
				regex: _
			}) & {
				exact?:  string
				prefix?: string

				// RE2 style regex-based match
				// (https://github.com/google/re2/wiki/Syntax).
				regex?: string
			}

			// withoutHeader has the same syntax with the header, but has
			// opposite meaning.
			withoutHeaders?: {
				[string]: ({} | {
					exact: _
				} | {
					prefix: _
				} | {
					regex: _
				}) & {
					exact?:  string
					prefix?: string

					// RE2 style regex-based match
					// (https://github.com/google/re2/wiki/Syntax).
					regex?: string
				}
			}
		}]

		// Mirror HTTP traffic to a another destination in addition to
		// forwarding the requests to the intended destination.
		mirror?: {
			// The name of a service from the service registry.
			host: string
			port?: {
				number?: uint32
			}

			// The name of a subset within the service.
			subset?: string
		}
		mirror_percent?: null | int & <=4294967295 & >=0
		mirrorPercent?:  null | int & <=4294967295 & >=0
		mirrorPercentage?: {
			value?: number
		}

		// Specifies the destinations to mirror HTTP traffic in addition
		// to the original destination.
		mirrors?: [...{
			// Destination specifies the target of the mirror operation.
			destination: {
				// The name of a service from the service registry.
				host: string
				port?: {
					number?: uint32
				}

				// The name of a subset within the service.
				subset?: string
			}
			percentage?: {
				value?: number
			}
		}]

		// The name assigned to the route for debugging purposes.
		name?: string

		// A HTTP rule can either return a direct_response, redirect or
		// forward (default) traffic.
		redirect?: ({} | {
			port: _
		} | {
			derivePort: _
		}) & {
			// On a redirect, overwrite the Authority/Host portion of the URL
			// with this value.
			authority?: string

			// On a redirect, dynamically set the port: *
			// FROM_PROTOCOL_DEFAULT: automatically set to 80 for HTTP and
			// 443 for HTTPS.
			//
			// Valid Options: FROM_PROTOCOL_DEFAULT, FROM_REQUEST_PORT
			derivePort?: "FROM_PROTOCOL_DEFAULT" | "FROM_REQUEST_PORT"

			// On a redirect, overwrite the port portion of the URL with this
			// value.
			port?: uint32

			// On a redirect, Specifies the HTTP status code to use in the
			// redirect response.
			redirectCode?: uint32

			// On a redirect, overwrite the scheme portion of the URL with
			// this value.
			scheme?: string

			// On a redirect, overwrite the Path portion of the URL with this
			// value.
			uri?: string
		}

		// Retry policy for HTTP requests.
		retries?: {
			// Number of retries to be allowed for a given request.
			attempts?: int

			// Timeout per attempt for a given request, including the initial
			// call and any retries.
			perTryTimeout?: string

			// Specifies the conditions under which retry takes place.
			retryOn?: string

			// Flag to specify whether the retries should retry to other
			// localities.
			retryRemoteLocalities?: null | bool
		}

		// Rewrite HTTP URIs and Authority headers.
		rewrite?: {
			// rewrite the Authority/Host header with this value.
			authority?: string

			// rewrite the path (or the prefix) portion of the URI with this
			// value.
			uri?: string

			// rewrite the path portion of the URI with the specified regex.
			uriRegexRewrite?: {
				// RE2 style regex-based match
				// (https://github.com/google/re2/wiki/Syntax).
				match?: string

				// The string that should replace into matching portions of
				// original URI.
				rewrite?: string
			}
		}

		// A HTTP rule can either return a direct_response, redirect or
		// forward (default) traffic.
		route?: [...{
			// Destination uniquely identifies the instances of a service to
			// which the request/connection should be forwarded to.
			destination: {
				// The name of a service from the service registry.
				host: string
				port?: {
					number?: uint32
				}

				// The name of a subset within the service.
				subset?: string
			}
			headers?: {
				request?: {
					add?: {
						[string]: string
					}
					remove?: [...string]
					set?: {
						[string]: string
					}
				}
				response?: {
					add?: {
						[string]: string
					}
					remove?: [...string]
					set?: {
						[string]: string
					}
				}
			}

			// Weight specifies the relative proportion of traffic to be
			// forwarded to the destination.
			weight?: int
		}]

		// Timeout for HTTP requests, default is disabled.
		timeout?: string
	}]

	// An ordered list of route rules for opaque TCP traffic.
	tcp?: [...{
		// Match conditions to be satisfied for the rule to be activated.
		match?: [...{
			// IPv4 or IPv6 ip addresses of destination with optional subnet.
			destinationSubnets?: [...string]

			// Names of gateways where the rule should be applied.
			gateways?: [...string]

			// Specifies the port on the host that is being addressed.
			port?: uint32

			// One or more labels that constrain the applicability of a rule
			// to workloads with the given labels.
			sourceLabels?: {
				[string]: string
			}

			// Source namespace constraining the applicability of a rule to
			// workloads in that namespace.
			sourceNamespace?: string
			sourceSubnet?:    string
		}]

		// The destination to which the connection should be forwarded to.
		route?: [...{
			// Destination uniquely identifies the instances of a service to
			// which the request/connection should be forwarded to.
			destination: {
				// The name of a service from the service registry.
				host: string
				port?: {
					number?: uint32
				}

				// The name of a subset within the service.
				subset?: string
			}

			// Weight specifies the relative proportion of traffic to be
			// forwarded to the destination.
			weight?: int
		}]
	}]

	// An ordered list of route rule for non-terminated TLS & HTTPS
	// traffic.
	tls?: [...{
		// Match conditions to be satisfied for the rule to be activated.
		match: [...{
			// IPv4 or IPv6 ip addresses of destination with optional subnet.
			destinationSubnets?: [...string]

			// Names of gateways where the rule should be applied.
			gateways?: [...string]

			// Specifies the port on the host that is being addressed.
			port?: uint32

			// SNI (server name indicator) to match on.
			sniHosts: [...string]

			// One or more labels that constrain the applicability of a rule
			// to workloads with the given labels.
			sourceLabels?: {
				[string]: string
			}

			// Source namespace constraining the applicability of a rule to
			// workloads in that namespace.
			sourceNamespace?: string
		}]

		// The destination to which the connection should be forwarded to.
		route?: [...{
			// Destination uniquely identifies the instances of a service to
			// which the request/connection should be forwarded to.
			destination: {
				// The name of a service from the service registry.
				host: string
				port?: {
					number?: uint32
				}

				// The name of a subset within the service.
				subset?: string
			}

			// Weight specifies the relative proportion of traffic to be
			// forwarded to the destination.
			weight?: int
		}]
	}]
}