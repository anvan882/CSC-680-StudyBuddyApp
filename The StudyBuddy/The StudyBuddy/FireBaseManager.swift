import Foundation
import FirebaseFirestore
import FirebaseAuth

let userID = Auth.auth().currentUser?.uid ?? "guest"

class FireBaseManager {
    static let shared = FireBaseManager()
    let db = Firestore.firestore()

    private init() {}
    
    func signInAnonymouslyIfNeeded() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously { result, error in
                if let error = error {
                    print("❌ Failed to sign in anonymously:", error.localizedDescription)
                } else {
                    print("✅ Signed in anonymously with UID:", result?.user.uid ?? "Unknown")
                }
            }
        }
        print("👤 UID now available:", Auth.auth().currentUser?.uid ?? "nil")
    }

    func saveGoalsViewData(longTermGoal: String, weeklyProgress: [Bool], rewards: [String], streakCount: Int, completion: ((Error?) -> Void)? = nil) {
        // Check if user is signed in
        guard let userID = Auth.auth().currentUser?.uid else {
            print("❌ No user logged in — retrying in 1 second...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.saveGoalsViewData(
                    longTermGoal: longTermGoal,
                    weeklyProgress: weeklyProgress,
                    rewards: rewards,
                    streakCount: streakCount,
                    completion: completion
                )
            }
            return
        }

        print("✅ Saving goals for UID:", userID)

        db.collection("goals").document(userID).setData([
            "longTermGoal": longTermGoal,
            "weeklyProgress": weeklyProgress,
            "rewards": rewards,
            "streakCount": streakCount
        ]) { error in
            completion?(error)
        }
    }


    func fetchGoalsViewData(completion: @escaping (_ longTermGoal: String, _ weeklyProgress: [Bool], _ rewards: [String], _ streakCount: Int) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            print("❌ No user logged in")
            return
        }

        db.collection("goals").document(userID).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                let longTermGoal = data["longTermGoal"] as? String ?? ""
                let weeklyProgress = data["weeklyProgress"] as? [Bool] ?? Array(repeating: false, count: 7)
                let rewards = data["rewards"] as? [String] ?? []
                let streakCount = data["streakCount"] as? Int ?? 0
                completion(longTermGoal, weeklyProgress, rewards, streakCount)
            } else {
                completion("", Array(repeating: false, count: 7), [], 0)
            }
        }
    }


}

