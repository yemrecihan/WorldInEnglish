//
//  WordsPageViewModel.swift
//  MyWorldInEnglish
//
//  Created by Yunus emre cihan on 29.10.2024.
//

import Foundation
class WordsPageViewModel {
    
    private let words: [WordEntity] // WordEntity Core Data'dan gelen verileri temsil ediyor
        private var currentIndex = 0
        
        var currentWord: WordEntity {
            return words[currentIndex]
        }
        
        var wordText: String {
            return currentWord.englishWord ?? ""
        }
    var turkishTranslation: String {
        return currentWord.turkishTranslation ?? ""
    }
        
        var wordType: String {
            return currentWord.wordType ?? ""
        }
        
        var exampleSentenceEn: String {
            return currentWord.exampleSentenceEn ?? ""
        }
        
        var exampleSentenceTr: String {
            return currentWord.exampleSentenceTR ?? ""
        }
        
        init(words: [WordEntity]) {
            self.words = words
        }
        
        // Sonraki kelimeye geçiş
        func goToNextWord() {
            if currentIndex < words.count - 1 {
                currentIndex += 1
            }
        }
        
        // Önceki kelimeye geçiş
        func goToPreviousWord() {
            if currentIndex > 0 {
                currentIndex -= 1
            }
        }
}
