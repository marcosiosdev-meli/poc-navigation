//
//  PrintStorage.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Foundation

class PrintStorage: Storage {
    func save(_ model: Int) {
        print("Saved \(model)")
    }
}

class HomePrintStorage: PrintStorage {}

class HubSellerPrintStorage: PrintStorage {
    override func save(_ model: Int) {
        print("Saved on key = hubSeller_\(model)")
    }
}
