/* 
 John Sundell Article - The Power of Result Types in Swift
 https://www.swiftbysundell.com/posts/the-power-of-result-types-in-swift?rq=Result
 */

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

enum Result<V> {
    case success(V)
    case failure(Error)
}

typealias StringResult = (Result<String>) -> Void

func load(then handler: @escaping StringResult) {
    let successString = "Woo!"
    handler(.success(successString))
}

load { (result) in
    switch result {
        case .success(let data):
        // handle success data
        print(data)
        case .failure(let error):
        // handle error
            print(error.localizedDescription)
    }
}

