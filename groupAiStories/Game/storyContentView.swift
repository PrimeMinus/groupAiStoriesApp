//
//  storyContentView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/13/25.
//

import SwiftUI

struct storyContentView: View {
    
    @EnvironmentObject var appData: AppData
    
    @State private var slide = 0
    
    var body: some View {
        ZStack {
            //Backdrop
            Spacer()
                .frame(height: UIScreen.main.bounds.height * 0.85 )
                .bold()
                    .background(Color.mint)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 15,
                            bottomLeadingRadius: 15,
                            bottomTrailingRadius: 15,
                            topTrailingRadius: 15
                        )
                    )
                .foregroundStyle(Color.white)
            //Text
            VStack (alignment: .leading) {
                Spacer()
//                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                Text(appData.currentStory.content[slide])
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.main.bounds.width * 0.90)
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
        }
    }
}

#Preview {
    storyContentView()
}


