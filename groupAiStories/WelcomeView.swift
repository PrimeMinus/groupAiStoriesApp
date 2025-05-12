//
//  WelcomeView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("defaultPlayerName") var defaultPlayerName: String = ""
    @AppStorage("defaultPlayerCharacteristics") var defaultPlayerCharacteristics: String = ""
    var buttonAction: () -> Void
    
    @FocusState private var isTyping: Bool
    
    var body: some View {
        VStack {
            Text("Group AI Stories")
                .font(.largeTitle)
                .bold()
            Text("Name:")
            TextField("Name", text: $defaultPlayerName)
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
            Text("Characteristics:")
            TextField("Characteristics", text: $defaultPlayerCharacteristics)
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
                if defaultPlayerName != "" {
                    buttonAction()
                }
            }, label: {
                HStack {
                    HStack {
                        Spacer()
                        Text("Finish Setup")
                            .frame(height: 50)
                            .bold()
                        Spacer()
                    }
                    .background(defaultPlayerName != "" ? Color.accentColor : Color.gray)
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
        .padding()
    }
}

#Preview {
    WelcomeView(buttonAction: { print(true)})
}
