//
//  City.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//

import Foundation

struct City: Codable, Identifiable {
    let id: UUID
    let cityName: String
    let country: String
    let imageUrl: String

    init(cityName: String, country: String, imageUrl: String) {
        self.id = UUID()
        self.cityName = cityName
        self.country = country
        self.imageUrl = imageUrl
    }
}

struct CardData: Codable, Identifiable {
    let id: UUID
    let city: City
    var offset: CGSize

    init(city: City) {
        self.id = UUID()
        self.city = city
        self.offset = CGSize.zero
    }
}

var CITIES_DATA: [City] = [
    City(cityName: "Prague", country: "Czech Republic", imageUrl: "prague"),
    City(cityName: "Pokhara", country: "Nepal", imageUrl: "pokhara"),
    City(cityName: "Edinburgh", country: "Scotland", imageUrl: "edinburgh"),
    City(cityName: "Paris", country: "France", imageUrl: "paris"),
    City(cityName: "Cape Town", country: "South Africa", imageUrl: "cape-town"),
    City(cityName: "Rio De Janeiro", country: "Brazil", imageUrl: "rio-de-janeiro"),
    City(cityName: "Singapore", country: "Singapore", imageUrl: "singapore"),
    City(cityName: "Tokyo", country: "Japan", imageUrl: "tokyo"),
    City(cityName: "Seoul", country: "South Korea", imageUrl: "seoul"),
    City(cityName: "Mostar", country: "Bosnia", imageUrl: "mostar"),
    City(cityName: "Berat", country: "Albania", imageUrl: "berat"),
    City(cityName: "Cusco", country: "Peru", imageUrl: "cusco"),
    City(cityName: "Almaty", country: "Kazakhstan", imageUrl: "almaty"),
    City(cityName: "Colombo", country: "Sri Lanka", imageUrl: "colombo"),
    City(cityName: "New Delhi", country: "India", imageUrl: "new-delhi"),
    City(cityName: "Lahore", country: "Pakistan", imageUrl: "lahore"),
    City(cityName: "Petra", country: "Jordan", imageUrl: "petra"),
    City(cityName: "Socotra", country: "Yemen", imageUrl: "socotra"),
    City(cityName: "Kyoto", country: "Japan", imageUrl: "kyoto"),
    City(cityName: "Torres Del Paine", country: "Chile", imageUrl: "torres-del-paine"),
    City(cityName: "Buenos Aires", country: "Argenina", imageUrl: "buenos-aires"),
    City(cityName: "Uyuni", country: "Bolivia", imageUrl: "uyuni"),
    City(cityName: "Luanda", country: "Angola", imageUrl: "luanda"),
    City(cityName: "Swakopmund", country: "Namibia", imageUrl: "swakopmund"),
    City(cityName: "Chefchaouen", country: "Morocco", imageUrl: "chefchaouen"),
    City(cityName: "Kyiv", country: "Ukraine", imageUrl: "kyiv"),
    City(cityName: "Mazar I Sharif", country: "Afghanistan", imageUrl: "mazar-i-sharif"),
    City(cityName: "Budapest", country: "Hungary", imageUrl: "budapest"),
    City(cityName: "Tunis", country: "Tunasia", imageUrl: "tunis")
]

func getTenRandomCities() -> [City] {
    var shuffledCities = CITIES_DATA.shuffled()
    var randomCities: [City] = []

    for _ in 0 ..< min(10, shuffledCities.count) {
        if let city = shuffledCities.popLast() {
            randomCities.append(city)
        }
    }

    return randomCities
}

func getTenRandomCards() -> [CardData] {
    return mapCitiesToCards(getTenRandomCities())
}

func mapCitiesToCards(_ cities: [City]) -> [CardData] {
    return cities.map { city in
        CardData(city: city)
    }
}

var CARDS_DATA: [CardData] = mapCitiesToCards(CITIES_DATA)
