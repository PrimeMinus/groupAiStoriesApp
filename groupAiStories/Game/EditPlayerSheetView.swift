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
    
    @State var exitFunction: () -> Void
    
    @EnvironmentObject var appData: AppData
    
    @FocusState private var isTyping: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Group AI Stories")
                    .font(.largeTitle)
                    .bold()
                Text("Name:")
                TextField("Name", text: $player.name)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 15)
                    .focused($isTyping)
                    .keyboardType(.alphabet)
                    .onSubmit {
                        
                    }
                    .background(.bar)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 15,
                            bottomLeadingRadius: 15,
                            bottomTrailingRadius: 15,
                            topTrailingRadius: 15
                        )
                    )
                Text("Characteristics:")
                TextField("Characteristics", text: $player.characteristics)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    .padding(.leading, 15)
                    .focused($isTyping)
                    .keyboardType(.alphabet)
                    .onSubmit {
                        
                    }
                    .background(.bar)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 15,
                            bottomLeadingRadius: 15,
                            bottomTrailingRadius: 15,
                            topTrailingRadius: 15
                        )
                    )
                Button(action: {
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
                }, label: {
                    HStack {
                        HStack {
                            Spacer()
                            Text(editingPlayerIndex != -1 ? "Edit Player" : "Add Player")
                                .frame(height: 50)
                                .bold()
                            Spacer()
                        }
                        .background(player.name != "" ? Color.accentColor : Color.gray)
                        .clipShape(
                            .rect(
                                topLeadingRadius: 15,
                                bottomLeadingRadius: 15,
                                bottomTrailingRadius: 15,
                                topTrailingRadius: 15
                            )
                        )
                    }
                    .foregroundStyle(Color.white)
                    .padding(.leading, 50)
                    .padding(.trailing, 50)
                })
            }
            .padding()
            .task {
                if appData.currentStory.players.contains(player) {
                    editingPlayerIndex = appData.currentStory.players.firstIndex(of: player)!
                }
            }
            .navigationTitle(editingPlayerIndex != -1 ? "Edit Player" : "Add Player")
                .navigationBarTitleDisplayMode(.inline)
            //MARK: - TOOLBAR
                .toolbar(content: {
                    // KICK PLAYER BUTTON
                    if editingPlayerIndex != -1 {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                player.name = ""
                                editPlayer(storyId: appData.currentStory.id, player: player)
                                appData.currentStory.players.remove(at: editingPlayerIndex)
                                exitFunction()
                            }, label: {
                                Text("Kick")
                                    .foregroundStyle(Color.red)
                            })
                        }
                    }
                    // CANCEL BUTTON
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            exitFunction()
                        }, label: {
                            Text("Cancel")
                        })
                    }
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
