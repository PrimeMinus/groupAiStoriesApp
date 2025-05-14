//
//  NewHostView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct NewHostView: View {
    
    @Binding var path: NavigationPath
    @EnvironmentObject var appData: AppData
    
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    @AppStorage("defaultPlayerCharacteristics") var defaultPlayerCharacteristics: String = ""
    
    var body: some View {
            VStack {
                Text("Start from a template:")
                StoryButtonView(title: "Hunger Games 1", setting: "Stone Fortress", theme: "Mideval", instructions: "Eliminate players in fights to the death", buttonAction: {
                    path.append("edit")
                    appData.currentStory.id = String(String(UUID().hashValue).suffix(4))
                    appData.currentStory.title = "Hunger Games 1"
                    appData.currentStory.setting = "Stone Fortress"
                    appData.currentStory.theme = "Mideval"
                    appData.currentStory.instructions = "Eliminate players in fights to the death"
                    appData.currentStory.players = [Player(id: String(String(UUID().hashValue).suffix(4)), name: defaultPlayerName, characteristics: defaultPlayerCharacteristics)]
                    appData.currentStory.content = []
                    uploadNewStory(story: appData.currentStory)
                })

            }
            .navigationTitle(Text("Host New Story"))
    }
}

#Preview {
//    NewHostView(path: )
    HomeView()
}
