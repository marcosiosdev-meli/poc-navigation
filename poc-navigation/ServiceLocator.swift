//
//  ServiceLocator.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Foundation

protocol ServiceLocator {
    func getService<T>() -> T?
}

final class BasicServiceLocator: ServiceLocator {

    /// Service registry
    /// [Type: Any]
    /// Sample: [MyProtocol: MyClassImplementation]
    private lazy var reg: Dictionary<String, Any> = [:]

    private func typeName(some: Any) -> String {        
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    func addService<T>(_ service: T) {
        let key = typeName(some: T.self)
        reg[key] = service
        print("Service added: KEY \(key) / ? \(typeName(some: service)) Y Service = \(service)")
    }
    
    @discardableResult
    func with(_ configure: (inout Self) -> Void) -> Self {
        var this = self
        configure(&this)
        return this
    }
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return reg[key] as? T
    }
}
