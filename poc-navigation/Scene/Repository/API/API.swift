//
//  API.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Foundation

protocol API {
    func load() async -> NavigationSectionModel
}
