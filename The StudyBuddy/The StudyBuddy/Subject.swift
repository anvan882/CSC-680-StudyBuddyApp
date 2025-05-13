import Foundation

struct Subject: Identifiable, Codable, Equatable {
    let id = UUID()
    var name: String
    var isStarred: Bool
    var customDuration: Int?
    var goal: String?
    var checklist: [String]
    var notes: String?
}


