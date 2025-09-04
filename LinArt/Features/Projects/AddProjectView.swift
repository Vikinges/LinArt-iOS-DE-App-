import SwiftUI
import CoreData

struct AddProjectView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var description = ""
    @State private var status = "active"
    
    private let statusOptions = ["active", "in_progress", "paused", "completed"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("project_details")) {
                    TextField("project_title", text: $title)
                    TextField("project_description", text: $description, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                Section(header: Text("status")) {
                    Picker("project_status", selection: $status) {
                        ForEach(statusOptions, id: \.self) { status in
                            Text(LocalizedStringKey(status)).tag(status)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("add_project")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        saveProject()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveProject() {
        let newProject = Project(context: viewContext)
        newProject.id = UUID()
        newProject.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        newProject.desc = description.trimmingCharacters(in: .whitespacesAndNewlines)
        newProject.status = status
        newProject.createdAt = Date()
        newProject.modifiedAt = Date()
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

#Preview {
    AddProjectView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}