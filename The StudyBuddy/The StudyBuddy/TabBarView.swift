import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MainScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SessionView(subject: Subject(
                
                // this part is used for mainpage
                name: "Default Subject",
                isStarred: false,
                customDuration: 25,
                goal: "Focus on anything",
                checklist: [],
                notes: ""
            ))
            .tabItem {
                Label("Session", systemImage: "clock")
            }
            
            GoalsView()
                .tabItem {
                    Label("Goals", systemImage: "flag")
                }

            SettingsView()
                .tabItem {
                    Label("Setting", systemImage: "gear")
                }
        }
    }
}
