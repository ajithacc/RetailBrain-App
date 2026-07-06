//
//  RetailBrainAppApp.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

final class RetailBrainCallbacks: RetailBrainSDKDelegate {
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

@main
struct RetailBrainApp: App {
    private let sdkCallbacks = RetailBrainCallbacks()

    init() {
        RetailBrainManager.shared.delegate = sdkCallbacks

        // 1. Setup initial shopping items; Home selection will update this per mode.
        StoreLocations.setupStoreShoppingItems(for: .singleFloor)

        // 2. Initialize RetailBrainSDK with map configuration
        RetailBrainManager.shared.initialize(config: MapNavigationMode.singleFloor.sdkConfig)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
