//
//  ContentView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

struct ContentView: View {

    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            switch viewModel.navigationState {
            case .home:
                HomeView(
                    onPermissionsGranted: {
                        viewModel.navigationState = .map
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
