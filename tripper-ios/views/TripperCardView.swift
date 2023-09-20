//
//  TripperCardView.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//

import SwiftUI

struct TripperCardView: View {
    @State var cardData: CardData
    // should this be binding so we can allow gesture?
    @State private var offset = CGSize.zero
    @State private var opacity = 1.0

    var body: some View {
        Image(cardData.city.imageUrl).resizable()
            .cornerRadius(30)
            .frame(width: nil, height: 500)
            .overlay(alignment: .bottomLeading) {
                ImageOverlay(cityName: cardData.city.cityName, countryName: cardData.city.country)
            }
            .opacity(opacity)
            .offset(x: cardData.offset.width, y: cardData.offset.height)
            .animation(.spring(), value: cardData.offset.width != 0.0 || cardData.offset.height != 0.0)
//            .animation(.easeInOut)
            .rotationEffect(.degrees(Double(cardData.offset.width / 40)))
            .padding(.horizontal, 10)
//            .gesture(
//                DragGesture()
//                    .onChanged { gesture in
//                        offset = gesture.translation
//                        changeColor(width: cardData.offset.width)
//                    }.onEnded { _ in
//                        withAnimation {
//                            swipeCard(width: cardData.offset.width)
//                        }
//                    }
//            )
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500 ... -150:
            offset = CGSize(width: -500, height: 0)
        case 150 ... 500:
            print("added")
            offset = CGSize(width: 500, height: 0)
        default:
            offset = .zero
        }
    }

    // change overlay text for us
    func changeColor(width: CGFloat) {
        switch width {
        case -500 ... -130:
            opacity = 0.5
        case 130 ... 500:
            opacity = 0.5
        default:
            opacity = 1.0
        }
    }
}

struct ImageOverlay: View {
    let cityName: String
    let countryName: String
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(cityName)
                    .padding(10)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 1)

                Text(countryName)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.black)
                    .background(Capsule().fill(Color.white))
            }
            Spacer()
        }.padding(.bottom, 50)
    }
}

struct TripperCardView_Previews: PreviewProvider {
    static var previews: some View {
        TripperCardView(cardData: CARDS_DATA[0])
    }
}
