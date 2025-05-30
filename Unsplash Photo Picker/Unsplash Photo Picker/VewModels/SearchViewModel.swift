
import Foundation
import Combine

@MainActor
class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var photos: [Photo] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    init() {
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                if !query.isEmpty {
                    Task {
                        await self.searchPhotos(query: query)
                    }
                } else {
                    self.photos = []
                    self.errorMessage = nil
                }
            }
            .store(in: &cancellables)
    }

    func searchPhotos(query: String) async {
        isLoading = true
        errorMessage = nil

        do {
            let results = try await NetworkManager.shared.searchPhotos(query: query)
            photos = results
            if results.isEmpty && !query.isEmpty {
                errorMessage = "Nothing Found"
            }
        } catch let error as URLError {
            switch error.code {
            case .badURL:
                errorMessage = "Invalid URL."
            case .notConnectedToInternet:
                errorMessage = "No internet connection."
            default:
                errorMessage = "Failed to load photos."
            }
            print("Network Error: \(error)")
        } catch {
            errorMessage = "Failed to load photos."
            print("Unexpected Error: \(error)")
        }

        isLoading = false
    }
}
