//
//  OpenAiService.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//

import Alamofire
import Combine
import Foundation

class OpenAiService {
    let baseUrl = "https://api.openai.com/v1/chat/completions"

    var apiKey: String {
        // 1
        guard let filePath = Bundle.main.path(forResource: "secrets", ofType: "plist") else {
            fatalError("Couldn't find file 'TMDB-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "OPENAI_API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'TMDB-Info.plist'.")
        }
        return value
    }

    func streamMessage(message: String) -> DataStreamRequest {
        var messages: [OpenAiChatMessage] = []
        messages.append(OpenAiChatMessage(role: "system", content: "You are a system"))
        messages.append(OpenAiChatMessage(role: "user", content: InfoForGpt.systemPrompt + " " + message))
        let body = OpenAiCompletionBody(model: "gpt-4", temperature: 0.7, messages: messages, stream: true)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        return AF.streamRequest(baseUrl, method: .post, parameters: body, encoder: .json, headers: headers, requestModifier: { $0.timeoutInterval = .infinity })
    }

    func sendMessage(message: String) -> AnyPublisher<OpenAiCompletetionResponse, Error> {
        var messages: [OpenAiChatMessage] = []
        messages.append(OpenAiChatMessage(role: "system", content: "You are a system"))
        messages.append(OpenAiChatMessage(role: "user", content: InfoForGpt.systemPrompt + " " + message))
        let body = OpenAiCompletionBody(model: "gpt-4", temperature: 0.7, messages: messages, stream: false)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        return Future { [weak self] promise in
            guard let self = self else {
                return
            }
            AF.request(self.baseUrl, method: .post, parameters: body, encoder: .json, headers: headers, requestModifier: { $0.timeoutInterval = .infinity }).responseDecodable(of: OpenAiCompletetionResponse.self) { response in
                switch response.result {
                case .success(let result):
                    promise(.success(result))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    // Not working
    func sendMessageII(message: String) async throws -> String {
        var messages: [OpenAiChatMessage] = []
        messages.append(OpenAiChatMessage(role: "system", content: "You are a system"))
        messages.append(OpenAiChatMessage(role: "user", content: InfoForGpt.systemPrompt + " " + message))
        let body = OpenAiCompletionBody(model: "gpt-4", temperature: 0.7, messages: messages, stream: false)
        let url = URL(string: baseUrl)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Authorization", forHTTPHeaderField: "Bearer \(apiKey)")
        request.httpMethod = "POST"

        guard let encoded = try? JSONEncoder().encode(body) else {
            print("Faled to encode data")
            throw GetGptResponseError.invalidDataError
        }

        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            print("finish req")
            // handle the result
            let decodedData = try JSONDecoder().decode(OpenAiCompletetionResponse.self, from: data)
            guard decodedData.choices.first?.message != nil else {
                throw GetGptResponseError.invalidDataError
            }
            guard let res = decodedData.choices.first?.message.content else {
                throw GetGptResponseError.invalidDataError
            }
            return res
        } catch {
            throw error
        }
    }
}

struct OpenAiStreamResponse: Decodable {
    let choices: [OpenAiStreamChoice]
}

struct OpenAiStreamChoice: Decodable {
    let delta: OpenAiStreamDelta
}

struct OpenAiStreamDelta: Decodable {
    let content: String
}

struct OpenAiCompletionBody: Encodable {
    let model: String
    let temperature: Double
    var messages: [OpenAiChatMessage]
    let stream: Bool
}

struct OpenAiChatMessage: Codable {
    let role: String
    let content: String
}

struct OpenAiCompletetionResponse: Decodable {
//    let id: String
    let choices: [OpenAiCompletionChoice]
}

struct OpenAiCompletionChoice: Decodable {
    let message: OpenAiChatMessage
}
