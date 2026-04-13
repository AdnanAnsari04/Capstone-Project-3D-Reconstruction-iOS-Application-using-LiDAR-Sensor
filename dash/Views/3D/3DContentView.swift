/*
See the LICENSE.txt file for this sample's licensing information.

Abstract:
The top-level app view.
*/

import SwiftUI
import os
import RealityKit

private let logger = Logger(subsystem: dashApp.subsystem, category: "ThreeDContentView")

/// The root of the SwiftUI View graph.
struct ThreeDContentView: View {
    // Use the singleton instance instead of creating a new one
    @StateObject private var appDataModelWrapper = AppDataModelWrapper()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Main 3D scanning view
        PrimaryView()
            .onAppear(perform: {
                UIApplication.shared.isIdleTimerDisabled = true
            })
            .onDisappear(perform: {
                UIApplication.shared.isIdleTimerDisabled = false
            })
            
            // Back button overlay
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 20)
                    .padding(.top, 60) // Account for safe area on modern iPhones
                    
                    Spacer()
                }
                Spacer()
            }
        }
        .environment(AppDataModel.instance) // Explicitly specify the generic type and use singleton
        .ignoresSafeArea()
    }
}

// Wrapper to hold the AppDataModel instance as a StateObject
class AppDataModelWrapper: ObservableObject {
    @Published var appDataModel = AppDataModel.instance
}
