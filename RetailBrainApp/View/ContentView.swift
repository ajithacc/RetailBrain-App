//
//  ContentView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

struct ContentView: View {
    @State private var navigationState: NavigationState = .home
    
    enum NavigationState {
        case home
        case map
    }
    
    var body: some View {
        ZStack {
            switch navigationState {
            case .home:
                HomeView(
                    onPermissionsGranted: {
                        navigationState = .map
                    }
                )
            case .map:
                MapPageView()
            }
        }
    }
}

struct RetailMapViewContainer: View {
    @Binding var isSheetPresented: Bool
    let routingController: MapRoutingController
    
    var body: some View {
        RetailMapView(routingController: routingController)
    }
}


#Preview {
    ContentView()
}
