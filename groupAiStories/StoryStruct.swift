//
//  StoryStruct.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import Foundation

struct Story: Codable {
    var id: String
    var title: String
    var setting: String
    var theme: String
    var instructions: String
    var winners: Int
    var winningPlayers: [String]
    var players: [Player]
    var content: [String]
}

struct Player: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var characteristics: String
}
