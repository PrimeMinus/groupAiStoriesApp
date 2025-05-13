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
                    .background(Color.green)
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
            VStack {
//                Text(appData.currentStory.content[slide])
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                    .font(.title)
                    .bold()
                    .padding()
            }
            //side tap buttons
            HStack {
                Button(action: {
                    if slide > 0 {
                        slide -= 1
                    }
                }, label: {
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.85 )
//                            .background(Color.red)
                })
                Button(action: {
                    if slide < appData.currentStory.content.count {
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

//func stringTo() -> some View {
//    
//}
