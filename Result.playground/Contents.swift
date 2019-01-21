/* 
 John Sundell Article - The Power of Result Types in Swift
 https://www.swiftbysundell.com/posts/the-power-of-result-types-in-swift?rq=Result
 */

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - Result Type
enum Result<Value> {
    case success(Value)
    case failure(Error)
}

enum TestError: Error {
    case noResult
    case sorryICantDoThatDave
}

// MARK: - Result Example
typealias StringResult = Result<String>
typealias StringResultHandler = (StringResult) -> Void

func testResult(asError: Bool, with handler: @escaping StringResultHandler) {
    if asError {
        handler(.failure(TestError.noResult))
        return
    }
    handler(.success("Woo!"))
}

func process(_ result: StringResult) {
    switch result {
    case .success(let data):
        // handle success data
        print(data)
    case .failure(let error):
        // handle error
        print(error)
    }
}

testResult(asError: false) { (result) in
    process(result)
}

testResult(asError: true) { (result) in
    process(result)
}

// MARK: - Typed Errors
/*
 Using the below we have to specify the type of error a failure will kick back
 */
enum TypedErrorResult<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

// Example
typealias TestErrorResult = TypedErrorResult<String, TestError>
typealias TypedErrorHandler = (TypedErrorResult<String, TestError>) -> Void
  
 func testTypedErrorResult(asError: Bool, with handler: @escaping TypedErrorHandler) {
    if asError {
        handler(.failure(TestError.sorryICantDoThatDave))
        return
    }
    handler(.success("Woo!"))
  }

func process(_ result: TestErrorResult) {
    switch result {
        case .success(let data): print(data)
        case .failure(let error): 
            switch error {
                case .noResult: print("Nada")
                case .sorryICantDoThatDave: print("DAAAAAAA DAAAAAA DA DAAAAAAAA! DUM DUM DUM DUM")
            }
    }
}

testTypedErrorResult(asError: false) { (result) in
    process(result)
}

testTypedErrorResult(asError: true) { (result) in
    process(result)
}


// MARK: - Extending Result to Throw!
// Very useful in tests and in general reducing boilerplate (e.g. the process functions above)
extension Result {
    func resolve() throws -> Value {
        switch self {
            case .success(let value): return value
            case .failure(let error): throw error
        }
    }
}

// MARK: - Extending Result for decoding JSON if result value type is data!
// Very useful in network requests!
extension Result where Value == Data {
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        let data = try resolve()
        return try decoder.decode(T.self, from: data)
    }
}

  
