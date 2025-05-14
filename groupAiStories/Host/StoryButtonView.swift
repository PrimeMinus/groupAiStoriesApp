//
//  StoryButtonView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct StoryButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let setting: String
    let theme: String
    let instructions: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            HStack {
                HStack {
                    VStack (alignment: .leading) {
                        Text(title)
                            .bold()
                            .multilineTextAlignment(.leading)
                        Text("Setting: "+setting)
                            .multilineTextAlignment(.leading)
                        Text("Theme: "+theme)
                            .multilineTextAlignment(.leading)
                        Text("Instructions: "+instructions)
                            .multilineTextAlignment(.leading)
                    }
                    .foregroundStyle(colorScheme == .dark ? Color.white : Color.black)
                    .padding()
                    Spacer()
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
            }
            .foregroundStyle(Color.white)
        })
    }
}

#Preview {
    StoryButtonView(title: "Hunger Games 1", setting: "Stone Fortress", theme: "Mideval", instructions: "Eliminate players in fights to the death", buttonAction: {print("Button Tapped")})
}
