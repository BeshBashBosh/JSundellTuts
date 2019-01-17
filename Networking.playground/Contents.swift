import Foundation

// Schemes
enum URLSchemes: String {
    case http, https
}

// Constructing URLs
func constructURLComponentsFrom(scheme: URLSchemes, host: String, path: String) -> URLComponents {
    var components = URLComponents()
    components.scheme = scheme.rawValue
    components.host = host
    components.path = path
    return components
}

let urlComponents = constructURLComponentsFrom(scheme: .https, 
                                               host: "api.github.com",
                                               path: "/users/beshbashbosh")
print(urlComponents.url)




