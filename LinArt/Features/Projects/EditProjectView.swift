import SwiftUI
import CoreData

struct EditProjectView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    let project: Project
    
    @State private var title: String
    @State private var description: String
    @State private var status: String
    
    private let statusOptions = ["active", "in_progress", "paused", "completed"]
    
    init(project: Project) {
        self.project = project
        self._title = State(initialValue: project.title ?? "")
        self._description = State(initialValue: project.desc ?? "")
        self._status = State(initialValue: project.status ?? "active")
    }
    
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
            .navigationTitle("edit_project")
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
        project.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        project.desc = description.trimmingCharacters(in: .whitespacesAndNewlines)
        project.status = status
        project.modifiedAt = Date()
        
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
    EditProjectView(project: PersistenceController.preview.container.viewContext.registeredObjects.first(where: { $0 is Project }) as! Project)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}