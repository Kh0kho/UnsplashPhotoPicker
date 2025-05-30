import SwiftUI

struct PhotoCellView: View {
    let photo: Photo
    let onPhotoTap: (Photo) -> Void
    
    var body: some View {
        Button {
            onPhotoTap(photo)
        } label: {
            let urlString = photo.urls.small.isEmpty ? photo.urls.regular : photo.urls.small
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .cornerRadius(8)
                case .failure:
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGray6))
                            .cornerRadius(8)
                            .frame(height: 150)
                        VStack{
                            
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.gray)
                            Text("Failed to Load Image")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                @unknown default:
                    ProgressView()
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}



//#Preview {
//    return PhotoCellView()
//}
