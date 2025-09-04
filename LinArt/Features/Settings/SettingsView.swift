import SwiftUI
import CloudKit

struct SettingsView: View {
    @State private var notificationsEnabled = true
    @State private var cloudSyncEnabled = true
    @State private var selectedLanguage = "en"
    @State private var selectedCurrency = "EUR"
    @State private var showingExportOptions = false
    @State private var showingAbout = false
    
    private let languages = [
        ("en", "English"),
        ("de", "Deutsch")
    ]
    
    private let currencies = ["EUR", "USD", "GBP", "CHF"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("general")) {
                    HStack {
                        Image(systemName: "globe")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        Text("language")
                        
                        Spacer()
                        
                        Picker("language", selection: $selectedLanguage) {
                            ForEach(languages, id: \.0) { code, name in
                                Text(name).tag(code)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .foregroundColor(.green)
                            .frame(width: 24)
                        
                        Text("currency")
                        
                        Spacer()
                        
                        Picker("currency", selection: $selectedCurrency) {
                            ForEach(currencies, id: \.self) { currency in
                                Text(currency).tag(currency)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                
                Section(header: Text("sync_and_backup")) {
                    HStack {
                        Image(systemName: "icloud")
                            .foregroundColor(.blue)
                            .frame(width: 24)
                        
                        Text("icloud_sync")
                        
                        Spacer()
                        
                        Toggle("", isOn: $cloudSyncEnabled)
                    }
                    
                    HStack {
                        Image(systemName: "bell")
                            .foregroundColor(.orange)
                            .frame(width: 24)
                        
                        Text("notifications")
                        
                        Spacer()
                        
                        Toggle("", isOn: $notificationsEnabled)
                    }
                }
                
                Section(header: Text("data_management")) {
                    Button(action: { showingExportOptions = true }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.purple)
                                .frame(width: 24)
                            
                            Text("export_data")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                    
                    Button(action: clearAllData) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .frame(width: 24)
                            
                            Text("clear_all_data")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section(header: Text("support")) {
                    Button(action: { showingAbout = true }) {
                        HStack {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                                .frame(width: 24)
                            
                            Text("about_linart")
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                    
                    Button(action: sendFeedback) {
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.green)
                                .frame(width: 24)
                            
                            Text("send_feedback")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action: openPrivacyPolicy) {
                        HStack {
                            Image(systemName: "hand.raised")
                                .foregroundColor(.orange)
                                .frame(width: 24)
                            
                            Text("privacy_policy")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .navigationTitle("settings")
        }
        .sheet(isPresented: $showingExportOptions) {
            ExportOptionsView()
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
    }
    
    private func clearAllData() {
        // Show confirmation alert in a real implementation
        print("Clear all data requested")
    }
    
    private func sendFeedback() {
        // Open mail composer or feedback form
        print("Send feedback requested")
    }
    
    private func openPrivacyPolicy() {
        // Open privacy policy URL
        print("Privacy policy requested")
    }
}

struct ExportOptionsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFormat = "pdf"
    @State private var includeImages = true
    @State private var includeExpenses = true
    @State private var includeRentals = true
    
    private let formats = ["pdf", "csv", "json"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("export_format")) {
                    Picker("format", selection: $selectedFormat) {
                        ForEach(formats, id: \.self) { format in
                            Text(format.uppercased()).tag(format)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("include_data")) {
                    Toggle("include_images", isOn: $includeImages)
                    Toggle("include_expenses", isOn: $includeExpenses)
                    Toggle("include_rentals", isOn: $includeRentals)
                }
                
                Section {
                    Button(action: exportData) {
                        HStack {
                            Spacer()
                            Text("export_now")
                                .fontWeight(.medium)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("export_options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func exportData() {
        // Implement export functionality
        print("Export data in \(selectedFormat) format")
        dismiss()
    }
}

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "paintbrush.pointed.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("LinArt")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Version 1.0.0")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("about_description")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("features")
                            .font(.headline)
                        
                        FeatureRow(icon: "folder.fill", text: "project_management")
                        FeatureRow(icon: "calendar", text: "rental_tracking")
                        FeatureRow(icon: "receipt", text: "expense_management")
                        FeatureRow(icon: "doc.fill", text: "document_templates")
                        FeatureRow(icon: "icloud", text: "cloud_sync")
                        FeatureRow(icon: "square.and.arrow.up", text: "export_functionality")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            .navigationTitle("about_linart")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct FeatureRow: View {
    let icon: String
    let text: LocalizedStringKey
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(text)
                .font(.subheadline)
            
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
}