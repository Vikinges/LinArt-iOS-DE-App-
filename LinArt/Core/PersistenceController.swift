import CoreData
import CloudKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Create sample data for previews
        let sampleProject = Project(context: viewContext)
        sampleProject.id = UUID()
        sampleProject.title = "Sample Project"
        sampleProject.desc = "This is a sample project for testing"
        sampleProject.createdAt = Date()
        sampleProject.modifiedAt = Date()

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "DataModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        } else {
            // Configure CloudKit
            container.persistentStoreDescriptions.forEach { storeDescription in
                storeDescription.setOption(true as NSNumber, 
                                         forKey: NSPersistentHistoryTrackingKey)
                storeDescription.setOption(true as NSNumber, 
                                         forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
            }
        }
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

// MARK: - Core Data Operations
extension PersistenceController {
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}