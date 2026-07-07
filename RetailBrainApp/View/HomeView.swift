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

                Button(action: {
                    viewModel.startShopping()
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

#Preview {
    HomeView(viewModel: MapViewModel())
}
