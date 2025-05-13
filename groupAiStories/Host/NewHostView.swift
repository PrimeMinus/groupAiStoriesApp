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
    
    var body: some View {
            VStack {
                Text("Start from a template:")
                StoryButtonView(title: "Hunger Games 1", setting: "Stone Fortress", theme: "Mideval", instructions: "Eliminate players in fights to the death", buttonAction: {
                    path.append("edit")
                    appData.currentStory.id = UUID().uuidString
                    appData.currentStory.title = "Hunger Games 1"
                    appData.currentStory.setting = ""
                    appData.currentStory.theme = ""
                    appData.currentStory.instructions = ""
                    appData.currentStory.players = []
                    appData.currentStory.content = []
                    uploadNewStory(story: appData.currentStory)
                })
                StoryButtonView(title: "Cooking Compitition", setting: "MasterChef", theme: "Gordan Ramsay", instructions: "Eliminate players in cooking competitions", buttonAction: {
                    path.append("edit")
                    appData.currentStory.id = UUID().uuidString
                    appData.currentStory.title = "Cooking Compitition"
                    appData.currentStory.setting = ""
                    appData.currentStory.theme = ""
                    appData.currentStory.instructions = ""
                    appData.currentStory.players = []
                    appData.currentStory.content = []
                })

            }
            .navigationTitle(Text("Host New Story"))
    }
}

#Preview {
//    NewHostView(path: )
    HomeView()
}
