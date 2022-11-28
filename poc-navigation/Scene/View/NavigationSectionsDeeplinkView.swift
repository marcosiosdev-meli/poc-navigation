//
//  NavigationSectionsDeepLinkView.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 24/11/22.
//

import SwiftUI

struct NavigationSectionsDeeplinkView: View, DeeplinkViewer {
    
    private var deepLink = ""
    
    init(deeplink: [AnyHashable: Any]) {
        self.deepLink = deeplink["pageId"] as! String
        print(self.deepLink)
    }
    
    var body: some View {
        HStack {
            Text(" Soy View = ") + Text(deepLink)
        }
    }
}

struct HubSellerView: View, DeeplinkViewer {
    
    @State
    private var count = 0
    
    init(deeplink: [AnyHashable: Any]) {
        print(deeplink["pageId"] as! String)
    }
    
    var body: some View {
        VStack {
            Text("Ola Mundo : ")
                .font(.largeTitle)
             +
            Text("\(count)")
                .font(.headline)
            
            Button {
                count += 1
            } label: {
                Text("Tap Me")
            }.buttonStyle(.bordered)
        }
    }
}
