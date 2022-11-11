//
//  NavigationSectionModel.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 11/11/22.
//

import Foundation

struct NavigationSectionModel: Codable {
    let name: String
    let id: String
    var count: Int = 0
    
    init(
        name: String = "",
        id: String = UUID().uuidString,
        count: Int = 0
    ) {
        self.name = name
        self.id = id
        self.count = count
    }
}
