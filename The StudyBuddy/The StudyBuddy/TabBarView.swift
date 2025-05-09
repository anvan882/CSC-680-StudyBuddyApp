//
//  TabBarView.swift
//  The StudyBuddy
//
//  Created by Annison Van on 5/9/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MainScreen()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SessionView()
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
