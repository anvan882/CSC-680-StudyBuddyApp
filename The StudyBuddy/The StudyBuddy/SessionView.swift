import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var name: String
    var isDone: Bool = false
}

struct SessionView: View {
    @Binding var subject: Subject
    @AppStorage("studyDuration") private var studyDuration = 25 // minutes
    @State private var isRunning = false
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer?
    @State private var tasks: [Task] = []
    @State private var newTask = ""
    @State private var notes = ""

    var body: some View {
        VStack(spacing: 0) {
            header

            ScrollView {
                VStack(spacing: 24) {
                    Text("📘 \(subject.name)") // Show the subject name

                    Text("Adjust timer in settings ")
                        .font(.footnote) // smaller
                        .foregroundColor(.gray) // gray color
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.top, 8)
                    timerSection
                    tasksSection
                    notesSection
                }
                .padding()
            }
        }
        .onAppear {
            timeRemaining = subject.customDuration ?? studyDuration * 60
            notes = subject.notes ?? ""
            tasks = subject.checklist.map { Task(name: $0) }
        }
        .onDisappear {
            timer?.invalidate()
            subject.checklist = tasks.map { $0.name }
            subject.notes = notes
        }
        
    }


    // MARK: - Header
    private var header: some View {
        HStack {
            Image(systemName: "chevron.left")
            Spacer()
            Text("Session")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding()
        .background(Color(red: 0.46, green: 0.68, blue: 0.96))
    }

    // MARK: - Timer Section
    private var timerSection: some View {
        VStack {
            Text(formatTime(timeRemaining))
                .font(.system(size: 48, weight: .bold))
                .onTapGesture {
                    toggleTimer()
                }

            Button(action: toggleTimer) {
                Image(systemName: isRunning ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)

            Button("Reset Timer") {
                resetTimer()
            }
            .foregroundColor(.red)
            .padding(.top, 4)
        }
    }

    // MARK: - Tasks Section
    private var tasksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Tasks")
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: addTask) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            }

            TextField("Enter a new task", text: $newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            ForEach(Array(tasks.enumerated()), id: \.element.id) { index, task in
                HStack {
                    Button(action: {
                        tasks[index].isDone.toggle()
                    }) {
                        Image(systemName: task.isDone ? "checkmark.square.fill" : "square")
                            .foregroundColor(.blue)
                    }

                    TextField("Task", text: Binding(
                        get: { tasks[index].name },
                        set: { tasks[index].name = $0 }
                    ))
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        tasks.remove(at: index)
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                    .padding(.leading, 4)
                }
            }
        }
    }

    // MARK: - Notes Section
    private var notesSection: some View {
        VStack(alignment: .leading) {
            Text("Notes")
                .font(.title2)
                .bold()
            TextEditor(text: $notes)
                .frame(height: 150)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
        }
    }

    // MARK: - Timer Helpers
    private func formatTime(_ seconds: Int) -> String {
        let min = seconds / 60
        let sec = seconds % 60
        return String(format: "%02d:%02d", min, sec)
    }

    private func toggleTimer() {
        isRunning.toggle()
        if isRunning {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    isRunning = false
                }
            }
        } else {
            timer?.invalidate()
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        isRunning = false
        timeRemaining = studyDuration * 60
    }

    private func addTask() {
        guard !newTask.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        tasks.append(Task(name: newTask))
        newTask = ""
    }
}
