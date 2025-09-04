# LinArt iOS App

LinArt is a comprehensive project management application designed specifically for creative professionals, freelancers, and businesses in the artistic and creative industries. Built with SwiftUI and iOS 16+, it provides a complete solution for managing projects, tracking rentals, recording expenses, and organizing documents.

## Features

### 🗂️ Project Management
- Create and organize projects with detailed descriptions
- Track project status (Active, In Progress, Paused, Completed)
- Visual project statistics and overview
- Project-based organization for all other data

### 📅 Rental Workflow
- Track rental items with start and end dates
- Manage rental costs and status
- Associate rentals with specific projects
- Rental period management and tracking

### 💰 Expense Management
- Record expenses with categories and descriptions
- Receipt scanning with OCR capabilities
- Automatic expense data extraction from receipts
- Project-based expense tracking

### 📄 Document Management
- Pre-built document templates (Invoice, Contract, Receipt, Estimate, Report)
- ID capture and secure document storage
- File organization and management
- Template-based document creation

### ☁️ Cloud Integration
- CloudKit synchronization across devices
- Automatic backup and sync
- Cross-device data consistency

### 📤 Export & Sharing
- Multiple export formats (PDF, CSV, JSON)
- Configurable export options
- Project-based export capabilities
- Data sharing functionality

### 🌍 Localization
- English and German language support
- Localized user interface
- Cultural adaptations for different regions

## Technical Requirements

- **iOS**: 16.0+
- **Xcode**: 14.0+
- **Swift**: 5.0+
- **Frameworks**: SwiftUI, Core Data, CloudKit, AVFoundation, VisionKit

## Architecture

### Core Components
- **SwiftUI**: Modern declarative UI framework
- **Core Data**: Local data persistence with CloudKit integration
- **CloudKit**: Cloud synchronization and backup
- **MVVM Pattern**: Clean separation of concerns

### Data Model
- **Project**: Central entity for organizing work
- **Rental**: Rental item tracking
- **Expense**: Financial record keeping
- **Document**: File and template management

### Key Features Implementation
- **Receipt Scanning**: Camera integration with OCR processing
- **ID Capture**: Secure document capture and storage
- **Document Templates**: Pre-formatted business documents
- **Export System**: Flexible data export in multiple formats

## Project Structure

```
LinArt/
├── LinArt/
│   ├── LinArtApp.swift                 # App entry point
│   ├── ContentView.swift               # Main tab navigation
│   ├── Core/
│   │   ├── DataModel.xcdatamodeld/     # Core Data model
│   │   └── PersistenceController.swift # Data persistence
│   ├── Features/
│   │   ├── Projects/                   # Project management
│   │   ├── Rentals/                    # Rental tracking
│   │   ├── Expenses/                   # Expense management
│   │   ├── Documents/                  # Document handling
│   │   └── Settings/                   # App configuration
│   └── Resources/
│       ├── Assets.xcassets             # App icons and colors
│       ├── Info.plist                  # App configuration
│       └── Localizations/              # Multi-language support
├── LinArtTests/                        # Unit tests
└── README.md                          # Project documentation
```

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Vikinges/LinArt-iOS-DE-App-.git
   cd LinArt-iOS-DE-App-
   ```

2. **Open in Xcode**
   ```bash
   open LinArt.xcodeproj
   ```

3. **Configure CloudKit** (Optional)
   - Enable CloudKit capability in project settings
   - Configure CloudKit container in Apple Developer portal
   - Update container identifier in project settings

4. **Build and Run**
   - Select target device or simulator
   - Press Cmd+R to build and run

## Usage

### Getting Started
1. Launch the app to see the main tab interface
2. Start by creating your first project in the Projects tab
3. Add rentals, expenses, and documents as needed
4. Use the export functionality to generate reports

### Project Management
- Tap the "+" button to create new projects
- Use the project detail view to access quick actions
- Track project progress with status updates

### Rental Tracking
- Add rental items with dates and costs
- Associate rentals with specific projects
- Monitor rental periods and expenses

### Expense Recording
- Manually add expenses or scan receipts
- Categorize expenses for better organization
- Generate expense reports by project

### Document Management
- Use templates for common business documents
- Capture ID documents securely
- Organize documents by project

## Privacy & Permissions

The app requests the following permissions:
- **Camera**: For receipt scanning and ID capture
- **Photo Library**: For importing images and documents
- **CloudKit**: For data synchronization (optional)

All data is stored locally and synced through your personal iCloud account. No data is shared with third parties.

## Testing

Run the test suite to verify functionality:

```bash
# In Xcode
Cmd+U
```

The test suite includes:
- Core Data model validation
- Entity relationship testing
- Persistence controller functionality
- Data integrity verification

## Localization

Currently supported languages:
- **English** (en): Primary language
- **German** (de): Full localization

To add new languages:
1. Create new `.lproj` folder in Resources
2. Add `Localizable.strings` file
3. Update project localization settings

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is created for demonstration purposes. Please refer to the repository license for usage terms.

## Support

For support and questions:
- Create an issue in the GitHub repository
- Check the documentation for common solutions
- Review the test suite for implementation examples

## Roadmap

Future enhancements planned:
- Additional document templates
- Advanced OCR capabilities
- Enhanced export options
- Team collaboration features
- Advanced reporting and analytics

---

**LinArt** - Streamlining creative project management, one project at a time.