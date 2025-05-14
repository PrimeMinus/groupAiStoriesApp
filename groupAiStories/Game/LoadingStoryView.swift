//
//  LoadingStoryView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/12/25.
//

import SwiftUI
import Combine

struct LoadingStoryView: View {
    
    @State private var timerSubscription: AnyCancellable?
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(2)
            Text("Generating Story...")
                .padding(.top)
                .font(.title2)
                .bold()
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
    }
}

#Preview {
    LoadingStoryView()
}
