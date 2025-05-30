import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var selectedPhoto: Photo? = nil
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack {
            if !isFocused {
                VStack {
                    Spacer().frame(height: 80)
                    Image("Unsplash_wordmark_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .padding(.horizontal)
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
            
            
    

            TextField("Search photos...", text: $viewModel.searchQuery)
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .font(.system(size: 18))
                .focused($isFocused)
                .submitLabel(.search)

            if isFocused {
                Spacer().frame(height: 10)
            } else {
                Spacer()
            }

            if isFocused {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                ScrollView {
                    HStack(alignment: .top, spacing: 12) {
                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                            ForEach(viewModel.photos.indices.filter { $0 % 2 != 0 }, id: \.self) { index in
                                PhotoCellView(photo: viewModel.photos[index]) { tappedPhoto in
                                    selectedPhoto = tappedPhoto
                                }
                            }
                        }

                        LazyVGrid(columns: [GridItem(.flexible())], spacing: 12) {
                            ForEach(viewModel.photos.indices.filter { $0 % 2 == 0 }, id: \.self) { index in
                                PhotoCellView(photo: viewModel.photos[index]) { tappedPhoto in
                                    selectedPhoto = tappedPhoto
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .animation(.easeInOut, value: isFocused)
        .onTapGesture {
            isFocused = false
        }
        .fullScreenCover(item: $selectedPhoto) { selected in
            FullScreenImageView(photo: selected)
        }
    }
}


#Preview {
    SearchView()
}
