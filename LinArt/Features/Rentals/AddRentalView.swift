import SwiftUI
import CoreData

struct AddRentalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Project.createdAt, ascending: false)],
        animation: .default)
    private var projects: FetchedResults<Project>
    
    @State private var itemName = ""
    @State private var selectedProject: Project?
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400 * 7) // Default 1 week
    @State private var rentalCost = ""
    @State private var status = "active"
    
    private let statusOptions = ["active", "completed", "overdue"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("rental_details")) {
                    TextField("item_name", text: $itemName)
                    
                    if !projects.isEmpty {
                        Picker("project", selection: $selectedProject) {
                            Text("no_project").tag(nil as Project?)
                            ForEach(projects, id: \.self) { project in
                                Text(project.title ?? "Untitled").tag(project as Project?)
                            }
                        }
                    }
                }
                
                Section(header: Text("rental_period")) {
                    DatePicker("start_date", selection: $startDate, displayedComponents: .date)
                    DatePicker("end_date", selection: $endDate, displayedComponents: .date)
                }
                
                Section(header: Text("cost_and_status")) {
                    TextField("rental_cost", text: $rentalCost)
                        .keyboardType(.decimalPad)
                    
                    Picker("status", selection: $status) {
                        ForEach(statusOptions, id: \.self) { status in
                            Text(LocalizedStringKey(status)).tag(status)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("add_rental")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save") {
                        saveRental()
                    }
                    .disabled(itemName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveRental() {
        let newRental = Rental(context: viewContext)
        newRental.id = UUID()
        newRental.itemName = itemName.trimmingCharacters(in: .whitespacesAndNewlines)
        newRental.startDate = startDate
        newRental.endDate = endDate
        newRental.status = status
        newRental.createdAt = Date()
        newRental.modifiedAt = Date()
        newRental.project = selectedProject
        
        if let costText = rentalCost.trimmingCharacters(in: .whitespacesAndNewlines) as String?,
           !costText.isEmpty,
           let cost = Decimal(string: costText) {
            newRental.rentalCost = cost
        }
        
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
    AddRentalView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}