//
//  HomeButtonsView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct HomeButtonsView: View {
    
    let icon: String
    let text: String
    let buttonAction: () -> Void
    
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            HStack {
                VStack (spacing: 0) {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.7)
                        .frame(height: 50)
                        .padding(.top, 5)
                    HStack {
                        Spacer()
                        Text(text)
                            .frame(height: 50)
                            .bold()
                            .padding(.top, -10)
                        Spacer()
                    }
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
            .padding(.leading, 50)
            .padding(.trailing, 50)
        })
    }
}

#Preview {
    HomeButtonsView(icon: "rectangle.stack.badge.plus", text: "Create New Story", buttonAction: {print("Button Tapped")})
}
