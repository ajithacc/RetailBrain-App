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
    @State private var permissionMonitor = PermissionMonitor()
    @State private var permissionDelegate: MapPagePermissionDelegate?
    @State private var showPermissionRevokedAlert = false
    @State private var revokedPermissionType: String = ""
    @State private var isPermissionRevokedOnMap = false
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject private var routingController = MapRoutingController()
    
    let mode: MapNavigationMode
    let onBack: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                SearchBarView(onBack: onBack)
                    .padding(16)
                    .background(Color.white)
                
                ZStack {
                    RetailMapViewContainer(
                        isSheetPresented: $showSheet,
                        routingController: routingController,
                        mapId: mode.mapId,
                        isMultiFloorMode: mode.isMultiFloorEnabled
                    )
                    .ignoresSafeArea()
                    .disabled(isPermissionRevokedOnMap)
                    .opacity(isPermissionRevokedOnMap ? 0.5 : 1.0)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                if !isPermissionRevokedOnMap {
                                    showSheet = true
                                }
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.purple)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                                    .opacity(isPermissionRevokedOnMap ? 0.5 : 1.0)
                            }
                            .padding(20)
                            .disabled(isPermissionRevokedOnMap)
                        }
                    }
                }
            }
            
            if showPermissionRevokedAlert {
                PermissionRevokedAlertView(
                    permissionType: revokedPermissionType,
                    onOpenSettings: {
                        if let appSettings = URL(string: "app-settings://") {
                            UIApplication.shared.open(appSettings)
                        }
                    },
                    onCancel: {
                        showPermissionRevokedAlert = false
                    }
                )
            }
        }
        .sheet(isPresented: $showSheet) {
            ItemSelectionSheet(items: StoreLocations.shoppingItems(for: mode)) { selectedItems in
                showSheet = false

                let routeAliases = selectedItems.map { item in
                    item.name == item.storeName ? item.storeName : "\(item.storeName)|\(item.name)"
                }
                routingController.routeToStores(routeAliases)
            }
        }
        .onAppear {
            permissionDelegate = MapPagePermissionDelegate(
                onPermissionRevoked: { revokedPermission in
                    isPermissionRevokedOnMap = true
                    revokedPermissionType = revokedPermission == .location ? "Location" : "Bluetooth"
                    showPermissionRevokedAlert = true
                    routingController.clearRoute()
                }
            )
            permissionMonitor.delegate = permissionDelegate
            permissionMonitor.startMonitoring()
        }
        .onDisappear {
            permissionMonitor.stopMonitoring()
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                permissionMonitor.updateCurrentStatus()
                if !PermissionManager.shared.areAllPermissionsGranted {
                    isPermissionRevokedOnMap = true
                } else {
                    isPermissionRevokedOnMap = false
                    showPermissionRevokedAlert = false
                }
                permissionMonitor.startMonitoring()
            } else if scenePhase == .background {
                permissionMonitor.stopMonitoring()
            }
        }
    }
}

class MapPagePermissionDelegate: PermissionMonitorDelegate {
    var onPermissionRevoked: (RevokedPermission) -> Void
    
    init(onPermissionRevoked: @escaping (RevokedPermission) -> Void) {
        self.onPermissionRevoked = onPermissionRevoked
    }
    
    func permissionMonitorDidDetectPermissionChange(_ monitor: PermissionMonitor, revokedPermission: RevokedPermission) {
        onPermissionRevoked(revokedPermission)
    }
}

struct SearchBarView: View {
    let onBack: () -> Void
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.gray)
                    .frame(width: 32, height: 32)
            }
            
            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("Search in store...", text: $searchText)
            }
            .padding(.horizontal, 12)
            .frame(height: 40)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            
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
    MapPageView(mode: .singleFloor, onBack: {})
}
