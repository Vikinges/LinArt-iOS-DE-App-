import SwiftUI
import AVFoundation

struct IDCaptureView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingCamera = false
    @State private var capturedImage: UIImage?
    @State private var isProcessing = false
    @State private var extractedInfo = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("id_capture_title")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("id_capture_description")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                if let image = capturedImage {
                    VStack(spacing: 16) {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 200)
                            .cornerRadius(12)
                            .shadow(radius: 4)
                        
                        Button(action: {
                            capturedImage = nil
                            extractedInfo = ""
                        }) {
                            Text("retake_photo")
                                .foregroundColor(.blue)
                        }
                    }
                } else {
                    VStack(spacing: 16) {
                        Image(systemName: "camera.viewfinder")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            showingCamera = true
                        }) {
                            HStack {
                                Image(systemName: "camera.fill")
                                Text("capture_id")
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                    }
                }
                
                if isProcessing {
                    VStack(spacing: 8) {
                        ProgressView()
                        Text("processing_id")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
                
                if !extractedInfo.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("extracted_information")
                            .font(.headline)
                        
                        ScrollView {
                            Text(extractedInfo)
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxHeight: 150)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        
                        Button(action: {
                            saveIDDocument()
                        }) {
                            Text("save_id_document")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("id_capture")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingCamera) {
            CameraView { image in
                capturedImage = image
                processIDImage(image)
            }
        }
    }
    
    private func processIDImage(_ image: UIImage) {
        isProcessing = true
        
        // Simulate ID processing with OCR
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            extractedInfo = """
            Document Type: ID Card
            Name: John Doe
            ID Number: 123456789
            Date of Birth: 01/01/1990
            Expiry Date: 01/01/2030
            Address: Sample Street 123, City
            """
            isProcessing = false
        }
    }
    
    private func saveIDDocument() {
        guard let imageData = capturedImage?.jpegData(compressionQuality: 0.8) else { return }
        
        let newDocument = Document(context: viewContext)
        newDocument.id = UUID()
        newDocument.title = "ID Document - \(Date().formatted(date: .abbreviated, time: .omitted))"
        newDocument.filename = "id_\(Date().timeIntervalSince1970).jpg"
        newDocument.templateType = "id_document"
        newDocument.content = imageData
        newDocument.createdAt = Date()
        newDocument.modifiedAt = Date()
        
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
    IDCaptureView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}