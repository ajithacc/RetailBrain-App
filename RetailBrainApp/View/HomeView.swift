//
//  HomeView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 30/06/26.
//

import SwiftUI
import CoreLocation
import CoreBluetooth

struct HomeView: View {
    @State private var showPermissionPopup = false
    @State private var showPermissionDeniedAlert = false
    @State private var isRequestingPermissions = false
    @State private var deniedPermissionMessage = ""
    var onPermissionsGranted: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                VStack(spacing: 16) {
                    Image(systemName: "location.viewfinder")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                    
                    VStack(spacing: 8) {
                        Text("Retail Brain")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("Your Smart Shopping Guide")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    PermissionManager.shared.updatePermissionStatuses()
                    
                    if PermissionManager.shared.areAllPermissionsGranted {
                        onPermissionsGranted?()
                    } else if isPermissionPreviouslyDenied() {
                        showPermissionDeniedAlert = true
                        deniedPermissionMessage = getDeniedPermissionMessage()
                    } else {
                        showPermissionPopup = true
                    }
                }) {
                    Text("Start Shopping")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.purple)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
            
            if showPermissionPopup {
                PermissionPopupView(
                    onAccept: {
                        isRequestingPermissions = true
                        requestPermissionsSequentially()
                    },
                    onDecline: {
                        showPermissionPopup = false
                        isRequestingPermissions = false
                    },
                    isLoading: isRequestingPermissions
                )
            }
            
            if showPermissionDeniedAlert {
                PermissionDeniedAlertView(
                    message: deniedPermissionMessage,
                    onOpenSettings: {
                        if let appSettings = URL(string: "app-settings://") {
                            UIApplication.shared.open(appSettings)
                        }
                    },
                    onCancel: {
                        showPermissionDeniedAlert = false
                    }
                )
            }
        }
    }
    
    private func isPermissionPreviouslyDenied() -> Bool {
        let locationStatus = PermissionManager.shared.locationPermissionStatus
        let bluetoothStatus = PermissionManager.shared.bluetoothPermissionStatus
        
        let isLocationDenied = locationStatus == .denied || locationStatus == .restricted
        let isBluetoothDenied = bluetoothStatus == .denied || bluetoothStatus == .restricted
        
        return isLocationDenied || isBluetoothDenied
    }
    
    private func getDeniedPermissionMessage() -> String {
        let locationStatus = PermissionManager.shared.locationPermissionStatus
        let bluetoothStatus = PermissionManager.shared.bluetoothPermissionStatus
        
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
        PermissionManager.shared.requestLocationPermissionOnly { locationGranted in
            if !locationGranted {
                DispatchQueue.main.async {
                    showPermissionPopup = false
                    isRequestingPermissions = false
                }
                return
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                PermissionManager.shared.requestBluetoothPermissionOnly { bluetoothGranted in
                    DispatchQueue.main.async {
                        if bluetoothGranted {
                            showPermissionPopup = false
                            isRequestingPermissions = false
                            onPermissionsGranted?()
                        } else {
                            showPermissionPopup = false
                            isRequestingPermissions = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(onPermissionsGranted: {})
}
