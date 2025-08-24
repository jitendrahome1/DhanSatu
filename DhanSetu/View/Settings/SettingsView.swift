import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tabBarVisibility: TabBarVisibility
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Bar with Back Button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue) // same color as default back button
                }
                Text("Settings")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding()
            
            Divider() // optional: thin line like system nav bar
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    ProfileCard(
                        name: "Ayush Kumar",
                        email: "agrawalayush0611@gmail.com",
                        phone: "+91 9031295456"
                    )
                    
                    BannerCard(
                        title: "The user profile is updated",
                        message: "The app will now be tailored to your risk preferences."
                    )
                    
                    BalanceCard(
                        balance: "₹0.15",
                        onWithdraw: { print("Withdraw tapped") },
                        onAddFunds: { print("Add Funds tapped") },
                        onDisconnect: { print("Disconnect tapped") }
                    )
                    
                    SettingsSection(
                        title: "ACCOUNT",
                        rows: [
                            SettingsRowModel(title: "Portfolio", icon: "chart.bar.fill"),
                            SettingsRowModel(title: "Live Signals", icon: "dot.radiowaves.left.and.right"),
                            SettingsRowModel(title: "Edit Capital & Risk", icon: "pencil"),
                            SettingsRowModel(title: "Statements & Reports", icon: "doc.text.fill"),
                            SettingsRowModel(title: "Notification Management", icon: "bell.fill")
                        ]
                    )
                    
                    SettingsSection(
                        title: "HELP & SUPPORT",
                        rows: [
                            SettingsRowModel(title: "App Tour", icon: "map"),
                            SettingsRowModel(title: "FAQs", icon: "questionmark.circle"),
                            SettingsRowModel(title: "About Us", icon: "info.circle"),
                            SettingsRowModel(title: "Customer Care", icon: "headphones"),
                            SettingsRowModel(title: "Rate Us", icon: "star.fill"),
                            SettingsRowModel(title: "Terms & Conditions", icon: "doc.plaintext"),
                            SettingsRowModel(title: "Privacy Policy", icon: "lock.shield")
                        ]
                    )
                    
                    LogoutButton {
                        print("Logout tapped")
                    }
                    
                    FooterView(
                        version: "2.0.3 (2)",
                        sebiNumber: "INH000013925",
                        message: "Proudly Made in India 🇮🇳"
                    )
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true) // hide system back button if in NavigationStack
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            tabBarVisibility.isVisible = false // ✅ hide tab bar
        }
        .onDisappear {
            tabBarVisibility.isVisible = true // ✅ restore
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
