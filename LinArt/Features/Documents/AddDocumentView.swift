import SwiftUI
import CoreData

struct AddDocumentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Project.createdAt, ascending: false)],
        animation: .default)
    private var projects: FetchedResults<Project>
    
    @State private var title = ""
    @State private var filename = ""
    @State private var templateType = "general"
    @State private var selectedProject: Project?
    
    private let documentTypes = ["general", "invoice", "contract", "receipt", "estimate", "report", "id_document"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("document_details")) {
                    TextField("document_title", text: $title)
                    TextField("filename", text: $filename)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("document_type")) {
                    Picker("type", selection: $templateType) {
                        ForEach(documentTypes, id: \.self) { type in
                            Text(LocalizedStringKey(type)).tag(type)
                        }
                    }
                }
                
                Section(header: Text("project_association")) {
                    if !projects.isEmpty {
                        Picker("project", selection: $selectedProject) {
                            Text("no_project").tag(nil as Project?)
                            ForEach(projects, id: \.self) { project in
                                Text(project.title ?? "Untitled").tag(project as Project?)
                            }
                        }
                    }
                }
            }
            .navigationTitle("add_document")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        saveDocument()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveDocument() {
        let newDocument = Document(context: viewContext)
        newDocument.id = UUID()
        newDocument.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        newDocument.filename = filename.trimmingCharacters(in: .whitespacesAndNewlines)
        newDocument.templateType = templateType
        newDocument.createdAt = Date()
        newDocument.modifiedAt = Date()
        newDocument.project = selectedProject
        
        // Create sample content
        let sampleContent = "Document content for \(newDocument.title ?? "document")"
        newDocument.content = sampleContent.data(using: .utf8)
        
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
    AddDocumentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}