//
//  SettingsView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/25/25.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    @AppStorage("defaultPlayerCharacteristics") var defaultPlayerCharacteristics: String = ""
    @AppStorage("developerMode") var developerMode: Bool = false
    
    @State var exitFunction: () -> Void
    @State private var nameOnOpen = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Default Name")) {
                    TextField("Name", text: $defaultPlayerName)
                        .onChange(of: defaultPlayerName) { oldName, newName in
                            if newName == "" {
                                defaultPlayerName = nameOnOpen
                            }
                        }
                        .task {
                            nameOnOpen = defaultPlayerName
                        }
                }
                Section(header: Text("Default Characteristics")) {
                    TextEditor(text: $defaultPlayerCharacteristics)
                }
                Section {
                    Toggle("Developer Mode", isOn: $developerMode)
                }
                Section(header: Text("App")) {
                    if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                       let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                        Text("Version: \(version)")
                        Text("Build: \(build)")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        exitFunction()
                    }, label: {
                        Text("Save")
                    })
                })
            }
        }
    }
}

#Preview {
    SettingsView(exitFunction: {})
}
