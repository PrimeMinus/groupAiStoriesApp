//
//  EditStorySheetView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/12/25.
//

import SwiftUI

struct EditStorySheetView: View {
    
    @State var exitFunction: () -> Void
    
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
                        .frame(minHeight: 45)
                }, header: {
                    Text("Instructions")
                })
                
                
                Section(content: {
                    if $story.players.count > 1 {
                        Stepper("Winners: \(story.winners)", value: $story.winners, in: 1...appData.currentStory.players.count - 1)
                    } else {
                        Stepper("Winners: -", value: $story.winners, in: 0...1)
                            .disabled(true)
                    }
                })
                
                Section(content: {
                    Button("Save Changes") {
                        if story.title == "" {
                            return
                        }
                        story.players = appData.currentStory.players
                        appData.currentStory = story
                        editStory(story: appData.currentStory)
                        exitFunction()
                    }
                })
            }
            .navigationTitle("Edit Story")
                .navigationBarTitleDisplayMode(.inline)
            //MARK: - TOOLBAR
                .toolbar(content: {
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
