import SwiftUI
import CoreData

struct ExpensesView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.createdAt, ascending: false)],
        animation: .default)
    private var expenses: FetchedResults<Expense>
    
    @State private var showingAddExpense = false
    @State private var showingReceiptScanner = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses) { expense in
                    ExpenseRowView(expense: expense)
                }
                .onDelete(perform: deleteExpenses)
            }
            .navigationTitle("expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showingReceiptScanner = true }) {
                        Label("scan_receipt", systemImage: "camera")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddExpense = true }) {
                        Label("add_expense", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView()
            }
            .sheet(isPresented: $showingReceiptScanner) {
                ReceiptScannerView()
            }
        }
    }
    
    private func deleteExpenses(offsets: IndexSet) {
        withAnimation {
            offsets.map { expenses[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ExpenseRowView: View {
    let expense: Expense
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(expense.title ?? "Expense")
                    .font(.headline)
                
                if let category = expense.category {
                    Text(category.capitalized)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(4)
                }
                
                if let description = expense.desc, !description.isEmpty {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                if let amount = expense.amount {
                    Text(amount.formatted(.currency(code: "EUR")))
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                
                if let date = expense.createdAt {
                    Text(date, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                if expense.receiptImage != nil {
                    Image(systemName: "camera.fill")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    ExpensesView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}