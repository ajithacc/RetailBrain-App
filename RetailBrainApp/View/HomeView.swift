//
//  HomeView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 30/06/26.
//

import SwiftUI

struct HomeView: View {
    @State private var showPermissionPopup = false
    @State private var isRequestingPermissions = false
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
                    } else {
                        showPermissionPopup = true
                    }
                }) {
                    Text("Start")
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
