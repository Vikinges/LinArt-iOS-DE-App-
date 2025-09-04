import SwiftUI
import CoreData

struct ProjectDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let project: Project
    
    @State private var showingEditProject = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Project Info
                VStack(alignment: .leading, spacing: 8) {
                    Text("project_info")
                        .font(.headline)
                    
                    Text(project.title ?? "Untitled Project")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    if let description = project.desc, !description.isEmpty {
                        Text(description)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text(project.status?.capitalized ?? "Active")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(statusColor.opacity(0.2))
                            .foregroundColor(statusColor)
                            .cornerRadius(4)
                        
                        Spacer()
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Quick Actions
                VStack(alignment: .leading, spacing: 12) {
                    Text("quick_actions")
                        .font(.headline)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 12) {
                        QuickActionButton(
                            title: "add_rental",
                            icon: "calendar.badge.plus",
                            color: .blue
                        ) {
                            // Add rental action
                        }
                        
                        QuickActionButton(
                            title: "add_expense",
                            icon: "receipt.fill",
                            color: .green
                        ) {
                            // Add expense action
                        }
                        
                        QuickActionButton(
                            title: "add_document",
                            icon: "doc.badge.plus",
                            color: .orange
                        ) {
                            // Add document action
                        }
                        
                        QuickActionButton(
                            title: "export_project",
                            icon: "square.and.arrow.up",
                            color: .purple
                        ) {
                            // Export project action
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
                
                // Project Statistics
                VStack(alignment: .leading, spacing: 12) {
                    Text("project_stats")
                        .font(.headline)
                    
                    HStack {
                        StatCard(title: "rentals", value: "\(project.rentals?.count ?? 0)", icon: "calendar")
                        StatCard(title: "expenses", value: "\(project.expenses?.count ?? 0)", icon: "receipt")
                        StatCard(title: "documents", value: "\(project.documents?.count ?? 0)", icon: "doc")
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(radius: 2)
            }
            .padding()
        }
        .navigationTitle(project.title ?? "Project")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("edit") {
                    showingEditProject = true
                }
            }
        }
        .sheet(isPresented: $showingEditProject) {
            EditProjectView(project: project)
        }
    }
    
    private var statusColor: Color {
        switch project.status?.lowercased() {
        case "completed":
            return .green
        case "in_progress":
            return .orange
        case "paused":
            return .yellow
        default:
            return .blue
        }
    }
}

struct QuickActionButton: View {
    let title: LocalizedStringKey
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

struct StatCard: View {
    let title: LocalizedStringKey
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

#Preview {
    NavigationView {
        ProjectDetailView(project: PersistenceController.preview.container.viewContext.registeredObjects.first(where: { $0 is Project }) as! Project)
    }
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}