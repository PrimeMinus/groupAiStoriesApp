//
//  APIFunctions.swift
//  groupAiStories
//
//  Created by Brian Warner on 5/11/25.
//

import Foundation

//MARK: - /EDITPLAYER
struct editPlayerBody: Codable {
    var storyId: String
    var player: Player
}
func editPlayer(storyId: String, player: Player) {
    let editPlayerBody: editPlayerBody = editPlayerBody(
        storyId: storyId,
        player: player
    )
    postJSON(to: "https://4vvhnxuymf.execute-api.us-east-2.amazonaws.com/editplayer", object: editPlayerBody) { (result: Result<Story, Error>) in
        switch result {
        case .success(let story):
            print("player good")
        case .failure(let story):
            print("player bad")
        }
    }
}


//MARK: - /EDITSTORY
struct editStoryBody: Codable {
    var id: String
    var title: String
    var setting: String
    var theme: String
    var instructions: String
    var winners: Int
}
func editStory(story: Story) {
    let editStoryBody: editStoryBody = editStoryBody(
        id: story.id,
        title: story.title,
        setting: story.setting,
        theme: story.theme,
        instructions: story.instructions,
        winners: story.winners
    )
    postJSON(to: "https://4vvhnxuymf.execute-api.us-east-2.amazonaws.com/editstory", object: editStoryBody) { (result: Result<Story, Error>) in
        switch result {
        case .success(let story):
            print("Story fetched: \(story.title)")
        case .failure(let error):
            print("Failed to fetch story: \(error.localizedDescription)")
        }
    }
}


//MARK: - /CREATESTORY
struct createStoryBody: Codable {
    var id: String
}
func generateStory(id: String) {
    postJSON(to: "https://4vvhnxuymf.execute-api.us-east-2.amazonaws.com/createstory", object: createStoryBody(id: id)) { (result: Result<Story, Error>) in
        switch result {
        case .success(let story):
            print("Story fetched: \(story.title)")
        case .failure(let error):
            print("Failed to fetch story: \(error.localizedDescription)")
        }
    }
}

//MARK: - /READSTORY
struct readStoryBody: Codable {
    var id: String
}
func fetchStory(id: String, completion: @escaping (Story?) -> Void) {
    postJSON(to: "https://4vvhnxuymf.execute-api.us-east-2.amazonaws.com/readstory", object: readStoryBody(id: id)) { (result: Result<Story, Error>) in
        switch result {
        case .success(let story):
            print("Story fetched: \(story.title)")
            completion(story)
        case .failure(let error):
            print("Failed to fetch story: \(error.localizedDescription)")
            completion(nil)
        }
    }
}


//MARK: - /NEWSTORY
func uploadNewStory(story: Story) {
    postJSON(to: "https://4vvhnxuymf.execute-api.us-east-2.amazonaws.com/newstory", object: story, completion: { (result: Result<Story, Error>) in
        
    })
}

//MARK: - GENERIC HTTP POST REQUEST FUNCTION
func postJSON<RequestBody: Codable, ResponseBody: Codable>(
    to urlString: String,
    object: RequestBody,
    completion: @escaping (Result<ResponseBody, Error>) -> Void
) {
    guard let url = URL(string: urlString) else {
        print("Invalid URL.")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    request.setValue("Bearer 1953", forHTTPHeaderField: "authorization")

    do {
        let jsonData = try JSONEncoder().encode(object)
        request.httpBody = jsonData
    } catch {
        completion(.failure(error))
        return
    }

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "NoData", code: -1, userInfo: nil)))
            return
        }

        do {
            let decoded = try JSONDecoder().decode(ResponseBody.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
