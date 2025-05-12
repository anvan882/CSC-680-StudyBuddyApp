import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("studyDuration") private var studyDuration = 25
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        VStack(spacing: 0) {
            header

            Form {
                Section(header: Text("Session Settings")) {
                    Stepper(value: $studyDuration, in: 5...120, step: 5) {
                        Text("Study Duration: \(studyDuration) minutes")
                    }
                }

                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    Toggle("Dark Mode", isOn: $darkMode)
                }

                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Spacer()
            Text("Settings")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding()
        .background(Color(red: 0.46, green: 0.68, blue: 0.96))
    }
}
