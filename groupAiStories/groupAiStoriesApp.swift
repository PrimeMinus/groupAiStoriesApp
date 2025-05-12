//
//  groupAiStoriesApp.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var currentStory: Story = Story(id: "", title: "", setting: "", theme: "", instructions: "", winners: 0, winningPlayers: [], players: [], content: [])
}

@main
struct groupAiStoriesApp: App {
    @StateObject private var appData = AppData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
        }
    }
}
