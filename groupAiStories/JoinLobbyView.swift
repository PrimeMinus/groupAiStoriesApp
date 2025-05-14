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
                            appData.currentStory.players.append(player)
                            editPlayer(storyId: story.id, player: player)
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
