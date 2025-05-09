import SwiftUI

// MARK: - Reward Model
struct Reward: Identifiable, Equatable {
    let id = UUID()
    var text: String
}

// MARK: - GoalsView
struct GoalsView: View {
    @State private var longTermGoal = ""
    @State private var weeklyProgress = Array(repeating: false, count: 7)
    @State private var rewards: [Reward] = []
    @State private var streakCount = 0
    @State private var showCompletionMessage = false

    private let dayLabels = ["M", "T", "W", "TH", "F", "ST", "SN"]

    var body: some View {
        VStack(spacing: 0) {
            header

            Divider()

            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 20) {
                    longTermGoalSection
                    progressSection
                    rewardsSection()
                }
                .padding(.bottom, 40)
            }
        }
        .edgesIgnoringSafeArea(.top)
    }

    // MARK: - Header
    private var header: some View {
        HStack {
            Image(systemName: "chevron.left")
            Spacer()
            Text("Goals")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding()
        .background(Color(red: 0.46, green: 0.68, blue: 0.96))
        .zIndex(1)
    }

    // MARK: - Long-Term Goal Section
    private var longTermGoalSection: some View {
        VStack(alignment: .center) {
            Text("Long-Term Goal")
                .font(.headline)
            TextEditor(text: $longTermGoal)
                .frame(height: 80)
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
                .frame(maxWidth: .infinity)
        }
        .padding()
    }

    // MARK: - Weekly Progress Section
    private var progressSection: some View {
        VStack(spacing: 10) {
            Text("Weekly Progress")
                .font(.headline)

            Text("Progress: \(weeklyProgress.filter { $0 }.count)/7 days")
                .font(.subheadline)
                .foregroundColor(.gray)

            if showCompletionMessage {
                Text("🎉 You did it! Reward yourself!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .transition(.opacity)
            }

            Text("Current Streak: \(streakCount) weeks 🔥")
                .font(.subheadline)
                .foregroundColor(.orange)

            HStack(spacing: 10) {
                ForEach(dayLabels, id: \.self) { day in
                    Text(day)
                        .font(.caption)
                        .frame(width: 30)
                }
            }

            HStack(spacing: 10) {
                ForEach(0..<7) { i in
                    Rectangle()
                        .fill(weeklyProgress[i] ? .green : .gray)
                        .frame(width: 30, height: 30)
                        .cornerRadius(4)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            weeklyProgress[i].toggle()
                            checkAndHandleWeekCompletion()
                        }
                }
            }
        }
        .padding()
    }

    // MARK: - Rewards Section
    @ViewBuilder
    private func rewardsSection() -> some View {
        VStack(spacing: 10) {
            HStack {
                Text("Rewards")
                    .font(.headline)
                Spacer()
                Button(action: {
                    withAnimation {
                        rewards.append(Reward(text: ""))
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
            }

            Text("Set a reward to motivate yourself when you complete the week!")
                .font(.caption)
                .foregroundColor(.gray)

            if rewards.isEmpty {
                Text("Tap + to add your first reward!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 10)
            }

            ForEach($rewards) { $reward in
                RewardItemView(
                    rewardText: $reward.text,
                    onDelete: {
                        if let index = rewards.firstIndex(where: { $0.id == reward.id }) {
                            withAnimation {
                                rewards.remove(at: index)
                            }
                        }
                    }
                )
            }
        }
        .padding()
    }

    // MARK: - Reward Item View
    struct RewardItemView: View {
        @Binding var rewardText: String
        var onDelete: () -> Void

        var body: some View {
            HStack(alignment: .top) {
                Text(emoji(for: rewardText))
                    .font(.largeTitle)
                    .padding(.top, 8)

                TextEditor(text: $rewardText)
                    .frame(height: 60)
                    .padding(4)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 2)

                Button(action: {
                    onDelete()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(.top, 8)
                }
            }
        }

        private func emoji(for reward: String) -> String {
            let lower = reward.lowercased()
            if lower.contains("game") { return "🎮" }
            if lower.contains("candy") || lower.contains("sweet") { return "🍬" }
            if lower.contains("tv") || lower.contains("movie") { return "📺" }
            if lower.contains("walk") { return "🚶" }
            if lower.contains("nap") { return "🛌" }
            return "⭐️"
        }
    }

    // MARK: - Week Completion Checker
    private func checkAndHandleWeekCompletion() {
        if weeklyProgress.allSatisfy({ $0 }) {
            streakCount += 1
            showCompletionMessage = true

            // Reset after 10 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                withAnimation {
                    showCompletionMessage = false
                    weeklyProgress = Array(repeating: false, count: 7)
                }
            }
        }
    }
}

