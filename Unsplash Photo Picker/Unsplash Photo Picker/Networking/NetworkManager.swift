import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.unsplash.com"
    private let accessKey = "4aiBBLGk5V9biPmy5hz4AVfaFrYJ2uuuUl5OgKOH0Pc"
    
    private init() {}

    func searchPhotos(query: String) async throws -> [Photo] {
        let endpoint = "\(baseURL)/search/photos?query=\(query)&per_page=14&client_id=\(accessKey)"
        guard let url = URL(string: endpoint) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(SearchResult.self, from: data)
        return decoded.results
    }
}

