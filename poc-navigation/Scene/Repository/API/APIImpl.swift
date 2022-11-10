//
//  APIImpl.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 10/11/22.
//

import Foundation

class APIImpl: API {
    func load() async -> NavigationSectionModel {
        print("Loading")
        return NavigationSectionModel(name: "Section", id: "00", count: 2)
    }
}

class HomeAPI: APIImpl {
    override func load() async -> NavigationSectionModel {
        return await withCheckedContinuation { continuation in
            print("Loading with queryParams mp_home and config mp_home")
            sleep(4)
            let model = NavigationSectionModel(name: "Section-home", id: "1", count: 2)
            continuation.resume(with: .success(model))
        }
    }
}

class HubSellerAPI: APIImpl {
    override func load() async -> NavigationSectionModel {
        return await withCheckedContinuation { continuation in
            print("Loading with queryParams mp_seller and Config mp_seller")
            sleep(2)
            let model = NavigationSectionModel(name: "Section-hub-seller", id: "1", count: 3)
            continuation.resume(with: .success(model))
        }
    }
}
