//
//  PermissionRevokedAlertView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 01/07/26.
//

import SwiftUI

struct PermissionRevokedAlertView: View {
    var permissionType: String
    var onOpenSettings: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 56))
                        .foregroundColor(.red)
                    
                    Text("Permission Disabled")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Text("\(permissionType) permission has been disabled. Please enable it in Settings to continue using the app.")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                
                Spacer()
                    .frame(height: 12)
                
                VStack(spacing: 12) {
                    Button(action: onOpenSettings) {
                        Text("Open Settings")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    Button(action: onCancel) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(20)
            .frame(maxWidth: 340)
            .shadow(radius: 12)
        }
    }
}

#Preview {
    PermissionRevokedAlertView(
        permissionType: "Location",
        onOpenSettings: { print("Open settings") },
        onCancel: { print("Cancel") }
    )
}
