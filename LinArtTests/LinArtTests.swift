import XCTest
import CoreData
@testable import LinArt

final class LinArtTests: XCTestCase {
    var persistenceController: PersistenceController!
    var viewContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        persistenceController = PersistenceController(inMemory: true)
        viewContext = persistenceController.container.viewContext
    }
    
    override func tearDownWithError() throws {
        persistenceController = nil
        viewContext = nil
    }
    
    func testProjectCreation() throws {
        let project = Project(context: viewContext)
        project.id = UUID()
        project.title = "Test Project"
        project.desc = "Test Description"
        project.status = "active"
        project.createdAt = Date()
        project.modifiedAt = Date()
        
        try viewContext.save()
        
        XCTAssertNotNil(project.id)
        XCTAssertEqual(project.title, "Test Project")
        XCTAssertEqual(project.status, "active")
    }
    
    func testRentalCreation() throws {
        let rental = Rental(context: viewContext)
        rental.id = UUID()
        rental.itemName = "Test Item"
        rental.startDate = Date()
        rental.endDate = Date().addingTimeInterval(86400 * 7) // 1 week
        rental.rentalCost = Decimal(100.50)
        rental.status = "active"
        rental.createdAt = Date()
        rental.modifiedAt = Date()
        
        try viewContext.save()
        
        XCTAssertNotNil(rental.id)
        XCTAssertEqual(rental.itemName, "Test Item")
        XCTAssertEqual(rental.rentalCost, Decimal(100.50))
        XCTAssertEqual(rental.status, "active")
    }
    
    func testExpenseCreation() throws {
        let expense = Expense(context: viewContext)
        expense.id = UUID()
        expense.title = "Test Expense"
        expense.amount = Decimal(25.75)
        expense.category = "office_supplies"
        expense.createdAt = Date()
        expense.modifiedAt = Date()
        
        try viewContext.save()
        
        XCTAssertNotNil(expense.id)
        XCTAssertEqual(expense.title, "Test Expense")
        XCTAssertEqual(expense.amount, Decimal(25.75))
        XCTAssertEqual(expense.category, "office_supplies")
    }
    
    func testDocumentCreation() throws {
        let document = Document(context: viewContext)
        document.id = UUID()
        document.title = "Test Document"
        document.filename = "test.pdf"
        document.templateType = "invoice"
        document.content = "Test content".data(using: .utf8)
        document.createdAt = Date()
        document.modifiedAt = Date()
        
        try viewContext.save()
        
        XCTAssertNotNil(document.id)
        XCTAssertEqual(document.title, "Test Document")
        XCTAssertEqual(document.filename, "test.pdf")
        XCTAssertEqual(document.templateType, "invoice")
        XCTAssertNotNil(document.content)
    }
    
    func testProjectRelationships() throws {
        // Create a project
        let project = Project(context: viewContext)
        project.id = UUID()
        project.title = "Test Project"
        project.createdAt = Date()
        project.modifiedAt = Date()
        
        // Create related rental
        let rental = Rental(context: viewContext)
        rental.id = UUID()
        rental.itemName = "Test Item"
        rental.project = project
        rental.createdAt = Date()
        rental.modifiedAt = Date()
        
        // Create related expense
        let expense = Expense(context: viewContext)
        expense.id = UUID()
        expense.title = "Test Expense"
        expense.project = project
        expense.createdAt = Date()
        expense.modifiedAt = Date()
        
        // Create related document
        let document = Document(context: viewContext)
        document.id = UUID()
        document.title = "Test Document"
        document.project = project
        document.createdAt = Date()
        document.modifiedAt = Date()
        
        try viewContext.save()
        
        XCTAssertEqual(project.rentals?.count, 1)
        XCTAssertEqual(project.expenses?.count, 1)
        XCTAssertEqual(project.documents?.count, 1)
        XCTAssertEqual(rental.project, project)
        XCTAssertEqual(expense.project, project)
        XCTAssertEqual(document.project, project)
    }
    
    func testPersistenceControllerSharedInstance() throws {
        let sharedController = PersistenceController.shared
        XCTAssertNotNil(sharedController)
        XCTAssertNotNil(sharedController.container)
    }
    
    func testDataModelEntities() throws {
        let model = persistenceController.container.managedObjectModel
        let entityNames = model.entities.map { $0.name }.compactMap { $0 }
        
        XCTAssertTrue(entityNames.contains("Project"))
        XCTAssertTrue(entityNames.contains("Rental"))
        XCTAssertTrue(entityNames.contains("Expense"))
        XCTAssertTrue(entityNames.contains("Document"))
    }
}