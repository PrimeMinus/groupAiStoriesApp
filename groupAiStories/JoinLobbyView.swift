//
//  JoinLobbyView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/13/25.
//

import SwiftUI

struct JoinLobbyView: View {
    
    @State private var gameId: String = ""
    
    @EnvironmentObject var appData: AppData
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    @AppStorage("defaultPlayerCharacteristics") var defaultPlayerCharacteristics: String = ""
    
    @AppStorage("gameIdHistory") var gameIdHistoryJSON: String = "[\"ex1\", \"ex2\"]"
    // Helper to decode stored array
    private var gameIdHistory: [String] {
        get {
            if let data = gameIdHistoryJSON.data(using: .utf8),
               let array = try? JSONDecoder().decode([String].self, from: data) {
                return array
            }
            return []
        }
    }

    // Helper to update stored array
    private func updateSavedArray(_ newArray: [String]) {
        if let data = try? JSONEncoder().encode(newArray),
           let jsonString = String(data: data, encoding: .utf8) {
            gameIdHistoryJSON = jsonString
        }
    }
    
    var body: some View {
        Form {
            TextField("Game ID", text: $gameId)
                .keyboardType(.numberPad)
            Button("Join") {
                fetchStory(id: gameId) { story in
                    if let story = story {
                        DispatchQueue.main.async {
                            appData.currentStory = story
                            let player = Player(id: String(String(UUID().hashValue).suffix(4)), name: defaultPlayerName, characteristics: defaultPlayerCharacteristics)
                            if appData.currentStory.content.isEmpty {
                                appData.currentStory.players.append(player)
                                editPlayer(storyId: story.id, player: player)
                                
                            }
                            // add to history
                            var newArray = gameIdHistory
                            newArray.append(gameId)
                            updateSavedArray(newArray)
                        }
                        print(appData.currentStory)
                    } else {
                        print("No story returned.")
                    }
                }
            }
        }
    }
}

#Preview {
    JoinLobbyView()
}
