//
//  GetSuggestionsViewModel.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import Combine
import Foundation

final class GetSuggestionsViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var cardData: [CardData] = getTenRandomCards()
    @Published var infoForGpt: InfoForGpt = .init(interested: [], notInterested: [], wentAndLike: [], wentAndDislike: [])
    @Published var loading = false
    @Published var cancellables = Set<AnyCancellable>()
    @Published var responseFromOpenAi = ""

    let openAiService = OpenAiService()
    let firebaseService = FirebaseService()

    init() {}

    private func removeCurrentCard(newOffset: CGSize) {
        guard currentIndex < cardData.count else {
            return
        }
        var updatedCard = cardData[currentIndex]
        updatedCard.offset = newOffset
        cardData[currentIndex] = updatedCard
        currentIndex += 1
        if currentIndex == cardData.count {
//            getResponse()
            getStreamResponse()
        }
    }

    // when the user clicks to find new suggestions
    func reset() {
        responseFromOpenAi = ""
        currentIndex = 0
        resetInfoForGpt()
        cardData = getTenRandomCards()
    }

    private func getResponse() {
        loading = true
        openAiService.sendMessage(message: infoForGpt.getStringForGptResponse()).sink { _ in
            self.loading = false
        } receiveValue: { response in
            guard let res = response.choices.first?.message else {
                return
            }
            let content = res.content
            self.responseFromOpenAi = content
            self.loading = false
            guard self.responseFromOpenAi != "" else {
                return
            }
            self.firebaseService.addSuggestionToHistory(self.responseFromOpenAi)
        }.store(in: &cancellables)
    }

    private func getStreamResponse() {
        loading = true
        openAiService.streamMessage(message: infoForGpt.getStringForGptResponse()).responseStreamString { [weak self] stream in
            guard let self = self else { return }
            switch stream.event {
            case .stream(let response):
                switch response {
                case .success(let string):
                    let streamResponse = self.parseStreamData(string)
                    streamResponse.forEach { newMessageResponse in
                        guard let messageContent = newMessageResponse.choices.first?.delta.content else {
                            return
                        }
                        self.responseFromOpenAi += messageContent
                    }
                case .failure:
                    self.loading = false
                    print("Something else")
                }
            case .complete:
                self.loading = false
                self.firebaseService.addSuggestionToHistory(self.responseFromOpenAi)
            }
        }
    }

    func parseStreamData(_ data: String) -> [OpenAiStreamResponse] {
        let responseString = data.split(separator: "data:").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }.filter { !$0.isEmpty }
        let jsonDecoder = JSONDecoder()

        return responseString.compactMap { jsonString in
            guard let jsonData = jsonString.data(using: .utf8), let streamResponse = try? jsonDecoder.decode(OpenAiStreamResponse.self, from: jsonData) else {
                return nil
            }
            return streamResponse
        }
    }

    func resetInfoForGpt() {
        infoForGpt = InfoForGpt(interested: [], notInterested: [], wentAndLike: [], wentAndDislike: [])
    }

    func appendInterested() {
        guard currentIndex < cardData.count else {
            return
        }
        let city = cardData[currentIndex].city
        infoForGpt.appendInterested(city)
        removeCurrentCard(newOffset: CGSize(width: 0, height: 500))
    }

    func appendNotInterested() {
        guard currentIndex < cardData.count else {
            return
        }
        let city = cardData[currentIndex].city
        infoForGpt.appendNotInterested(city)
        removeCurrentCard(newOffset: CGSize(width: 0, height: -500))
    }

    func appendWentAndLike() {
        guard currentIndex < cardData.count else {
            return
        }
        let city = cardData[currentIndex].city
        infoForGpt.appendWentAndLike(city)
        removeCurrentCard(newOffset: CGSize(width: 500, height: 0))
    }

    func appendWentAndDislike() {
        guard currentIndex < cardData.count else {
            return
        }
        let city = cardData[currentIndex].city
        infoForGpt.appendWentAndDislike(city)
        removeCurrentCard(newOffset: CGSize(width: -500, height: 0))
    }
}
