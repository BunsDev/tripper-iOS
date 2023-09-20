//
//  InfoForGpt.swift
//  tripper-ios
//
//  Created by Ang Chun Yang on 19/9/23.
//

import Foundation

// in the future, allow user to set more preferences
struct InfoForGpt {
    var interested: [String] = []
    var notInterested: [String] = []
    var wentAndLike: [String] = []
    var wentAndDislike: [String] = []
    
    static var systemPrompt: String = "You are a system helping me to generate suggestions on where to travel to for my travel based app based on the response from the user. This app provides some cities to the users, and allow them to decide whether they are interested/ not intersted/ went and like/ went and dislike those cities. Below are the choices given by the user. Based on data provided by the user, please give them some suggestions on where to travel to. \n " +
        "It should be based on a country/ cities that they have not been to before. Please also make sure that the recommendations are based on the interests from the user. For instance, lets say he chose that he is has not went but is interested in cities like Tashkent, Bishkek, it might tell us that he loves more off the beaten path countries. Or if he is interested in cities like Zermatt, Tromso, maybe he likes nature. \n " +
        "You are not suppose to simply provide suggestions on where to go to based on where he indicated that he is interested in going to. You should use those inputs on the user to get the sense of what kind of countries/destinations interest him/her, and provide more suggestions on where to travel to to the user. I want results to be random in the sense that your answer should contain at least 1 place (but not all) where the user says he is interested in going to. The rest should be similar places based on what you can guess what kind of places he would enjoy more. \n " +
        "Please provide the user 5 suggestions on where to go to and it should be of the following format: \n: " +
        "(Country - don't put in the word country, just put the name of the country and an emoji after it. Make sure you bold the country name only, and dont bold the '1.' number before it): \n " +
        "Cities that you should visit: \n" +
        "Food to eat: (You should provide description) \nThings and activities to do: \nLandmarks not to miss: \n " +
        "Please format your response nicely (like numbering, bolding), and add emojis for country flag, please make sure emoji is correctly put in. \n " +
        "Lastly, in your response, don't add stuff before or after the suggestions like 'sure based on your input blah blah blah', so the user does not feel like he was talking to an AI. \n" +
        "Below is the user input: \n "
    
    init(interested: [String], notInterested: [String], wentAndLike: [String], wentAndDislike: [String]) {
        self.interested = interested
        self.notInterested = notInterested
        self.wentAndLike = wentAndLike
        self.wentAndDislike = wentAndDislike
    }
    
    mutating func appendInterested(_ city: City) {
        interested.append("\(city.cityName) (\(city.country))")
    }
    
    mutating func appendNotInterested(_ city: City) {
        notInterested.append("\(city.cityName) (\(city.country))")
    }
    
    mutating func appendWentAndLike(_ city: City) {
        wentAndLike.append("\(city.cityName) (\(city.country))")
    }
    
    mutating func appendWentAndDislike(_ city: City) {
        wentAndDislike.append("\(city.cityName) (\(city.country))")
    }
    
    func concatenateStrings(_ strings: [String]) -> String {
        if strings.count == 0 {
            return "None"
        }
        
        // Use the joined(separator:) method to concatenate the strings
        let concatenatedString = strings.joined(separator: ", ")
        
        return concatenatedString
    }

    func getStringForGptResponse() -> String {
//        var response = "Hi, these are the choices from the user using my app: \n"
        var response = ""
        response += "HAVE NOT WENT and interested in going: " + concatenateStrings(interested) + "\n "
        response += "HAVE NOT WENT and NOT interested in going: " + concatenateStrings(notInterested) + "\n "
        response += "WENT and LIKED the city: " + concatenateStrings(wentAndLike) + "\n "
        response += "WENT and DISLIKED the city: " + concatenateStrings(wentAndDislike) + "\n "
        response += "Please provide him a itinerary"
        return response
    }
}

enum GetGptResponseError: Error {
    case invalidDataError
    case timeoutError
}
