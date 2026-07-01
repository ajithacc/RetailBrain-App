//
//  MapPageView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 30/06/26.
//

import SwiftUI
import RetailBrainSDK

struct MapPageView: View {
    @State private var showSheet = false
    @State private var selectedItems: [ShoppingItem] = []
    @StateObject private var routingController = MapRoutingController()
    
    var body: some View {
        VStack(spacing: 0) {
            // Top Search Bar (Demo App responsibility)
            SearchBarView()
                .padding(16)
                .background(Color.white)
            
            // Map (SDK responsibility) - fills remaining space
            ZStack {
                RetailMapViewContainer(
                    isSheetPresented: $showSheet,
                    routingController: routingController
                )
                .ignoresSafeArea()
                
                // Bottom Floating Action Button (Demo App responsibility)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showSheet = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color.purple)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding(20)
                    }
                }
            }
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

struct SearchBarView: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search in store...", text: $searchText)
                .textFieldStyle(.roundedBorder)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    MapPageView()
}
