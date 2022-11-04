//
//  PrintStorage.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Combine

class PrintStorage: Storage {
    
    var idSave = "home"
    var modelSaved: NavigationSectionModel?
    
    init(idSave: String) {
        self.idSave = idSave
    }
    
    func restore() -> AnyPublisher<NavigationSectionModel, Never> {
        return Future<NavigationSectionModel, Never> { promise in
            print("get object by: _\(self.idSave)_")
            promise(.success(self.modelSaved ?? NavigationSectionModel(name: "Section-BANK-\(self.idSave)")))
        }.eraseToAnyPublisher()
    }
    
    func save(_ model: NavigationSectionModel) {
        print("_\(idSave)_: \(model)")
        modelSaved = model
    }
}

class HomePrintStorage: PrintStorage {
    init() {
        super.init(idSave: "home")
    }
}

class HubSellerPrintStorage: PrintStorage {
    
    init() {
        super.init(idSave: "hub_seller")
    }
    
    override func save(_ model: NavigationSectionModel) {
        print("_\(idSave)_: \(model)")
        modelSaved = model
    }
}
