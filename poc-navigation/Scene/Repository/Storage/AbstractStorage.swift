//
//  AbstractStorage.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 10/11/22.
//
import Combine
import Foundation

struct StorageCapsule {
    var id: String
    var content: NavigationSectionModel?
}


class AbstractStorage: Storage {
    
    var idSave = ""
    static var modelSaved: StorageCapsule?
    
    init(idSave: String) {
        self.idSave = idSave
    }
    
    func restore() -> AnyPublisher<NavigationSectionModel, Never> {
        return Future<NavigationSectionModel, Never> { promise in
            print("get object by: _\(self.idSave)_")
            let mapperModelSavedById = AbstractStorage.modelSaved.flatMap {
                $0.id == self.idSave ? $0.content : nil
            }
            promise(.success(mapperModelSavedById ?? NavigationSectionModel(name: "Section-BANK-\(self.idSave)")))
        }.eraseToAnyPublisher()
    }
    
    func save(_ model: NavigationSectionModel) {
        print("_\(idSave)_: \(model)")
        AbstractStorage.modelSaved = StorageCapsule(id: idSave, content: model)
    }
}

class HomeStorage: AbstractStorage {
    init() {
        super.init(idSave: "home")
    }
}

class HubSellerStorage: AbstractStorage {    
    init() {
        super.init(idSave: "hub_seller")
    }
}
