//
//  NewHostView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct NewHostView: View {
    
    @Binding var path: NavigationPath
    @EnvironmentObject var appData: AppData
    
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    @AppStorage("defaultPlayerCharacteristics") var defaultPlayerCharacteristics: String = ""
    
    @AppStorage("gameIdHistory") var gameIdHistoryJSON: String = "[\"ex1\", \"ex2\"]"
    
    @State private var gameHistory: [Story] = []
    
    var body: some View {
            ScrollView {
                LazyVStack (alignment: .leading) {
                    Text("Start from a template:")
                    ForEach(gameHistory, id: \.id) { story in
                        StoryButtonView(title: story.title, setting: story.setting, theme: story.theme, instructions: story.instructions, buttonAction: {
                            //                        path.append("edit")
                            appData.currentStory.id = String(String(UUID().hashValue).suffix(4))
                            appData.currentStory.title = story.title
                            appData.currentStory.setting = story.setting
                            appData.currentStory.theme = story.theme
                            appData.currentStory.instructions = story.instructions
                            appData.currentStory.players = [Player(id: String(String(UUID().hashValue).suffix(4)), name: defaultPlayerName, characteristics: defaultPlayerCharacteristics)]
                            appData.currentStory.content = []
                            uploadNewStory(story: appData.currentStory)
                            appData.isHost = true
                        })
                    }
                    if gameHistory.isEmpty {
                        ProgressView()
                    }
                }
                .padding()
            }
            .navigationTitle(Text("Host New Story"))
            .task {
                var gameIdHistory: [String] = []
                if let data = gameIdHistoryJSON.data(using: .utf8) {
                    do {
                        let array = try JSONDecoder().decode([String].self, from: data)
                        gameIdHistory = array
                        print(gameIdHistory)
                    } catch {
                        print("Decoding failed: \(error)")
                    }
                }
                
                for gameId in gameIdHistory {
                    fetchStory(id: gameId) { story in
                        if let story = story {
                            gameHistory.append(story)
                        } else {
                            print("No story returned.")
                        }
                    }
                }
            }
    }
}

#Preview {
//    NewHostView(path: )
    HomeView()
}
