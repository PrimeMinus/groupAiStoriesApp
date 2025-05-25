//
//  StoryInspectView.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/25/25.
//

import SwiftUI

struct StoryInspectView: View {
    
    @EnvironmentObject var appData: AppData
    
    var body: some View {
        NavigationStack {
            Form {
                Text(stringify(appData.currentStory))
                Button("Generate Story", role: .destructive, action: {
                    generateStory(id: appData.currentStory.id)
                })
            }
        }
    }
}

func stringify<T: Encodable>(_ object: T) -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted  // Makes it readable
    do {
        let data = try encoder.encode(object)
        return String(data: data, encoding: .utf8) ?? "Encoding failed"
    } catch {
        return "Error: \(error.localizedDescription)"
    }
}
