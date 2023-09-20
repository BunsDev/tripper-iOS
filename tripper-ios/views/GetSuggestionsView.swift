//
//  GetSuggestionsView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 20/9/23.
//

import Combine
import SwiftUI

struct GetSuggestionsView: View {
    @StateObject var viewModel = GetSuggestionsViewModel()

    let openAiService = OpenAiService()

    var body: some View {
        if viewModel.currentIndex != viewModel.cardData.count {
            VStack {
                ZStack {
                    ForEach(viewModel.cardData[viewModel.currentIndex...].reversed()) { cardData in
                        TripperCardView(cardData: cardData)
                    }
                }
                HStack {
                    // they have the current index
                    VStack {
                        TripperButton(backgroundColor: .mint, title: "Went & like") {
                            viewModel.appendWentAndLike()
                        }
                        TripperButton(backgroundColor: .orange, title: "Went & didn't like") {
                            viewModel.appendWentAndDislike()
                        }
                    }
                    VStack {
                        TripperButton(backgroundColor: .blue, title: "Interested") {
                            viewModel.appendInterested()
                        }
                        TripperButton(backgroundColor: .red, title: "Not Interested") {
                            viewModel.appendNotInterested()
                        }
                    }
                }
                .padding(.top, 20)
            }
        } else {
            //        https://stackoverflow.com/questions/58122998/swiftui-vertical-centering-content-inside-scrollview
            GeometryReader { _ in
                ScrollView(.vertical) {
                    VStack(alignment: .leading) {
                        Text("Here are some suggestions for your next trip!").font(.title).fontWeight(.bold).padding()
                        if viewModel.loading == false && viewModel.responseFromOpenAi == "" {
                            Text("Oops. There seems to be an error, please try again!")
                        } else {
                            Text(.init(viewModel.responseFromOpenAi)).padding()
                        }
                        if viewModel.loading == false {
                            HStack {
                                Spacer()
                                Button {
                                    viewModel.reset()
                                } label: {
                                    Text("Get More Suggestions").bold()
                                        .frame(width: 250, height: 40, alignment: .center)
                                    
                                }.background(.pink)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                                Spacer()
                            }
                        }
                        Color.white.frame(width: nil, height: 50)
                    }
                }
            }.safeAreaInset(edge: .top) {
                Text("")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.white)
            }
        }
    }

//    func getResponse() {
//        viewModel.loading = true
//        openAiService.sendMessage(message: viewModel.infoForGpt.getStringForGptResponse()).sink { _ in
//            viewModel.loading = false
//        } receiveValue: { response in
//            guard let res = response.choices.first?.message else {
//                return
//            }
//            responseFromOpenAi = res.content
//            viewModel.loading = false
//        }.store(in: &cancellables)
//    }

//    func getResponseII() async throws {
//        do {
//            responseFromOpenAi = try await openAiService.sendMessageII(message: viewModel.infoForGpt.getStringForGptResponse())
//        } catch {
//            if let apiError = error as? GetGptResponseError {
//                switch apiError {
//                case .timeoutError:
//                    print("timeoutError")
//                case .invalidDataError:
//                    print("invalidDataError")
//                }
//            } else {
//                print("An unexpected error occurred: \(error)")
//            }
//        }
//    }
}

struct GetSuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        GetSuggestionsView()
    }
}
