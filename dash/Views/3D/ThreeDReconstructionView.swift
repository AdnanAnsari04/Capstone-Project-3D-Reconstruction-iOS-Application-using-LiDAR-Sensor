import SwiftUI
import RealityKit
import os

private let logger = Logger(subsystem: dashApp.subsystem, category: "ThreeDReconstructionView")

struct ThreeDReconstructionView: View {
    @State private var showScanner = false
    @State private var models: [String] = []
    @State private var selectedModel: String? = nil
    
    // Sample data to show previous models
    private let sampleModels = [
        "Book 3D Model",
        "Plant 3D Model",
        "Desk 3D Model"
    ]
    
    var body: some View {
        VStack {
            // Header
            Text("3D Object Scanner")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("Scan real-world objects to create 3D models")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            
            // Main content
            ScrollView {
                VStack(spacing: 25) {
                    // New scan button
                    Button(action: {
                        showScanner = true
                    }) {
                        HStack {
                            Image(systemName: "camera.fill")
                                .font(.title2)
                            Text("Start New 3D Scan")
                                .font(.headline)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    
                    // Tips section
                    ScanningTipsView()
                        .padding(.horizontal)
                    
                    // Previous models
                    PreviousModelsView(models: sampleModels, selectedModel: $selectedModel)
                        .padding(.horizontal)
                }
            }
        }
        .fullScreenCover(isPresented: $showScanner) {
            // When this view appears, it will show our ThreeDContentView for scanning
            ThreeDContentView()
                .ignoresSafeArea()
        }
        .sheet(item: $selectedModel) { modelName in
            ModelDetailView(modelName: modelName)
        }
    }
}

// View to display scanning tips
struct ScanningTipsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Scanning Tips")
                .font(.headline)
                .padding(.bottom, 5)
            
            TipRow(icon: "lightbulb.fill", text: "Scan in a well-lit environment")
            TipRow(icon: "move.3d", text: "Move slowly around the object")
            TipRow(icon: "360.fill", text: "Capture all sides of the object")
            TipRow(icon: "ruler.fill", text: "Keep 0.5-1m distance from object")
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// Helper view for displaying tips
struct TipRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 25)
            Text(text)
                .font(.subheadline)
        }
    }
}

// View to display previous models
struct PreviousModelsView: View {
    let models: [String]
    @Binding var selectedModel: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Previous Models")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(models, id: \.self) { model in
                Button(action: {
                    selectedModel = model
                }) {
                    HStack {
                        Image(systemName: "cube.transparent.fill")
                            .foregroundColor(.blue)
                        
                        Text(model)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
    }
}

// Mock view for model details
struct ModelDetailView: View {
    let modelName: String
    
    var body: some View {
        VStack {
            Text(modelName)
                .font(.largeTitle)
                .padding()
            
            Image(systemName: "cube.transparent.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundColor(.blue)
                .padding()
            
            Text("This is a placeholder for the 3D model viewer.")
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
    }
}

// Helper extension to make model name work with optional binding
extension String: Identifiable {
    public var id: String {
        self
    }
}

// MARK: - Preview
struct ThreeDReconstructionView_Previews: PreviewProvider {
    static var previews: some View {
        ThreeDReconstructionView()
    }
} 