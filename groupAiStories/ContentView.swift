//
//  ContentView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var appData: AppData
    @State private var showWelcomeScreen: Bool = true
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    
    var body: some View {
        if showWelcomeScreen {
            WelcomeView(buttonAction: {
                showWelcomeScreen = false
            })
            .task {
                if defaultPlayerName != "" {
                    showWelcomeScreen = false
                }
            }
        // if user is in a story
        } else if appData.currentStory.id != "" || true {
            // if story has content
            if appData.currentStory.content.count > 0 {
                if appData.currentStory.content[0] == "loading" {
                    
                }
            } else {
                LobbyView()
            }
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
