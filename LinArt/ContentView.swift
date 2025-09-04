import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProjectsView()
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("projects")
                }
                .tag(0)
            
            RentalsView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("rentals")
                }
                .tag(1)
            
            ExpensesView()
                .tabItem {
                    Image(systemName: "receipt")
                    Text("expenses")
                }
                .tag(2)
            
            DocumentsView()
                .tabItem {
                    Image(systemName: "doc.fill")
                    Text("documents")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("settings")
                }
                .tag(4)
        }
        .navigationTitle("LinArt")
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}