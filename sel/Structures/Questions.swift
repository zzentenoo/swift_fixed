//
//  Questions.swift
//  sel
//
//  Created by Fernando García on 03/10/23.
//

import Foundation

struct Question:Codable{
    let id: String
    let text: String
    let typeQuestion: String
    let display: String
    let hidden: Int
}
typealias Questions = [Question]

enum QuestionError: Error, LocalizedError{
    case itemNotFound
}

extension Question{
        
    static func fetchQuestions() async throws->Questions{
        let baseString = "https://sel4c-e2-server-49c8146f2364.herokuapp.com/questions"
        let questionsURL = URL(string: baseString)!
        let (data, response) = try await URLSession.shared.data(from: questionsURL)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw QuestionError.itemNotFound
        }
        let jsonDecoder = JSONDecoder()
        let questions = try? jsonDecoder.decode(Questions.self, from: data)
        return questions!
        
    }
}
