//
//  EditPlayerSheetView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/12/25.
//

import SwiftUI

struct EditPlayerSheetView: View {
    
    @State var player: Player
    @State private var editingPlayerIndex: Int = -1
    @State private var showKickAlert = false
    
    @State var exitFunction: () -> Void
    
    @EnvironmentObject var appData: AppData
    
    @FocusState private var isTyping: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(content: {
                    TextField("Name", text: $player.name)
                }, header: {
                    Text("Name")
                })
                Section(content: {
                    TextEditor(text: $player.characteristics)
                }, header: {
                    Text("Characteristics")
                })
                
//                Picker("Gender", selection: $player.characteristics) {
//                    Text("Male").tag("Apple")
//                    Text("Female").tag("Banana")
//                }
                
            }
            .navigationTitle(editingPlayerIndex != -1 ? "Edit Player" : "Add Player")
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    if appData.currentStory.players.contains(player) {
                        editingPlayerIndex = appData.currentStory.players.firstIndex(of: player)!
                    }
                }
            //MARK: - TOOLBAR
                .toolbar(content: {
                    // CANCEL BUTTON
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            exitFunction()
                        }, label: {
                            Text("Cancel")
                        })
                    }
                    // KICK PLAYER BUTTON
                    if editingPlayerIndex != -1 {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                showKickAlert.toggle()
                            }, label: {
                                Text("Kick")
                                    .foregroundStyle(Color.red)
                            })
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(editingPlayerIndex != -1 ? "Save" : "Add") {
                            if player.name == "" {
                                return
                            }
                            editPlayer(storyId: appData.currentStory.id, player: player)
                            if editingPlayerIndex != -1 {
                                appData.currentStory.players[editingPlayerIndex] = player
                            } else {
                                appData.currentStory.players.append(player)
                            }
                            exitFunction()
                        }
                        .bold()
                    }
                })
                .alert("Remove \"\(player.name)\" from the game?", isPresented: $showKickAlert, actions: {
                    Button("Cancel", role: .cancel, action: {
                        showKickAlert.toggle()
                    })
                    Button("Kick", role: .destructive, action: {
                            player.name = ""
                            editPlayer(storyId: appData.currentStory.id, player: player)
                            appData.currentStory.players.remove(at: editingPlayerIndex)
                            exitFunction()
                    })
                })
        }
    }
}

#Preview {
    let previewStory = Story(
        id: "1",
        title: "The Great Escape",
        setting: "Dungeon",
        theme: "Adventure",
        instructions: "Escape the dungeon using your skills. Escape the dungeon using your skills.",
        winners: 2,
        winningPlayers: ["Bryson", "Micheal"],
        players: [
            Player(id: "1234", name: "Bryson", characteristics: "smart"),
            Player(id: "2345", name: "Micheal", characteristics: "stealth"),
            Player(id: "3456", name: "Zach", characteristics: "fast")
            
        ],
        content: ["It was a dark and stormy night...", "They found a hidden passage..."]
    )

    let mockAppData = AppData()
    mockAppData.currentStory = previewStory
    mockAppData.isHost = true

    return EditPlayerSheetView(player: Player(id: "1234", name: "Bryson", characteristics: "smart"), exitFunction: {print("exit")})
        .environmentObject(mockAppData)
}
