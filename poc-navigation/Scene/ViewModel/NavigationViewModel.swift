//
//  NavigationViewModel.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Combine

struct NavigationSectionViewData {
    var loading: Bool = true
    var title: String = ""
    var count: Int = 0
}


@MainActor
class NavigationViewModel: ObservableObject {
    
    @Published
    var stateModel = NavigationSectionViewData()
    
    let storage: AnyStorage<NavigationSectionModel>
    let api: API
    
    init(
        storage: AnyStorage<NavigationSectionModel>,
        api: API
    ) {
        self.storage = storage
        self.api = api
    }
    
    init(
        serviceLocator: ServiceLocator
    ) {
        self.storage = serviceLocator.getService()!
        self.api = serviceLocator.getService()!
    }
    
    func load() {
        Task {
            stateModel.loading = true
            let load = await api.load()
            stateModel = NavigationSectionViewData(loading: false, title: load.name, count: load.count)            
            stateModel.loading = false
        }
    }
    
    func addCount() {
        stateModel.count += 1
        let model = NavigationSectionModel(name: stateModel.title, id: "0", count: stateModel.count)
        storage.save(model)
    }
}
