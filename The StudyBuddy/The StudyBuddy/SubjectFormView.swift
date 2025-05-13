import SwiftUI

struct SubjectFormView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var subjects: [Subject]

    @State private var name = ""
    @State private var duration = "25"
    @State private var goal = ""
    @State private var checklist = ""
    @State private var notes = ""

    var body: some View {
        Form {
            Section(header: Text("Subject Info")) {
                TextField("Name", text: $name)
                TextField("Duration (minutes)", text: $duration)
                    .keyboardType(.numberPad)
            }

            Section(header: Text("Goal")) {
                TextField("Goal", text: $goal)
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

                let newSubject = Subject(
                    name: name,
                    isStarred: false,
                    customDuration: Int(duration) ?? 25,
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

