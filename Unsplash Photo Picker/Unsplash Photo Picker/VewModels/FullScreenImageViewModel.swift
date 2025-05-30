import SwiftUI

class FullScreenImageViewModel: ObservableObject {
    @Published var isSaving = false
    @Published var saveSuccess = false
    @Published var saveError: Error?

    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        isSaving = true

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isSaving = false
                if let data = data, let image = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                    self.saveSuccess = true
                } else {
                    self.saveError = error ?? NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not save image"])
                }
            }
        }.resume()
    }
}
