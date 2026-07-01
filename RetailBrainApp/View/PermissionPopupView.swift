//
//  PermissionPopupView.swift
//  RetailBrainApp
//
//  Created by ajith.a.s on 30/06/26.
//

import SwiftUI

struct PermissionPopupView: View {
    var onAccept: () -> Void
    var onDecline: () -> Void
    var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            // Dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            // Centered popup card
            VStack(spacing: 24) {
                // Header Icon and Title
                VStack(spacing: 16) {
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 64))
                        .foregroundColor(.purple)
                    
                    VStack(spacing: 8) {
                        Text("Accenture Store aimeraitutiliser votre localisation bluetooth")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                        
                        Text("Activez le Bluetooth pour suivre votre parcours d'achat en magasin.")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .lineLimit(nil)
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                // Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        if !isLoading {
                            onDecline()
                        }
                    }) {
                        Text("Refuser")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.purple)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.purple, lineWidth: 1)
                            )
                    }
                    .disabled(isLoading)
                    
                    Button(action: onAccept) {
                        if isLoading {
                            HStack(spacing: 8) {
                                ProgressView()
                                    .tint(.white)
                                Text("Traitement...")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                        } else {
                            Text("Accepter")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                        }
                    }
                    .background(Color.purple)
                    .cornerRadius(12)
                    .disabled(isLoading)
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
    PermissionPopupView(
        onAccept: { print("Accept tapped") },
        onDecline: { print("Decline tapped") }
    )
}
