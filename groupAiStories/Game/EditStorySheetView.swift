//
//  EditStorySheetView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/12/25.
//

import SwiftUI

struct EditStorySheetView: View {
    
    @State var exitFunction: () -> Void
    
    @State private var showInspectSheet = false
    
    @AppStorage("developerMode") var developerMode: Bool = false
    
    @EnvironmentObject var appData: AppData
    
    @FocusState private var isTyping: Bool
    
    @State private var story = Story(id: "0000", title: "", setting: "", theme: "", instructions: "", winners: 1, winningPlayers: [], players: [], content: [])
    
    var body: some View {
        NavigationStack {
            Form {
                Section(content: {
                    TextField("Title", text: $story.title)
                }, header: {
                    Text("Title")
                })
                Section(content: {
                    TextField("Setting", text: $story.setting)
                }, header: {
                    Text("Setting")
                })
                Section(content: {
                    TextField("Theme", text: $story.theme)
                }, header: {
                    Text("Theme")
                })
                Section(content: {
                    TextEditor(text: $story.instructions)
                }, header: {
                    Text("Instructions")
                })
                
                
                Section(content: {
                    if $story.players.count > 1 {
                        Stepper("Winners: \(story.winners)", value: $story.winners, in: 1...appData.currentStory.players.count - 1)
                    } else {
                        Stepper("Winners: -", value: .constant(0), in: 0...0)
                            .disabled(true)
                    }
                })
                
                if developerMode {
                    Section(content: {
                        Button("Inspect Story", role: .none, action: {
                            showInspectSheet.toggle()
                        })
                    })
                }
                
            }
            .navigationTitle("Edit Story")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showInspectSheet, content: {
                    StoryInspectView()
                })
            //MARK: - TOOLBAR
                .toolbar(content: {
                    // CANCEL BUTTON
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel", role: .cancel, action: {
                            exitFunction()
                        })
                    }
                    // SAVE BUTTON
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save", role: .none, action: {
                            if story.title == "" {
                                return
                            }
                            if (story.players.count <= 2) {
                                story.winners = 1
                            }
                            story.players = appData.currentStory.players
                            appData.currentStory = story
                            editStory(story: appData.currentStory)
                            exitFunction()
                        })
                        .bold()
                    }
                })
        }
        .task {
            story = appData.currentStory
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

    return EditStorySheetView(exitFunction: {print("exit")})
        .environmentObject(mockAppData)
}
