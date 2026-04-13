import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let actionTitle: String?
    let action: (() -> Void)?
    
    init(
        icon: String,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(.secondary.opacity(0.7))
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            if let actionTitle = actionTitle, let action = action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.headline)
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 10)
            }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Convenience extension for SwiftUI View to add empty state
extension View {
    @ViewBuilder
    func emptyState(
        when isEmpty: Bool,
        icon: String,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        if isEmpty {
            EmptyStateView(
                icon: icon,
                title: title,
                message: message,
                actionTitle: actionTitle,
                action: action
            )
        } else {
            self
        }
    }
}

#Preview {
    EmptyStateView(
        icon: "exclamationmark.triangle",
        title: "No Data Available",
        message: "There's no data to display at the moment. Try refreshing or changing your filters.",
        actionTitle: "Refresh",
        action: { }
    )
} 
