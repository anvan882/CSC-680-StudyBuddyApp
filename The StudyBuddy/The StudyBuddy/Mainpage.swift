import SwiftUI

struct MainScreen: View {
    @AppStorage("studyGoal") private var studyGoal: String = ""
    @AppStorage("quoteOfTheDay") private var quoteOfTheDay: String = ""

    @State private var tempGoal: String = ""
    @State private var tempQuote: String = ""

    var body: some View {
        VStack(spacing: 24) {

            // The Header
            ZStack(alignment: .bottom) {
                Color(red: 0.46, green: 0.68, blue: 0.96)
                    .ignoresSafeArea(edges: .top)

                VStack(spacing: 10) {
                    Image("planner_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 4)

                    Text("STUDY BUDDY")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                }
                .padding(.bottom, 12)
            }
            .frame(height: 160)

            // The Daily Goal section
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Daily Study Goal")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        studyGoal = tempGoal
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.blue)
                    }
                }

                ZStack(alignment: .bottomTrailing) {
                    TextEditor(text: $tempGoal)
                        .frame(height: 80)
                        .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                }
            }
            .padding(.horizontal)

            // The start
            Button(action: {
                // The Start study action
            }) {
                Text("Start Studying")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .shadow(radius: 4)
            }
            .padding(.horizontal)

            // The subjects button
            VStack(spacing: 12) {
                HStack(spacing: 16) {
                    subjectButton("Math")
                    subjectButton("History")
                }
                HStack(spacing: 16) {
                    subjectButton("Biology")
                    subjectButton("English")
                }
                HStack {
                    subjectButton("Add new subject +")
                }
            }

            // The Qoute sections
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Quote of the Day")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Spacer()
                    Button(action: {
                        quoteOfTheDay = tempQuote
                    }) {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.blue)
                    }
                }

                ZStack(alignment: .bottomTrailing) {
                    TextEditor(text: $tempQuote)
                        .frame(height: 80)
                        .padding(4)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .onAppear {
            tempGoal = studyGoal
            tempQuote = quoteOfTheDay
        }
    // The subject Button view
    func subjectButton(_ title: String) -> some View {
        Button(action: {
        }) {
            Text(title)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .frame(width: 140, height: 60)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .shadow(radius: 3)
                .foregroundColor(.black)
        }
    }
}


