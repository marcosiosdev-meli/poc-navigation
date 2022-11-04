//
//  NavigationSectionInteractor.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 03/11/22.
//

import Combine

struct NavigationSection: Codable {
    let name: String
    let id: String
}

enum NavigationSectionError: Error {
    case network
}

protocol NavigationInteractor: AnyObject {
    func fetchDatas() -> AnyPublisher<NavigationSection, NavigationSectionError>
}

class NavigationSectionInteractor: NavigationInteractor {
    
    private let storage: AnyStorage<Int>
    private let api: API
    
    init(
        storage: AnyStorage<Int>,
        api: API
    ) {
        self.storage = storage
        self.api = api
    }
    
    func fetchDatas() -> AnyPublisher<NavigationSection, NavigationSectionError> {
        
    }
}
