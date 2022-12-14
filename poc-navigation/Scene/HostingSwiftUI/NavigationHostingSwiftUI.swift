//
//  NavigationHostingSwiftUI.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import SwiftUI

class NavigationHostingSwiftUI: UIHostingController<NavigationSectionsView> {
    init(_ dependenciesResolver: DependenciesResolver) {
        let viewModel = dependenciesResolver.getNavigationViewModel()
        let rootView = NavigationSectionsView(viewModel: viewModel)
        super.init(rootView: rootView)
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
