//
//  NavigationSectionInteractor.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 03/11/22.
//

import Combine
import Foundation

enum NavigationSectionError: Error {
    case network
}

protocol NavigationInteractor: AnyObject {
    func fetchDatas() -> AnyPublisher<NavigationSectionModel, NavigationSectionError>
    func save(navigationSectionModel: NavigationSectionModel)
}

class NavigationSectionInteractor: NavigationInteractor {
    
    private let storage: AnyStorage<NavigationSectionModel>
    private let api: API
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        storage: AnyStorage<NavigationSectionModel>,
        api: API
    ) {
        self.storage = storage
        self.api = api
    }
    
    func fetchDatas() -> AnyPublisher<NavigationSectionModel, NavigationSectionError> {
        let loadApi = Future<NavigationSectionModel, Never> { promise in
            Task {
                let model = await self.api.load()
                promise(.success(model))
            }
        }.eraseToAnyPublisher()
        
        return loadApi.combineLatest(storage.restore())
            .mapError({ _ in
                NavigationSectionError.network
            })
            .map({ loadApi, storage in
                loadApi.count > storage.count ?
                loadApi :
                storage
            })
            .eraseToAnyPublisher()
    }
    
    func save(navigationSectionModel: NavigationSectionModel) {
        storage.save(navigationSectionModel)
    }
}
