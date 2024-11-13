//
//  LessonAndTestViewModel.swift
//  MyWorldInEnglish
//
//  Created by Yunus emre cihan on 28.10.2024.
//

import Foundation

class LessonAndTestViewModel {
    var lessons: [LessonModel] = []
    var tests: [TestModel] = []
    var allWords: [WordEntity] = []

    func loadLessonsAndTests (forLevel level: String) {
        let words = DataManager.shared.fetchWords(forLevel: level)
        allWords = DataManager.shared.fetchAllWords()
        let groupedWords = DataManager.shared.groupWordsIntoLessons(words: words, wordsPerLesson: 35)
        
        lessons = []
        tests = []
        
        for (index,wordGroup) in groupedWords.enumerated() {
            let lessonTitle = "Lesson \(index + 1)"
            let testTitle = "Test \(index + 1)"
            
            let lesson = LessonModel(title: lessonTitle, words: wordGroup)
            let test = TestModel(title: testTitle, words: wordGroup)
            
            lessons.append(lesson)
            tests.append(test)
        }
    }

}
