import Foundation

struct SearchResult: Codable {
    let results: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: String
    let description: String?
    let alt_description: String?
    let urls: PhotoURLs
    let user: User
}

struct PhotoURLs: Codable {
    let small: String
    let regular: String
    let full: String
}

struct User: Codable {
    let name: String
    let username: String
}
