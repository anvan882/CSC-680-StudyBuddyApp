import SwiftUI

@MainActor
struct MainScreen: View {
    @AppStorage("studyGoal") private var studyGoal: String = ""
    @AppStorage("quoteOfTheDay") private var quoteOfTheDay: String = ""

    @State private var tempGoal: String = ""
    @State private var tempQuote: String = ""

    @State private var subjects: [Subject] = [
        Subject(name: "Math", isStarred: false, customDuration: 2700, goal: "No Goal", checklist: [], notes: "Math note"),
        Subject(name: "Rest", isStarred: false, customDuration: 900, goal: "No Goal", checklist: [], notes: "Rest note")
    ]

    @State private var selectedSubject: Subject? = nil
    @State private var isNavigatingToSession = false
    @State private var generalSubject = Subject(name: "General", isStarred: false, customDuration: nil, goal: nil, checklist: [], notes: nil)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Image("planner_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 36, height: 36)
                            .clipShape(Circle())
                            .shadow(radius: 2)

                        Spacer()

                        Text("STUDY BUDDY")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.black)

                        Spacer()
                    }
                    .padding()
                    .background(Color(red: 0.46, green: 0.68, blue: 0.96))
                    .ignoresSafeArea(edges: .top)

                    // Daily Goal Editor
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Daily Study Goal")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                            Spacer()
                            Button(action: { studyGoal = tempGoal }) {
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.blue)
                            }
                        }

                        TextEditor(text: $tempGoal)
                            .frame(height: 80)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                    }
                    .padding(.horizontal)

                    // Start Studying Button
                    Button(action: {
                        selectedSubject = generalSubject
                        isNavigatingToSession = true
                    }) {
                        Text("Start Studying")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                            .shadow(radius: 4)
                    }
                    .padding(.horizontal)

                    // Subject List
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Your Study Subjects")
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                            NavigationLink(destination: SubjectFormView(subjects: $subjects)) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.blue)
                            }
                        }

                        Text("These are preset subject that you can add by click on + on the right and fill the form and save it as a new preset which save your entered informations. Scroll to see all your subjects. Tap ⭐ to prioritize.")
                            .font(.caption)
                            .foregroundColor(.gray)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(sortedSubjects) { subject in
                                    ZStack(alignment: .topTrailing) {
                                        Button(action: {
                                            selectedSubject = subject
                                            isNavigatingToSession = true
                                        }) {
                                            Text(subject.name)
                                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                                .frame(width: 100, height: 60)
                                                .background(Color.gray.opacity(0.3))
                                                .cornerRadius(10)
                                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
                                                .shadow(radius: 3)
                                                .foregroundColor(.black)
                                        }

                                        Button(action: {
                                            if let index = subjects.firstIndex(of: subject) {
                                                subjects.remove(at: index)
                                            }
                                        }) {
                                            Image(systemName: "trash")
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.red)
                                                .padding(6)
                                        }
                                        .offset(x: 4, y: -4)

                                        Button(action: {
                                            if let index = subjects.firstIndex(of: subject) {
                                                subjects[index].isStarred.toggle()
                                            }
                                        }) {
                                            Image(systemName: subject.isStarred ? "star.fill" : "star")
                                                .resizable()
                                                .frame(width: 14, height: 14)
                                                .foregroundColor(.yellow)
                                                .padding(6)
                                        }
                                        .offset(x: -22, y: -4)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .padding(.horizontal)

                    // Quote of the Day
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Quote of the Day")
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                            Spacer()
                            Button(action: { quoteOfTheDay = tempQuote }) {
                                Image(systemName: "square.and.arrow.down")
                                    .foregroundColor(.blue)
                            }
                        }

                        TextEditor(text: $tempQuote)
                            .frame(height: 80)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.4)))
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .onAppear {
                tempGoal = studyGoal
                tempQuote = quoteOfTheDay
            }
            .navigationDestination(isPresented: $isNavigatingToSession) {
                if let subject = selectedSubject {
                    SessionView(subject: subject)
                }
            }
        }
    }

    var sortedSubjects: [Subject] {
        subjects.sorted { $0.isStarred && !$1.isStarred }
    }
}
