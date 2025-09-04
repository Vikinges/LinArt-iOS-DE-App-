import SwiftUI
import CoreData

struct DocumentsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Document.createdAt, ascending: false)],
        animation: .default)
    private var documents: FetchedResults<Document>
    
    @State private var showingAddDocument = false
    @State private var showingTemplates = false
    @State private var showingIDCapture = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(documents) { document in
                    DocumentRowView(document: document)
                }
                .onDelete(perform: deleteDocuments)
            }
            .navigationTitle("documents")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: { showingTemplates = true }) {
                        Label("templates", systemImage: "doc.text")
                    }
                    
                    Button(action: { showingIDCapture = true }) {
                        Label("capture_id", systemImage: "camera.viewfinder")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddDocument = true }) {
                        Label("add_document", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddDocument) {
                AddDocumentView()
            }
            .sheet(isPresented: $showingTemplates) {
                DocumentTemplatesView()
            }
            .sheet(isPresented: $showingIDCapture) {
                IDCaptureView()
            }
        }
    }
    
    private func deleteDocuments(offsets: IndexSet) {
        withAnimation {
            offsets.map { documents[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct DocumentRowView: View {
    let document: Document
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(document.title ?? "Untitled Document")
                .font(.headline)
            
            if let filename = document.filename {
                Text(filename)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                if let templateType = document.templateType {
                    Text(templateType.capitalized)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.purple.opacity(0.2))
                        .foregroundColor(.purple)
                        .cornerRadius(4)
                }
                
                Spacer()
                
                if let date = document.createdAt {
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if document.content != nil {
                    Image(systemName: "doc.fill")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    DocumentsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}