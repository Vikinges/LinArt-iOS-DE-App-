import SwiftUI
import CoreData

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Project.createdAt, ascending: false)],
        animation: .default)
    private var projects: FetchedResults<Project>
    
    @State private var title = ""
    @State private var description = ""
    @State private var amount = ""
    @State private var category = "general"
    @State private var selectedProject: Project?
    
    private let categories = ["general", "office_supplies", "travel", "meals", "equipment", "software", "other"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("expense_details")) {
                    TextField("expense_title", text: $title)
                    TextField("expense_description", text: $description, axis: .vertical)
                        .lineLimit(2...4)
                    TextField("amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("categorization")) {
                    Picker("category", selection: $category) {
                        ForEach(categories, id: \.self) { category in
                            Text(LocalizedStringKey(category)).tag(category)
                        }
                    }
                    
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
            .navigationTitle("add_expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        saveExpense()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || amount.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveExpense() {
        guard let amountDecimal = Decimal(string: amount.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            return
        }
        
        let newExpense = Expense(context: viewContext)
        newExpense.id = UUID()
        newExpense.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        newExpense.desc = description.trimmingCharacters(in: .whitespacesAndNewlines)
        newExpense.amount = amountDecimal
        newExpense.category = category
        newExpense.createdAt = Date()
        newExpense.modifiedAt = Date()
        newExpense.project = selectedProject
        
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
    AddExpenseView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}