import SwiftUI

struct FullImageView: View {
    let url: URL
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()

            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .tint(Color.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .failure(_):
                    Text("Failed to load image")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                @unknown default:
                    Text("Unknown error loading image")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }

            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 30))
                    .padding()
                    .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    FullImageView(url: URL(string: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?crop=entropy&cs=srgb&fm=jpg&ixid=M3w3NTQ5NDF8MHwxfHNlYXJjaHwxfHxidXJnZXJ8ZW58MHx8fHwxNzQ4NTQxMzU2fDA&ixlib=rb-4.1.0&q=85")!)
}
