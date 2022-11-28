//
//  ViewController.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mlCommon: MLCommon = {
        guard let navigationController = self.navigationController else {
            return MLCommon(navigationController: UINavigationController())
        }
        let mlCommon = MLCommon(navigationController: navigationController)
        return mlCommon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mlCommon.registry(host: "/home", type: NavigationSectionsDeeplinkView.self)
        mlCommon.registry(host: "/hubseller", type: HubSellerView.self)
    }
    @IBAction func didTapTwoButton(_ sender: Any) {
//        let hubSeller = NavigationSectionsViewController(dictionary: ["pageId": "2"])
//        navigationController?.pushViewController(hubSeller, animated: true)
        mlCommon.getView(deeplink: "mercadopago://hubseller?pageId=2")
        
    }
    @IBAction func didTapOneButton(_ sender: Any) {
//        let home = NavigationSectionsViewController(dictionary: ["pageId": "1"])
//        navigationController?.pushViewController(home, animated: true)
        mlCommon.getView(deeplink: "mercadopago://home?pageId=1")
    }
    
}



protocol DeeplinkViewer {
    init(deeplink: [AnyHashable: Any])
    
    func anyView() -> AnyView
}
extension DeeplinkViewer where Self: View {
    func anyView() -> AnyView {
        return AnyView(self)
    }
}

import SwiftUI
class MLCommon {
    
    private lazy var reg: Dictionary<String, DeeplinkViewer.Type> = [:]
    private let navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func registry(host: String, type: DeeplinkViewer.Type) {
        reg[host] = type
    }
    
    func getView(deeplink: String){
        
        guard let urlComponents = URLComponents(string: deeplink) else { return }
        var params = [AnyHashable: Any]()
        urlComponents.queryItems?.forEach({ queryItem in
            params[queryItem.name] = queryItem.value
        })
         
        guard let host = urlComponents.host,
              let deeplinkViewer = reg["/\(host)"] else {
            return
        }
        
        let view = deeplinkViewer.init(deeplink: params)
        let viewControllerOfView = UIHostingController(rootView: view.anyView())

        navigationController.pushViewController(viewControllerOfView, animated: true)
    }
}
