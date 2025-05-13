import Foundation
import FirebaseFirestore

class FireBaseManager {
    static let shared = FireBaseManager()
    let db = Firestore.firestore()

    private init() {}

    // Save or update a session for a subject
    func saveSession(for subject: String, tasks: [String], notes: String, completion: ((Error?) -> Void)? = nil) {
        db.collection("subjects").document(subject).setData([
            "tasks": tasks,
            "notes": notes
        ]) { error in
            completion?(error)
        }
    }

    // Fetch session data for a subject
    func fetchSession(for subject: String, completion: @escaping (_ tasks: [String], _ notes: String) -> Void) {
        db.collection("subjects").document(subject).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                let tasks = data["tasks"] as? [String] ?? []
                let notes = data["notes"] as? String ?? ""
                completion(tasks, notes)
            } else {
                print("Failed to fetch session: \(error?.localizedDescription ?? "Unknown error")")
                completion([], "")
            }
        }
    }

    // Fetch all subjects
    func fetchAllSubjects(completion: @escaping (_ subjectNames: [String]) -> Void) {
        db.collection("subjects").getDocuments { snapshot, error in
            if let documents = snapshot?.documents {
                let names = documents.map { $0.documentID }
                completion(names)
            } else {
                print("Failed to fetch subjects:", error?.localizedDescription ?? "Unknown error")
                completion([])
            }
        }
    }
}

