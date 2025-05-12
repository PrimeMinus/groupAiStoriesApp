//
//  LobbyView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI
import Combine

struct LobbyView: View {
    
    @State private var timerSubscription: AnyCancellable?
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        ScrollView {
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    Text(appData.currentStory.title)
                        .bold()
                        .font(.title)
                    HStack {
                        Image(systemName: "map.fill")
                            .foregroundStyle(Color.brown)
                        Text(appData.currentStory.setting)
                            .bold()
                            .font(.title2)
                    }
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundStyle(Color.green)
                            .padding(.top, 12)
                        Text(appData.currentStory.theme)
                            .bold()
                            .font(.title2)
                    }
                    HStack {
                        VStack {
                            Image(systemName: "gear")
                                .foregroundStyle(Color.red)
                                .padding(.top, 12)
                            Spacer()
                        }
                        Text(appData.currentStory.instructions)
                            .bold()
                            .font(.title3)
                            .multilineTextAlignment(.leading)
                    }
                    Divider()
                    Text("Players")
                        .bold()
                        .font(.title)
                    LazyVStack(alignment: .leading) {
                        ForEach(chunked(appData.currentStory.players, into: 2), id: \.self) { pair in
                            HStack {
                                ForEach(pair) { player in
                                    Button(action: {
                                        print(true)
                                    }, label: {
                                        VStack {
                                            HStack {
                                                VStack {
                                                    Text(player.name)
                                                    Text(player.characteristics)
                                                }
                                                .padding(.leading, 5)
                                                Spacer()
                                                VStack {
                                                    Spacer()
                                                    Image(systemName: "pencil.circle")
                                                    Spacer()
                                                }
                                                .padding(.trailing, 5)
                                            }
                                            .background(Color.accentColor)
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
                                        .padding(.leading, 5)
                                        .padding(.trailing, 5)
                                    })
                                }
                            }
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .onAppear {
                timerSubscription = Timer.publish(every: 5, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
//                        fetchStory(id: "0634") { story in
//                            if let story = story {
//                                DispatchQueue.main.async {
//                                    appData.currentStory = story
//                                }
//                                print(appData.currentStory)
//                            } else {
//                                print("No story returned.")
//                            }
//                        }
                        print(appData.currentStory)
                    }
            }
            .onDisappear {
                timerSubscription?.cancel()
                timerSubscription = nil
            }
        }
    }
}

// Helper function to split array into chunks
func chunked<T>(_ array: [T], into size: Int) -> [[T]] {
    stride(from: 0, to: array.count, by: size).map {
        Array(array[$0..<min($0 + size, array.count)])
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

    return LobbyView()
        .environmentObject(mockAppData)
}

