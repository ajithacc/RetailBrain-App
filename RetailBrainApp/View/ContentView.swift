//
//  ContentView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

struct ContentView: View {
    @StateObject private var routingController = MapRoutingController()
    @State private var showSheet = false
    @State private var hasShownInitialSheet = false

    var body: some View {
        RetailMapView(
            routingController: routingController,
            onMapLoaded: {
                guard !hasShownInitialSheet else { return }
                hasShownInitialSheet = true
                showSheet = true
            }
        )
        .ignoresSafeArea()
        .sheet(isPresented: $showSheet) {
            ItemSelectionSheet(items: StoreLocations.shoppingItems) { selectedItems in
                showSheet = false

                let storeNames = Array(Set(selectedItems.map { $0.storeName }))
                routingController.routeToStores(storeNames)
            }
        }
    }
}
