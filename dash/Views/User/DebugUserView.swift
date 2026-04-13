import SwiftUI

struct DemoUserView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var username = "testuser"
    @State private var password = "test123"
    @State private var email = "test@example.com"
    @State private var name = "Test User"
    @State private var selectedRole: UserRole = .admin
    @State private var message = ""
    
    var body: some View {
        NavigationView {
            List {
                SwiftUI.Section(header: Text("Quick Login")) {
                    Button(action: {
                        directLogin(role: .admin)
                    }) {
                        Text("Login as Admin")
                    }
                    .foregroundColor(.blue)
                    
                    Button(action: {
                        directLogin(role: .student)
                    }) {
                        Text("Login as Student")
                    }
                    .foregroundColor(.green)
                    
                    Button(action: {
                        directLogin(role: .teacher)
                    }) {
                        Text("Login as Teacher")
                    }
                    .foregroundColor(.orange)
                    
                    Button(action: {
                        directLogin(role: .professional)
                    }) {
                        Text("Login as Professional")
                    }
                    .foregroundColor(.purple)
                }
                
                SwiftUI.Section(header: Text("Demo Account Info")) {
                    Text("Username: demo")
                    Text("Password: demo123")
                    Text("Role: Admin")
                }
                
                if !message.isEmpty {
                    SwiftUI.Section {
                        Text(message)
                            .foregroundColor(.green)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Demo Access")
        }
    }
    
    private func directLogin(role: UserRole) {
        let demoUser = UserModel(
            id: UUID().uuidString,
            email: "\(role)@dashapp.com",
            username: "\(role)",
            name: "\(role.displayName) User",
            password: "\(role)123",
            role: role
        )
        
        authViewModel.isAuthenticated = true
        authViewModel.currentUser = demoUser
        message = "Logged in as \(role.displayName)"
    }
}

// MARK: - Preview
struct DemoUserView_Previews: PreviewProvider {
    static var previews: some View {
        DemoUserView(authViewModel: AuthViewModel())
    }
} 