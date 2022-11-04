//
//  NavigationBehaviorController.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import SwiftUI
import UIKit

class NavigationSectionsViewController: UIViewController {
    
    let dictionary: [AnyHashable : Any]
    var navigationSectionType: NavigationSectionType = .home
    
    init(dictionary: [AnyHashable : Any]){
        self.dictionary = dictionary
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup navigationType
        if let pageId = dictionary["pageId"] as? String {
            navigationSectionType = NavigationSectionType(rawValue: pageId) ?? .home
        }
        
        // build serviceLocator
        let serviceLocator =
            ServiceLocatorManager()
                .build(with: navigationSectionType)
        
        // build view
        let viewController = NavigationHostingSwiftUI(serviceLocator)        
        add(viewController)
        
        // setup constraints to all edges
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            view.widthAnchor.constraint(equalTo: viewController.view.widthAnchor),
            view.heightAnchor.constraint(equalTo: viewController.view.heightAnchor),
        ])
    }
}

@MainActor 
struct ServiceLocatorManager {
    
    func build(with navigationType: NavigationSectionType) -> ServiceLocator {
        switch navigationType {
        case .home:
            return buildHome()
        case .hubSeller:
            return buildHubSeller()
        }
    }
    
    func buildHome() -> BasicServiceLocator {
        let serviceLocator = BasicServiceLocator()
        serviceLocator.addService(HomeAPI() as API)
        serviceLocator.addService(HomePrintStorage().ereaseToAnyStorage() as AnyStorage)
        serviceLocator.addService(
            NavigationViewModel(
                storage: serviceLocator.getService()!,
                api: serviceLocator.getService()!))
        return serviceLocator
    }
    
    func buildHubSeller() -> BasicServiceLocator {
        let serviceLocator = BasicServiceLocator()
        serviceLocator.addService(HubSellerAPI() as API)
        serviceLocator.addService(HubSellerPrintStorage().ereaseToAnyStorage() as AnyStorage)
        serviceLocator.addService(
            NavigationViewModel(
                storage: serviceLocator.getService()!,
                api: serviceLocator.getService()!))
        return serviceLocator
    }
    
}

enum NavigationSectionType: String {
    case home
    case hubSeller
    init?(rawValue: String) {
        switch rawValue {
        case "1": self = .home
        case "2": self = .hubSeller
        default: return nil
        }
    }
}
