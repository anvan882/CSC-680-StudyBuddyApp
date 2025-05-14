import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    @State private var subjects: [Subject] = []
    @State private var selectedSubject: Subject? = nil

    var body: some View {
        TabView(selection: $selectedTab) {
            MainScreen(
                subjects: $subjects,
                selectedTab: $selectedTab,
                selectedSubject: $selectedSubject
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }
            .tag(0)

            
            SessionView(
                subject: Binding(
                    get: {
                        selectedSubject ?? Subject(
                            name: "General",
                            isStarred: false,
                            customDuration: 1500,
                            goal: "Focus",
                            checklist: [],
                            notes: ""
                        )
                    },
                    set: { newValue in
                        if let index = subjects.firstIndex(where: { $0.id == selectedSubject?.id }) {
                            subjects[index] = newValue
                            selectedSubject = newValue
                        }
                    }
                )
            )
            .tabItem {
                Label("Session", systemImage: "clock")
            }
            .tag(1)
            


            GoalsView()
                .tabItem {
                    Label("Goals", systemImage: "flag")
                }
                .tag(2)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
        }
    }
}
