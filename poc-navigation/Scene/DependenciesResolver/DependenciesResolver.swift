//
//  DependenciesResolver.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 10/11/22.
//

import Foundation

protocol DependenciesResolver {
    func getApi() -> API
    func getNavigationSectionInteractor() -> NavigationInteractor //useCase
    func getNavigationStorage() -> AnyStorage<NavigationSectionModel>
    
    @MainActor
    func getNavigationViewModel() -> NavigationViewModel
}

/// Optional or Commumn
extension DependenciesResolver {
    @MainActor
    func getNavigationViewModel() -> NavigationViewModel {
        NavigationViewModel(interactor: getNavigationSectionInteractor())
    }
    
    func getNavigationSectionInteractor() -> NavigationInteractor {
        NavigationSectionInteractor(storage: getNavigationStorage(), api: getApi())
    }
}

class HomeDepenciesResolver: DependenciesResolver {
    
    func getApi() -> API {
        HomeAPI()
    }
    
    func getNavigationStorage() -> AnyStorage<NavigationSectionModel> {
        HomeStorage().ereaseToAnyStorage()
    }
}

class HubSellerDepenciesResolver: DependenciesResolver {
    func getApi() -> API {
        HubSellerAPI()
    }
    
    func getNavigationStorage() -> AnyStorage<NavigationSectionModel> {
        HubSellerStorage().ereaseToAnyStorage()
    }
}


///DependenciesResolverManager ser apenas un Builder
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
