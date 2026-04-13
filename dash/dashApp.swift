import SwiftUI
import SwiftData

// This extension adds the subsystem property needed by the 3D reconstruction code
extension dashApp {
    static let subsystem = "com.dash.guidedCapture"
}

@main
struct dashApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var settingsManager = SettingsManager()
    @StateObject private var appState = AppState()
    
    let container: ModelContainer
    
    init() {
        // Configure SwiftData container with persistent storage
        let schema = Schema([UserModel.self])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false // This ensures data persists
        )
        
        do {
            container = try ModelContainer(
                for: schema,
                configurations: [modelConfiguration]
            )
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(authViewModel)
                .environmentObject(settingsManager)
                .environmentObject(appState)
                .preferredColorScheme(settingsManager.selectedTheme.colorScheme)
        }
        .modelContainer(container) // Use our configured container
    }
}
