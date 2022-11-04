//
//  NavigationViewModel.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import Combine
import Foundation

struct NavigationSectionViewState {
    var loading: Bool = true
    var title: String = ""
    var count: Int = 0
}


@MainActor
class NavigationViewModel: ObservableObject {
    
    @Published
    var stateModel = NavigationSectionViewState()
    
    let interactor: NavigationInteractor
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        interactor: NavigationInteractor
    ) {
        self.interactor = interactor
    }
    
    
    func load() {
        stateModel.loading = true
        interactor
            .fetchDatas()
            .receive(on: DispatchQueue.main)
            .sink { error in
                switch error {
                case .failure(let error):
                    print(error.localizedDescription)
                default: break
                }
            } receiveValue: { navigationSectionModel in
                self.convertStateModel(navigationSectionModel: navigationSectionModel)
            }
            .store(in: &cancellables)

    }
    
    func addCount() {
        stateModel.count += 1
        interactor.save(navigationSectionModel: mapperStateModelTo())
    }
    
    private func mapperStateModelTo() -> NavigationSectionModel {
        .init(name: stateModel.title, id: "aaa", count: stateModel.count)
    }
    
    private func convertStateModel(
        navigationSectionModel: NavigationSectionModel,
        isLoading: Bool = false
    ) {
        stateModel = NavigationSectionViewState(loading: isLoading, title: navigationSectionModel.name, count: navigationSectionModel.count)
    }
}
