//
//  StoryContentView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/13/25.
//

import SwiftUI

struct StoryContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var appData: AppData
    
    @State private var slide = 0
    
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
        ZStack {
            VStack {
                HStack (spacing: 0) {
                    ForEach(0..<appData.currentStory.content.count, id: \.self) { index in
                        HStack {
                            Text("")
                        }
                        .frame(width: UIScreen.main.bounds.width/CGFloat(appData.currentStory.content.count)/1.05, height: 5)
                        .background(index <= slide ? (colorScheme == .dark ? Color.white : Color.black) : Color.gray)
                    }
                }
//                .padding(.leading)
//                .padding(.trailing)
                //Backdrop
                HStack {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.85 )
                        .background(storyContentColor(string: appData.currentStory.content[slide], players: appData.currentStory.players))
                        .clipShape(
                            .rect(
                                topLeadingRadius: 15,
                                bottomLeadingRadius: 15,
                                bottomTrailingRadius: 15,
                                topTrailingRadius: 15
                            )
                        )
                }
            }
            //Text
            VStack {
                HStack {
                    Spacer()
                }
                Spacer()
                Text(appData.currentStory.content[slide])
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.main.bounds.width * 0.90)
                    .foregroundStyle(Color.white)
                Spacer()
            }
            //side tap buttons
            HStack {
                // left (previous)
                Button(action: {
                    if slide > 0 {
                        slide -= 1
                    }
                }, label: {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.85 )
//                            .background(Color.red)
                })
                // right (next)
                Button(action: {
                    if slide < appData.currentStory.content.count - 1 {
                        slide += 1
                    }
                }, label: {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.85 )
                        .frame(width: UIScreen.main.bounds.width * 0.6 )
//                        .background(Color.blue)
                })
            }
            //MARK: - EXIT
            VStack {
                Spacer()
                if slide == appData.currentStory.content.count - 1 {
                    Button(action: {
                        appData.currentStory.id = ""
                    }, label: {
                        HStack {
                            HStack {
                                Spacer()
                                Text("Exit")
                                    .frame(height: 50)
                                    .bold()
                                Spacer()
                            }
                            .background(Color.red)
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 25,
                                    bottomLeadingRadius: 25,
                                    bottomTrailingRadius: 25,
                                    topTrailingRadius: 25
                                )
                            )
                        }
                        .foregroundStyle(Color.white)
                        .padding(.leading, 50)
                        .padding(.trailing, 50)
                    })
                }
            }
        }
        .task {
            // add this story to history
            // Update the @AppStorage property with the new array
            if !gameIdHistory.contains(appData.currentStory.id)  {
                var newArray = gameIdHistory
                newArray.append(appData.currentStory.id)
                updateSavedArray(newArray)
            }
        }
    }
}

func storyContentColor(string: String, players: [Player]) -> Color {
    for player in players {
        if string.contains(player.name) {
            return Color.fromString(player.id)
        }
    }
    
    return Color.teal
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
            Player(id: "2345", name: "Michael", characteristics: "stealth"),
            Player(id: "9875", name: "Zach", characteristics: "fast")
            
        ],
        content: ["It was a dark and stormy night...", "They found a hidden passage...", "Bryson", "Michael", "Zach", "", ""]
    )

    let mockAppData = AppData()
    mockAppData.currentStory = previewStory
    mockAppData.isHost = true

    return StoryContentView()
        .environmentObject(mockAppData)
}


