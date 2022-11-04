//
//  API.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Foundation

protocol API {
    func load() async -> String
}

class APIImpl: API {
    func load() async -> String {
        print("Loading")
        return "Default"
    }
}

class HomeAPI: APIImpl {
    override func load() async -> String {
        return await withCheckedContinuation { continuation in
            print("Loading with queryParams mp_home and config mp_home")            
            sleep(4)
            continuation.resume(with: .success("Olá Home"))
        }
    }
}

class HubSellerAPI: APIImpl {
    override func load() async -> String {
        print("Loading with queryParams mp_seller and Config mp_seller")
        return "Seller"
    }
}
