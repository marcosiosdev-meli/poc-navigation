//
//  ViewController.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapTwoButton(_ sender: Any) {
        let hubSeller = NavigationSectionsViewController(dictionary: ["pageId": "2"])
        navigationController?.pushViewController(hubSeller, animated: true)
        
    }
    @IBAction func didTapOneButton(_ sender: Any) {
        let home = NavigationSectionsViewController(dictionary: ["pageId": "1"])
        navigationController?.pushViewController(home, animated: true)
    }
    
}

