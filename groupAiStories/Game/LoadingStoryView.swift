//
//  LoadingStoryView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/12/25.
//

import SwiftUI

struct LoadingStoryView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2)
        Text("Generating Story...")
            .padding(.top)
            .font(.title2)
            .bold()
    }
}

#Preview {
    LoadingStoryView()
}
