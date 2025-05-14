//
//  HistoryView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct HistoryView: View {
    
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
    @State private var gameHistory: [Story] = []
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(gameHistory, id: \.self) { story in
                    HStack {
                        StoryButtonView(title: story.title, setting: story.setting, theme: story.theme, instructions: story.instructions, buttonAction: {})
                        // Delete button
                        if !story.id.hasPrefix(("ex")) {
                            Button(action: {
                                // remove from history
                                var newArray = gameIdHistory
                                if newArray.contains(story.id) {
                                    newArray.remove(at: newArray.firstIndex(of: story.id)! )
                                }
                                updateSavedArray(newArray)
                            }, label: {
                                Image(systemName: "trash.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(Color.red)
                            })
                        }
                    }
                }
            }
        }
        .navigationTitle(Text("History"))
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
    HistoryView()
}
