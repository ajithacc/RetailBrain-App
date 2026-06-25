//
//  RetailBrainAppApp.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

@main
struct RetailBrainApp: App {

    init() {
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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
