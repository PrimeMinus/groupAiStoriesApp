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
        } else if appData.currentStory.id != "" || true {
            if appData.currentStory.content.count > 0 {
                
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
