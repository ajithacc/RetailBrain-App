//
//  RetailBrainAppApp.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI

@main
struct RetailBrainApp: App {
    init() {
        // 1. Setup initial shopping items; Home selection will update this per mode.
        StoreLocations.setupStoreShoppingItems(for: .singleFloor)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
