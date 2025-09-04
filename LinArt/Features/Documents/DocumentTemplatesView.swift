import SwiftUI
import CoreData

struct DocumentTemplatesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    private let templates = [
        DocumentTemplate(name: "Invoice", type: "invoice", description: "Standard invoice template"),
        DocumentTemplate(name: "Contract", type: "contract", description: "Service contract template"),
        DocumentTemplate(name: "Receipt", type: "receipt", description: "Payment receipt template"),
        DocumentTemplate(name: "Estimate", type: "estimate", description: "Project estimate template"),
        DocumentTemplate(name: "Report", type: "report", description: "Project report template")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(templates) { template in
                    TemplateRowView(template: template) {
                        createDocumentFromTemplate(template)
                    }
                }
            }
            .navigationTitle("document_templates")
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
    
    private func createDocumentFromTemplate(_ template: DocumentTemplate) {
        let newDocument = Document(context: viewContext)
        newDocument.id = UUID()
        newDocument.title = template.name
        newDocument.filename = "\(template.name.lowercased())_\(Date().timeIntervalSince1970).pdf"
        newDocument.templateType = template.type
        newDocument.createdAt = Date()
        newDocument.modifiedAt = Date()
        
        // Create sample content
        let sampleContent = generateTemplateContent(for: template)
        newDocument.content = sampleContent.data(using: .utf8)
        
        do {
            try viewContext.save()
            dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func generateTemplateContent(for template: DocumentTemplate) -> String {
        switch template.type {
        case "invoice":
            return """
            INVOICE
            
            Date: \(Date().formatted(date: .abbreviated, time: .omitted))
            Invoice #: INV-\(Int.random(in: 1000...9999))
            
            Bill To:
            [Customer Name]
            [Customer Address]
            
            Description          Qty    Rate    Amount
            =====================================
            [Service/Product]     1     €0.00   €0.00
            
            Subtotal:           €0.00
            Tax:                €0.00
            Total:              €0.00
            """
        case "contract":
            return """
            SERVICE CONTRACT
            
            Date: \(Date().formatted(date: .abbreviated, time: .omitted))
            Contract #: CTR-\(Int.random(in: 1000...9999))
            
            Parties:
            Client: [Client Name]
            Service Provider: [Provider Name]
            
            Terms:
            - Service Description: [Details]
            - Duration: [Time Period]
            - Payment Terms: [Terms]
            
            Signatures:
            Client: ________________
            Provider: ________________
            """
        case "receipt":
            return """
            RECEIPT
            
            Date: \(Date().formatted(date: .abbreviated, time: .omitted))
            Receipt #: RCP-\(Int.random(in: 1000...9999))
            
            Received From: [Payer Name]
            Amount: €0.00
            For: [Description]
            Payment Method: [Method]
            
            Signature: ________________
            """
        case "estimate":
            return """
            PROJECT ESTIMATE
            
            Date: \(Date().formatted(date: .abbreviated, time: .omitted))
            Estimate #: EST-\(Int.random(in: 1000...9999))
            
            Project: [Project Name]
            Client: [Client Name]
            
            Cost Breakdown:
            - Labor: €0.00
            - Materials: €0.00
            - Equipment: €0.00
            
            Total Estimate: €0.00
            Valid Until: [Date]
            """
        default:
            return """
            PROJECT REPORT
            
            Date: \(Date().formatted(date: .abbreviated, time: .omitted))
            Project: [Project Name]
            
            Summary:
            [Project summary and key points]
            
            Progress:
            - Completed: [Details]
            - In Progress: [Details]
            - Pending: [Details]
            
            Next Steps:
            [Upcoming tasks and milestones]
            """
        }
    }
}

struct DocumentTemplate: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let description: String
}

struct TemplateRowView: View {
    let template: DocumentTemplate
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(template.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: templateIcon)
                        .foregroundColor(templateColor)
                }
                
                Text(template.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
    
    private var templateIcon: String {
        switch template.type {
        case "invoice":
            return "doc.text"
        case "contract":
            return "doc.plaintext"
        case "receipt":
            return "receipt"
        case "estimate":
            return "calculator"
        default:
            return "doc"
        }
    }
    
    private var templateColor: Color {
        switch template.type {
        case "invoice":
            return .blue
        case "contract":
            return .green
        case "receipt":
            return .orange
        case "estimate":
            return .purple
        default:
            return .gray
        }
    }
}

#Preview {
    DocumentTemplatesView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}