//
//  NavigationSwiftUI.swift
//  poc-navigation
//
//  Created by Marcos Felipe Souza Pinto on 01/11/22.
//

import SwiftUI

struct NavigationSectionsView: View {
    
    @ObservedObject
    var viewModel: NavigationViewModel
    
    var body: some View {
        ZStack {
            if viewModel.stateModel.loading {
                loadingView
            } else {
                containerView
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
    
    
    var containerView: some View {
        VStack(spacing: 8) {
            Text(viewModel.stateModel.title)
                .font(.largeTitle)
            Spacer()
            
            Text("Count = \(viewModel.stateModel.count)")
                .font(.headline)
            
            Button("Add Count") {
                viewModel.addCount()
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
    
    var loadingView: some View {
        Text("Loading ... ")
    }
}
