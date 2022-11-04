//
//  Storage.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Combine

class AnyStorage<StorageType>: Storage {
    
    private let _save: (_ model: StorageType) -> Void
    private let _restore: AnyPublisher<StorageType, Never>
    
    init<T: Storage>(wrappedStore: T) where T.StorageType == StorageType {
        _save = wrappedStore.save(_:)
        _restore = wrappedStore.restore()
    }
    
    func save(_ model: StorageType) {
        _save(model)
    }
    func restore() -> AnyPublisher<StorageType, Never> {
        return _restore
    }
}

protocol Storage {
    associatedtype StorageType
    func save(_ model: StorageType)
    func restore() -> AnyPublisher<StorageType, Never>
}

extension Storage {
    func ereaseToAnyStorage() -> AnyStorage<StorageType> {
        return self as? AnyStorage<StorageType> ?? AnyStorage(wrappedStore: self)
    }
}
