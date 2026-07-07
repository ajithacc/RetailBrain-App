//
//  MapViewModel.swift
//  RetailBrainApp
//
//  Created by muhammed.nadeem.m.a on 03/07/26.
//

import Combine
import CoreBluetooth
import CoreLocation
import Foundation
import RetailBrainSDK

enum NavigationState {
    case home
    case map
}

final class MapViewModel: ObservableObject {

    @Published var navigationState: NavigationState = .home

    @Published var showPermissionPopup = false
    @Published var showPermissionDeniedAlert = false
    @Published var isRequestingPermissions = false
    @Published var deniedPermissionMessage = ""
    
    @Published var selectedMode: MapNavigationMode = .singleFloor {
        didSet {
            print(selectedMode.rawValue)
        }
    }

    private let permissionManager: PermissionManager

    var isAllPermissionsGranted: Bool {
        permissionManager.areAllPermissionsGranted
    }

    init(permissionManager: PermissionManager = PermissionManager()) {
        self.permissionManager = permissionManager
       // initializeSDK()
    }

     func initializeSDK() {
         
        RetailBrainManager.shared.delegate = self
        // 1. Setup store shopping items in the app
        
        StoreLocations.setupStoreShoppingItems(for: selectedMode == .multiFloor ? .multiFloor : .singleFloor)

        // 2. Initialize RetailBrainSDK with map configuration
        RetailBrainManager.shared.initialize(config: selectedMode == .multiFloor ? MapNavigationMode.multiFloor.sdkConfig : MapNavigationMode.singleFloor.sdkConfig)
    }

    func startShopping() {
        permissionManager.updatePermissionStatuses()
  
        if permissionManager.areAllPermissionsGranted {
            navigationState = .map
        } else if isPermissionPreviouslyDenied() {
            deniedPermissionMessage = getDeniedPermissionMessage()
            showPermissionDeniedAlert = true
        } else {
            showPermissionPopup = true
        }
    }

    func acceptPermissions() {
        isRequestingPermissions = true
        requestPermissionsSequentially()
    }

    func declinePermissions() {
        showPermissionPopup = false
        isRequestingPermissions = false
    }

    func dismissPermissionDeniedAlert() {
        showPermissionDeniedAlert = false
    }

    func isPermissionPreviouslyDenied() -> Bool {
        let locationStatus = permissionManager.locationPermissionStatus
        let bluetoothStatus = permissionManager.bluetoothPermissionStatus

        let isLocationDenied = locationStatus == .denied || locationStatus == .restricted
        let isBluetoothDenied = bluetoothStatus == .denied || bluetoothStatus == .restricted

        return isLocationDenied || isBluetoothDenied
    }

    func getDeniedPermissionMessage() -> String {
        let locationStatus = permissionManager.locationPermissionStatus
        let bluetoothStatus = permissionManager.bluetoothPermissionStatus

        let isLocationDenied = locationStatus == .denied || locationStatus == .restricted
        let isBluetoothDenied = bluetoothStatus == .denied || bluetoothStatus == .restricted

        if isLocationDenied && isBluetoothDenied {
            return "Location and Bluetooth permissions are required to continue. Please enable both permissions in Settings."
        } else if isLocationDenied {
            return "Location permission is required to continue. Please enable it in Settings."
        } else {
            return "Bluetooth permission is required to continue. Please enable it in Settings."
        }
    }

    private func requestPermissionsSequentially() {
        permissionManager.requestLocationPermissionOnly { [weak self] locationGranted in
            guard let self else { return }
            // Location must be granted before we continue to Bluetooth.
            guard locationGranted else {
                DispatchQueue.main.async {
                    self.showPermissionPopup = false
                    self.isRequestingPermissions = false
                }
                return
            }
            // Small delay so the location prompt has visually dismissed before the
            // Bluetooth prompt appears.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.permissionManager.requestBluetoothPermissionOnly { [weak self] bluetoothGranted in
                    guard let self else { return }
                    DispatchQueue.main.async {
                        self.showPermissionPopup = false
                        self.isRequestingPermissions = false
                        if bluetoothGranted {
                            self.navigationState = .map
                        }
                    }
                }
            }
        }
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
