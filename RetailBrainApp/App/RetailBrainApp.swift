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
