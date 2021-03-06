import Foundation

// Enable async execution support for playground
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// Schemes
enum URLSchemes: String {
    case http, https
}

// Constructing URLs
struct NetworkResponse {
    let request: URL?
    let mimeType: String
    let header: [AnyHashable: Any]
    let statusCode: Int
    let statusDescription: String
    
    init(_ httpResponse: HTTPURLResponse) {
        request = httpResponse.url
        mimeType = httpResponse.mimeType ?? ""
        header = httpResponse.allHeaderFields
        statusCode = httpResponse.statusCode
        statusDescription = HTTPURLResponse.localizedString(forStatusCode: statusCode)
        debugPrint(httpResponse)
    }
}

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
print(urlComponents.url ?? "")

// Network Request with URLSession
func createDataTaskFrom(_ components: URLComponents, with session: URLSession) -> URLSessionDataTask {
    guard let url = urlComponents.url else {
        preconditionFailure("Failed to construct url")
    }
    
    let task = session.dataTask(with: url) {
        data, response, error in
        // data - the data in bytes returned from request (nil if error)
        // response - basic response info such as MIME and data encoding
        // can be typecast as HTTPURLResponse to get HTTP-specific info (e.g. status code)
        // error - error if request failed, nil if not
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        let res = NetworkResponse(response as! HTTPURLResponse)
        debugPrint(res.header)
        
        let dataAsString = String(data: data!, encoding: .utf8)
        print(dataAsString)
    }
    return task
}

let task = createDataTaskFrom(urlComponents, with: URLSession.shared)
task.resume()





