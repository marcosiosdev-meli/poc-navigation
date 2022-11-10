//
//  DependenciesResolver.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 10/11/22.
//

import Foundation

protocol DependenciesResolver {
    func getApi() -> API
    func getNavigationSectionInteractor() -> NavigationInteractor
    func getNavigationStorage() -> AnyStorage<NavigationSectionModel>
    
    @MainActor
    func getNavigationViewModel() -> NavigationViewModel
}


class HomeDepenciesResolver: DependenciesResolver {
    
    func getApi() -> API {
        HomeAPI()
    }
    
    func getNavigationStorage() -> AnyStorage<NavigationSectionModel> {
        HomeStorage().ereaseToAnyStorage()
    }
    
    func getNavigationSectionInteractor() -> NavigationInteractor {
        NavigationSectionInteractor(storage: getNavigationStorage(), api: getApi())
    }
    
    @MainActor
    func getNavigationViewModel() -> NavigationViewModel {
        NavigationViewModel(interactor: getNavigationSectionInteractor())
    }
}

class HubSellerDepenciesResolver: DependenciesResolver {
    func getApi() -> API {
        HubSellerAPI()
    }
    
    func getNavigationStorage() -> AnyStorage<NavigationSectionModel> {
        HubSellerStorage().ereaseToAnyStorage()
    }
    
    func getNavigationSectionInteractor() -> NavigationInteractor {
        NavigationSectionInteractor(storage: getNavigationStorage(), api: getApi())
    }
    
    @MainActor
    func getNavigationViewModel() -> NavigationViewModel {
        NavigationViewModel(interactor: getNavigationSectionInteractor())
    }
}


@MainActor
struct DependenciesResolverManager {
    func build(with navigationType: NavigationSectionType) -> DependenciesResolver {
        switch navigationType {
        case .home:
            return HomeDepenciesResolver()
        case .hubSeller:
            return HubSellerDepenciesResolver()
        }
    }
}
