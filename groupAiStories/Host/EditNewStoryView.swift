//
//  EditNewStoryView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct EditNewStoryView: View {
    
    @EnvironmentObject var appData: AppData
    
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    @AppStorage("defaultPlayerCharacteristics") var defaultPlayerCharacteristics: String = ""
    
    @FocusState private var isTyping: Bool
    
    var body: some View {
        Text("title")
        TextField("title", text: $appData.currentStory.title)
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
        Text("setting")
        TextField("setting", text: $appData.currentStory.setting)
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
        Text("theme")
        TextField("theme", text: $appData.currentStory.theme)
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
        Text("instructions")
        TextField("instructions", text: $appData.currentStory.instructions)
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
            isTyping = false
            appData.currentStory.id = String(String(UUID().hashValue).suffix(4))
            appData.currentStory.players = [
                Player(id: String(String(UUID().hashValue).suffix(4)), name: defaultPlayerName, characteristics: defaultPlayerCharacteristics)
            ]
            print(appData.currentStory)
            uploadNewStory(story: appData.currentStory)
        }, label: {
            HStack {
                HStack {
                    Spacer()
                    Text("Finish Setup")
                        .frame(height: 50)
                        .bold()
                    Spacer()
                }
                .background(appData.currentStory.title != "" ? Color.accentColor : Color.gray)
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
}

//#Preview {
//    EditNewStoryView()
//}
