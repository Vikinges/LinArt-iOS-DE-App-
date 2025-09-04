import SwiftUI
import CoreData

struct RentalsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Rental.startDate, ascending: false)],
        animation: .default)
    private var rentals: FetchedResults<Rental>
    
    @State private var showingAddRental = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rentals) { rental in
                    RentalRowView(rental: rental)
                }
                .onDelete(perform: deleteRentals)
            }
            .navigationTitle("rentals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddRental = true }) {
                        Label("add_rental", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddRental) {
                AddRentalView()
            }
        }
    }
    
    private func deleteRentals(offsets: IndexSet) {
        withAnimation {
            offsets.map { rentals[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct RentalRowView: View {
    let rental: Rental
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(rental.itemName ?? "Rental Item")
                .font(.headline)
            
            HStack {
                if let startDate = rental.startDate {
                    Text(startDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text("→")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                if let endDate = rental.endDate {
                    Text(endDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if let cost = rental.rentalCost {
                    Text(cost.formatted(.currency(code: "EUR")))
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }
            
            if let status = rental.status {
                Text(status.capitalized)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(statusColor.opacity(0.2))
                    .foregroundColor(statusColor)
                    .cornerRadius(4)
            }
        }
        .padding(.vertical, 2)
    }
    
    private var statusColor: Color {
        switch rental.status?.lowercased() {
        case "completed":
            return .green
        case "active":
            return .blue
        case "overdue":
            return .red
        default:
            return .gray
        }
    }
}

#Preview {
    RentalsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}