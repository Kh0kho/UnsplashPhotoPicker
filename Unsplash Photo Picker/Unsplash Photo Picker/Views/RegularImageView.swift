//
//  RegularImageView.swift
//  Unsplash Photo Picker
//
//  Created by khokho on 30.05.25.
//

import SwiftUI

struct RegularImageView: View {
    let photo: Photo
    @State private var showFullImage = false
    
    var body: some View {
        AsyncImage(url: URL(string: photo.urls.regular)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width:370, height: 370)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
            case .failure(_):
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Failed to load")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width:370, height: 370)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:370, height: 370)
                    .clipped()
                    .cornerRadius(8)
                
            @unknown default:
                VStack {
                    Image(systemName: "questionmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue)
                    Text("Unknown error")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width:370, height: 370)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .onTapGesture {
            showFullImage = true
        }
        .fullScreenCover(isPresented: $showFullImage) {
            if let fullURL = URL(string: photo.urls.full) {
                FullImageView(url: fullURL)
            }
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

    RegularImageView(photo: mockPhoto)
}
