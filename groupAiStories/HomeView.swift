//
//  HomeView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var path = NavigationPath()
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HomeButtonsView(icon: "rectangle.stack.badge.plus", text: "Host New", buttonAction: {
                    path.append("host")
                    print(path)
                })
                HomeButtonsView(icon: "person.3", text: "Join", buttonAction: {
                    path.append("join")
                })
                HomeButtonsView(icon: "clock.arrow.circlepath", text: "History", buttonAction: {
                    path.append("history")
                })
            }
            .navigationTitle(Text("Home"))
            .navigationDestination(for: String.self) { value in
                if value == "host" {
                    NewHostView(path: $path)
                }
                if value == "join" {
                    JoinLobbyView()
                }
                if value == "history" {
                    HistoryView()
                }
                if value == "edit" {
                    EditNewStoryView()
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
