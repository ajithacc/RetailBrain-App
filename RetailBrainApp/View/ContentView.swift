//
//  ContentView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 22/06/26.
//

import SwiftUI
import RetailBrainSDK

struct ContentView: View {
    
    @State private var showSheet = false
    @StateObject private var routingController = MapRoutingController()
    
    var body: some View {
        ZStack {
            RetailMapViewContainer(
                isSheetPresented: $showSheet,
                routingController: routingController
            )
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showSheet) {
            ItemSelectionSheet(items: StoreLocations.shoppingItems) { selectedItems in
                showSheet = false

                let routeAliases = selectedItems.map { item in
                    item.name == item.storeName ? item.storeName : "\(item.storeName)|\(item.name)"
                }
                routingController.routeToStores(routeAliases)
            }
        }
    }
}

/// A container that manages the map view and handles routing
private struct RetailMapViewContainer: View {
    @Binding var isSheetPresented: Bool
    @ObservedObject var routingController: MapRoutingController
    
    var body: some View {
        RetailMapView(routingController: routingController, onLaunch: {
            isSheetPresented = true
        })
    }
}



