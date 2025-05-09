import SwiftUI

struct GoalsView: View {
    @State private var longTermGoal = "Learn SwiftUI"
    @State private var weeklyProgress = Array(repeating: false, count: 7)

    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Image(systemName: "chevron.left")
                Spacer()
                Text("Goals")
                    .font(.largeTitle).bold()
                Spacer()
            }
            .padding()
            .background(Color(red: 0.46, green: 0.68, blue: 0.96))

            // Long-Term Goal
            VStack(alignment: .leading) {
                Text("Long-Term Goal")
                    .font(.headline)
                TextEditor(text: $longTermGoal)
                    .frame(height: 80)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
            }
            .padding()

            // Weekly Progress
            VStack(alignment: .leading) {
                Text("Weekly Progress")
                    .font(.headline)
                HStack {
                    ForEach(0..<7) { i in
                        Rectangle()
                            .fill(weeklyProgress[i] ? .green : .gray)
                            .frame(width: 30, height: 30)
                            .cornerRadius(4)
                            .onTapGesture {
                                weeklyProgress[i].toggle()
                            }
                    }
                }
            }
            .padding()

            // Rewards Section
            VStack(alignment: .leading) {
                Text("Rewards")
                    .font(.headline)
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 60, height: 60)
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 60, height: 60)
                }
            }
            .padding()

            Spacer()
        }
    }
}

