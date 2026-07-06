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
    @State private var selectedMode: MapNavigationMode = .singleFloor
    
    enum NavigationState {
        case home
        case map
    }
    
    var body: some View {
        ZStack {
            switch navigationState {
            case .home:
                HomeView(
                    onPermissionsGranted: { mode in
                        selectedMode = mode
                        RetailBrainManager.shared.initialize(config: mode.sdkConfig)
                        StoreLocations.setupStoreShoppingItems(for: mode)
                        navigationState = .map
                    }
                )
            case .map:
                MapPageView(
                    mode: selectedMode,
                    onBack: {
                        navigationState = .home
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
