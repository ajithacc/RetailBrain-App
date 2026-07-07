//
//  ContentView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

struct ContentView: View {
    
    // @State private var selectedMode: MapNavigationMode = .singleFloor
    
    enum NavigationState {
        case home
        case map
    }

    @StateObject private var viewModel = MapViewModel()

    var body: some View {
        ZStack {
            switch viewModel.navigationState {
            case .home:
                HomeView(viewModel: viewModel)
            case .map:
                MapPageView(
                    mode: viewModel.selectedMode,
                    onBack: {
                        viewModel.navigationState = .home
                    }
                )
            }
        }
    }
}

struct RetailMapViewContainer: View {
    @Binding var isSheetPresented: Bool
    let routingController: MapRoutingController
    let mapId: String
    let isMultiFloorMode: Bool
    
    var body: some View {
        RetailMapView(
            routingController: routingController,
            mapId: mapId,
            isMultiFloorMode: isMultiFloorMode
        )
    }
}
#Preview {
    ContentView()
}
