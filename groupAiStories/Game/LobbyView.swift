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
    
    @State private var editingPlayer = Player(id: "", name: "", characteristics: "")
    @State private var showEditPlayerSheet = false
    @State private var showEditStorySheet = false
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    VStack (alignment: .leading, spacing: 10) {
                        Text(appData.currentStory.title)
                            .bold()
                            .font(.title)
                        Button(action: {
                            showEditStorySheet.toggle()
                        }, label: {
                            Image(systemName: "pencil")
                            Text("Edit")
                        })
                        .sheet(isPresented: $showEditStorySheet, content: {
                            EditStorySheetView(exitFunction: {
                                showEditStorySheet.toggle()
                            })
                        })
                        HStack {
                            Image(systemName: "crown.fill")
                                .foregroundStyle(Color.yellow)
                            Text("\(appData.currentStory.winners) Winners")
                                .bold()
                                .font(.title3)
                        }
                        HStack {
                            Image(systemName: "map.fill")
                                .foregroundStyle(Color.brown)
                            Text(appData.currentStory.setting)
                                .bold()
                                .font(.title3)
                        }
                        HStack {
                            Image(systemName: "book.fill")
                                .foregroundStyle(Color.green)
                            Text(appData.currentStory.theme)
                                .bold()
                                .font(.title3)
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
                        //MARK: - player title
                        HStack {
                            Text("Players")
                                .bold()
                                .font(.title)
                            Spacer()
                            Button(action: {
                                editingPlayer = Player(id: String(String(UUID().hashValue).suffix(4)), name: "", characteristics: "")
                                showEditPlayerSheet.toggle()
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add")
                            })
                        }
                        .sheet(isPresented: $showEditPlayerSheet, content: {
                            EditPlayerSheetView(player: editingPlayer) {
                                showEditPlayerSheet.toggle()
                            }
                        })
                        .task {
                            editingPlayer = appData.currentStory.players.first ?? Player(id: "", name: "", characteristics: "")
                        }
                        //MARK: - player list
                        LazyVStack(alignment: .leading) {
                            ForEach(chunked(appData.currentStory.players, into: 2), id: \.self) { pair in
                                HStack {
                                    ForEach(pair) { player in
                                        Button(action: {
                                            editingPlayer = player
                                            showEditPlayerSheet.toggle()
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
                                                        Image(systemName: "pencil")
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
                            fetchStory(id: appData.currentStory.id) { story in
                                if let story = story {
                                    DispatchQueue.main.async {
                                        appData.currentStory = story
                                    }
                                    print(appData.currentStory)
                                } else {
                                    print("No story returned.")
                                }
                            }
                            print(appData.currentStory)
                        }
                }
                .onDisappear {
                    timerSubscription?.cancel()
                    timerSubscription = nil
                }
            } // End of scroll view
            Button(action: {
                if appData.currentStory.players.count > 1 {
                    generateStory(id: appData.currentStory.id)
                    appData.currentStory.content = []
                    appData.currentStory.content.append("loading")
                }
            }, label: {
                HStack {
                    HStack {
                        Spacer()
                        Text("Generate")
                            .frame(height: 50)
                            .bold()
                        Spacer()
                    }
                    .background(appData.currentStory.players.count > 1  ? Color.teal : Color.gray)
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

