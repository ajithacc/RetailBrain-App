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
    
    @ObservedObject var viewModel: MapViewModel
    
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
                VStack(spacing: 12) {
                    Text("Select Map Type")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                    HStack(spacing: 12) {
                        Button(action: { viewModel.selectedMode = .singleFloor }) {
                            Text("Single Floor")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(viewModel.selectedMode == .singleFloor ? .white : .purple)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(viewModel.selectedMode == .singleFloor ? Color.purple : Color.purple.opacity(0.1))
                                .cornerRadius(8)
                        }
                        Button(action: {viewModel.selectedMode = .multiFloor }) {
                            Text("Multi Floor")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(viewModel.selectedMode == .multiFloor ? .white : .purple)
                                .frame(maxWidth: .infinity)
                                .frame(height: 44)
                                .background(viewModel.selectedMode == .multiFloor ? Color.purple : Color.purple.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer()
                Button(action: {
                    viewModel.initializeSDK()
                    viewModel.startShopping()
                }) {
                    Text("Start Shopping")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .frame(width: UIScreen.main.bounds.width - 40)
                        .background(Color.purple)
                        .cornerRadius(12)
                }
            }
            // Permission
            if viewModel.showPermissionPopup {
                PermissionPopupView(
                    onAccept: {
                        viewModel.acceptPermissions()
                    },
                    onDecline: {
                        viewModel.declinePermissions()
                    },
                    isLoading: viewModel.isRequestingPermissions
                )
            }
            // Permission error alert
            if viewModel.showPermissionDeniedAlert {
                PermissionDeniedAlertView(
                    message: viewModel.deniedPermissionMessage,
                    onOpenSettings: {
                        if let appSettings = URL(string: "app-settings://") {
                            UIApplication.shared.open(appSettings)
                        }
                    },
                    onCancel: {
                        viewModel.dismissPermissionDeniedAlert()
                    }
                )
            }
        }
    }
}
