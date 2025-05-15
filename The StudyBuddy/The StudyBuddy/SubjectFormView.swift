import SwiftUI

struct SubjectFormView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var subjects: [Subject]

    @State private var name = ""
    @State private var durationText = "25:00"  // ⏱ mm:ss format
    @State private var goal = ""
    @State private var checklist = ""
    @State private var notes = ""

    // Format seconds to mm:ss string
    private func formatDuration(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Parse mm:ss string to seconds
    private func parseDuration(_ input: String) -> Int? {
        let parts = input.split(separator: ":")
        if parts.count == 2,
           let min = Int(parts[0]),
           let sec = Int(parts[1]),
           sec >= 0 && sec < 60 {
            return min * 60 + sec
        }
        return nil
    }

    var body: some View {
        Form {
            Section(header: Text("Subject Info")) {
                TextField("Name", text: $name)

                TextField("Duration (mm:ss) ", text: $durationText)
                    .keyboardType(.numbersAndPunctuation)
            }


            Section(header: Text("Checklist (comma separated)")) {
                TextField("Checklist", text: $checklist)
            }

            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(height: 100)
            }

            Button("Save Subject") {
                let checklistItems = checklist
                    .split(separator: ",")
                    .map { $0.trimmingCharacters(in: .whitespaces) }

                let durationInSeconds = parseDuration(durationText) ?? 1500 // fallback: 25 mins

                let newSubject = Subject(
                    name: name,
                    isStarred: false,
                    customDuration: durationInSeconds,
                    goal: goal,
                    checklist: checklistItems,
                    notes: notes
                )

                subjects.append(newSubject)
                dismiss()
            }
        }
        .navigationTitle("New Subject")
    }
}
