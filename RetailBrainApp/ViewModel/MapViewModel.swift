//
//  MapViewModel.swift
//  RetailBrainApp
//
//  Created by muhammed.nadeem.m.a on 03/07/26.
//

import Combine
import Foundation
import RetailBrainSDK

enum NavigationState {
    case home
    case map
}

final class MapViewModel: ObservableObject {

    @Published var navigationState: NavigationState = .home

    init() {
        initializeSDK()
    }

    private func initializeSDK() {
        RetailBrainManager.shared.delegate = self
        // 1. Setup store shopping items in the app
        StoreLocations.setupStoreShoppingItems()
        // 2. Initialize RetailBrainSDK with map configuration
        RetailBrainManager.shared.initialize(
            config: RetailBrainConfig(
                apiKey: MapConfig.apiKey,
                apiSecret: MapConfig.apiSecret,
                mapId: MapConfig.mapId
            )
        )
    }

}

// MARK: RetailBrainSDKDelegate
extension MapViewModel: RetailBrainSDKDelegate {

    func sdkDidInitialize() {
        print("App Callback: SDK initialized")
    }

    func sdkDidFailToInitialize(error: Error) {
        print("App Callback: SDK initialization failed - \(error.localizedDescription)")
    }

    func mapDidLoad() {
        print("App Callback: Map loaded")
    }

    func mapDidFailToLoad(error: Error) {
        print("App Callback: Map failed to load - \(error.localizedDescription)")
    }

    func addProductToMap() {
        print("App Callback: Product list added/updated")
    }

    func didSelectItem(_ item: StoreItem) {
        print("App Callback: Selected item - \(item.name) at \(item.locationName)")
    }

    func didDeselectItem(_ item: StoreItem) {
        print("App Callback: Deselected item - \(item.name) at \(item.locationName)")
    }

    func routeCalculationStarted() {
        print("App Callback: Route calculation started")
    }

}
