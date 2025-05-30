import SwiftUI

struct FullScreenImageView: View {
    let photo: Photo
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = FullScreenImageViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .padding()
                }
                
                Spacer()
                
                Button {
                    viewModel.downloadImage(from: photo.urls.full)
                } label: {
                    Image(systemName: "arrow.down.circle")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                        .padding()
                }
            }
            
            ScrollView {
                RegularImageView(photo: photo)
                
                VStack(spacing: 8) {
                    Text(photo.user.username)
                        .font(.headline)
                    Text(photo.user.name)
                        .font(.caption)
                    
                    if let description = photo.description ?? photo.alt_description {
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                }
                .padding(.horizontal)
            }
        }
        .alert("Saved", isPresented: $viewModel.saveSuccess) {
            Button("OK", role: .cancel) { }
        }
        .alert("Save failed", isPresented: Binding(get: {
            viewModel.saveError != nil
        }, set: { _ in
            viewModel.saveError = nil
        })) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.saveError?.localizedDescription ?? "Unknown error")
        }
    }
}




#Preview {
    let mockPhoto = Photo(
        id: "test",
        description: "burger with lettuce and tomatoes",
        alt_description: "burger with lettuce and tomatoes",
        urls: PhotoURLs(
            small: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQ5NDF8MHwxfHNlYXJjaHwxfHxidXJnZXJ8ZW58MHx8fHwxNzQ4NTQxMzU2fDA&ixlib=rb-4.1.0&q=80&w=400",
            regular: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NTQ5NDF8MHwxfHNlYXJjaHwxfHxidXJnZXJ8ZW58MHx8fHwxNzQ4NTQxMzU2fDA&ixlib=rb-4.1.0&q=80&w=1080",
            full: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3NTQ5NDF8MHwxfHNlYXJjaHwxfHxidXJnZXJ8ZW58MHx8fHwxNzQ4NTQxMzU2fDA&ixlib=rb-4.1.0&q=85"
        ),
        user: User(name: "John Doe", username: "John04")
    )

    return FullScreenImageView(photo: mockPhoto)
}
