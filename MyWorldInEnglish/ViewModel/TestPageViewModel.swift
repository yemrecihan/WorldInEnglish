import Foundation

class TestPageViewModel {
    private let words: [WordEntity]
    private let allWords: [WordEntity]
    private var currentIndex = 0
    private var correctAnswersCount = 0
       
    var currentWord: WordEntity {
        return words[currentIndex]
    }

    var options: [String] {
        var options = [currentWord.turkishTranslation ?? ""]
        let wrongAnswers = allWords
            .filter { $0 != currentWord }
            .shuffled()
            .prefix(3)
            .compactMap { $0.turkishTranslation }
        options.append(contentsOf: wrongAnswers)
        return options.shuffled()
    }

    init(words: [WordEntity], allWords: [WordEntity]) {
        self.words = words
        self.allWords = allWords
    }
    
    func goToNextQuestion() -> Bool {
        if currentIndex < words.count - 1 {
            currentIndex += 1
            return true
        }
        return false
    }

    func goToPreviousQuestion() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }

    var questionText: String {
        return "What is the meaning of '\(currentWord.englishWord ?? "")'?"
    }

    var correctAnswer: String? {
        return currentWord.turkishTranslation
    }

    func isLastQuestion() -> Bool {
        return currentIndex == words.count - 1
    }

    func checkAnswer(_ selectedAnswer: String) -> Bool {
        let isCorrect = selectedAnswer == currentWord.turkishTranslation
        if isCorrect { correctAnswersCount += 1 }
        return isCorrect
    }

    func calculateScore() -> Int {
        return Int((Double(correctAnswersCount) / Double(words.count)) * 100)
    }
}

