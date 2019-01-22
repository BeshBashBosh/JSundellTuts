/* 
 John Sundell - Under the Hood of Futures & Promises
 https://www.swiftbysundell.com/posts/under-the-hood-of-futures-and-promises-in-swift
 */

import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// What is a Future and Promise?
/*
 - Promise - something you make to someone else (gets contructed)
 - Future - In the future you choose to honor (resolve) that promise, or reject it.
 
 Futures and Promises are very useful for organising logic of async code
 */

enum Result<Value, Error: Swift.Error> {
    case success(Value)
    case failure(Error)
}

extension Result {
    func resolve() throws -> Value {
        switch self {
            case .success(let value): return value
            case .failure(let error): throw error
        }
    }
}

let session = URLSession()

//  
//  class UserLoader {
//      typealias Handler = (Result<)
//  }
