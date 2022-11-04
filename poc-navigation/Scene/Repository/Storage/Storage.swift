//
//  Storage.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Foundation

class AnyStorage<StorageType>: Storage {
    
    private let save: (_ model: StorageType) -> Void
    
    init<T: Storage>(wrappedStore: T) where T.StorageType == StorageType {
        self.save = wrappedStore.save(_:)
    }
    
    func save(_ model: StorageType) {
        save(model)
    }
}

protocol Storage {
    associatedtype StorageType
    func save(_ model: StorageType)
}

extension Storage {
    func ereaseToAnyStorage() -> AnyStorage<StorageType> {
        return self as? AnyStorage<StorageType> ?? AnyStorage(wrappedStore: self)
    }
}
