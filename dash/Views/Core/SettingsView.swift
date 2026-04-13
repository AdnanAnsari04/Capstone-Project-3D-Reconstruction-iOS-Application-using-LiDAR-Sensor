import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showingProfileEdit = false
    @State private var editedName = ""
    @State private var editedEmail = ""
    @State private var showingSaveAlert = false
    @State private var alertMessage = ""
    @State private var selectedTheme: Theme
    
    init(settingsManager: SettingsManager) {
        _selectedTheme = State(initialValue: settingsManager.selectedTheme)
    }
    
    var body: some View {
        List {
            // Debug information
            if let user = authViewModel.currentUser {
                VStack(alignment: .leading) {
                    Text("Debug Info")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Text("Current User: \(user.name)")
                    Text("Role: \(user.role.rawValue)")
                    Text("Email: \(user.email)")
                }
            } else {
                Text("No user found")
            }
            
            // User Profile Section
            if let user = authViewModel.currentUser {
                VStack(alignment: .leading) {
                    Text("Profile")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    HStack(spacing: 15) {
                        // Profile Image
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 70, height: 70)
                            
                            Text(user.name.prefix(1).uppercased())
                                .font(.title)
                                .foregroundColor(.blue)
                        }
                        
                        // User Details
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(user.role.displayName)
                                .font(.caption)
                                .padding(4)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.vertical, 8)
                    
                    // Profile Actions
                    NavigationLink(destination: ProfileEditView(
                            name: $editedName,
                            email: $editedEmail,
                            isPresented: $showingProfileEdit,
                            onSave: updateUserProfile
                    )) {
                        HStack {
                            Image(systemName: "person.fill")
                            Text("Edit Profile")
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                    }
                    .foregroundColor(.primary)
                    .onAppear {
                        editedName = user.name
                        editedEmail = user.email
                    }
                }
            }
            
            // Theme Section
            VStack(alignment: .leading) {
                Text("Appearance")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                HStack {
                    Image(systemName: "paintbrush.fill")
                        .foregroundColor(.blue)
                    Picker("Theme", selection: $selectedTheme) {
                        ForEach(Theme.allCases, id: \.self) { theme in
                            HStack {
                                Image(systemName: theme.icon)
                                Text(theme.displayName)
                            }
                            .tag(theme)
                        }
                    }
                }
                .onChange(of: selectedTheme) { value in
                    settingsManager.selectedTheme = value
                }
            }
            
            // About Section
            VStack(alignment: .leading) {
                Text("Information")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                NavigationLink(destination: AboutUsView().navigationBarBackButtonHidden(false)) {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                        Text("About")
                    }
                }
            }
            
            // Notifications Section
            VStack(alignment: .leading) {
                Text("Notifications")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                // Notifications Toggle
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.blue)
                    Toggle("Enable Notifications", isOn: $settingsManager.useNotifications)
                }
            }
            
            // More Section
            VStack(alignment: .leading) {
                Text("More")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                // Help & Support
                Link(destination: URL(string: "https://help.dashapp.com")!) {
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(.blue)
                        Text("Help & Support")
                        Spacer()
                        Image(systemName: "arrow.up.right.square")
                            .foregroundColor(.gray)
                    }
                }
                .foregroundColor(.primary)
            }
            
            VStack {
                // Sign Out Button
                Button(action: {
                    authViewModel.signOut()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign Out")
                    }
                    .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingSaveAlert) {
            Alert(
                title: Text("Profile Update"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            print("Current user: \(String(describing: authViewModel.currentUser))")
            print("Current theme: \(selectedTheme)")
        }
    }
    
    private func updateUserProfile() {
        guard let userId = authViewModel.currentUser?.id else { return }
        
        // Update user profile
        let updatedUser = UserModel(
            id: userId,
            email: editedEmail,
            username: authViewModel.currentUser?.username ?? "",
            name: editedName,
            password: authViewModel.currentUser?.password ?? "",
            role: authViewModel.currentUser?.role ?? .student
        )
        
        authViewModel.userJSONManager.updateUser(updatedUser)
        authViewModel.currentUser = updatedUser
        alertMessage = "Profile updated successfully"
        showingSaveAlert = true
    }
}

struct ProfileEditView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var isPresented: Bool
    @EnvironmentObject var settingsManager: SettingsManager
    @Environment(\.presentationMode) var presentationMode
    let onSave: () -> Void
    
    var body: some View {
        Form {
            VStack(alignment: .leading) {
                Text("Personal Information")
                    .font(.headline)
                    .padding(.bottom, 5)
                
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    onSave()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                }
            }
        }
    }
}

// MARK: - Previews
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
    SettingsView(settingsManager: SettingsManager())
        .environmentObject(AuthViewModel())
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
    ProfileEditView(
        name: .constant("John Doe"),
        email: .constant("john@example.com"),
        isPresented: .constant(true),
        onSave: {}
    )
    .environmentObject(SettingsManager())
    }
}
