//
//  Game.swift
//  Apple Pie
//
//  Created by влад on 13.04.2022.
//

import Foundation
struct Game {
    var capital: String
    var incorrectMovesRemaining:Int
    fileprivate var guessedLetter = [Character]()
    
    init(capital: String,incorrectMovesRemaining: Int ){
    self.capital = capital
    self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String { // угадываемое слово
        var wordToShow = ""
        for letter in capital {
            if guessedLetter.contains(Character(letter.lowercased())) || letter == "-" || letter == " " {
                wordToShow += String (letter)
            } else {
                wordToShow += "_"
            }
        }
        
        return wordToShow
    }
    
    
    
    
   mutating func playerGuessed (letter:Character){
       let lowercasedLetter = Character(letter.lowercased())
       guessedLetter.append(lowercasedLetter)
       if !capital.lowercased().contains(lowercasedLetter) {
           incorrectMovesRemaining -= 1
       }
        
    }
}
