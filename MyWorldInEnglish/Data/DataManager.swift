
import Foundation
import CoreData
import UIKit

class DataManager {
    static let shared = DataManager()

    func loadCSVData() -> [[String]]? {
        guard let path = Bundle.main.path(forResource: "EnglishWordupdate", ofType: "csv") else { return nil }
        do {
            let content = try String(contentsOfFile: path)
            let rows = content.components(separatedBy: "\n")
            var csvData: [[String]] = []
            
            for row in rows {
                let columns = row.components(separatedBy: ",")
                csvData.append(columns)
            }
            return csvData
        } catch {
            print("CSV dosyası okunamadı: \(error)")
            return nil
        }
    }
    
    func saveWordsToCoreData(data: [[String]]) {
        
        // Verinin daha önce kaydedilip kaydedilmediğini kontrol et
        let isDataLoaded = UserDefaults.standard.bool(forKey: "isDataLoaded")
        if isDataLoaded {
            print("Veriler zaten yüklenmiş, yeniden yüklenmeyecek.")
            return
        }
        // AppDelegate üzerinden Core Data context'ini alıyoruz
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        for row in data.dropFirst() { // İlk satır başlıklar, bu yüzden atlıyoruz
            let wordEntity = WordEntity(context: context)
            wordEntity.setValue(row[0], forKey: "englishWord")
            wordEntity.setValue(row[1], forKey: "wordType")
            wordEntity.setValue(row[2], forKey: "level")
            wordEntity.setValue(row[3], forKey: "turkishTranslation")
            wordEntity.setValue(row[4], forKey: "exampleSentenceEn")
            wordEntity.setValue(row[5], forKey: "exampleSentenceTR")
            wordEntity.isHidden = false
        }

        do {
            try context.save()
            print("Veriler Core Data'ya başarıyla kaydedildi.")
            // Verinin yüklendiğini kaydet
            UserDefaults.standard.set(true, forKey: "isDataLoaded")
        } catch {
            print("Veriler Core Data'ya kaydedilemedi: \(error)")
        }
    }
    
    func fetchAllWordsFromCoreData() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let context = appDelegate.persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<WordEntity>(entityName: "WordEntity")
           
           do {
               let words = try context.fetch(fetchRequest)
               print("Toplam kayıt sayısı: \(words.count)")
               for word in words {
                   // Kelime bilgilerini al
                    guard let englishWord = word.value(forKey: "englishWord") as? String else { continue }
                    guard let wordType = word.value(forKey: "wordType") as? String else { continue }
                    guard let level = word.value(forKey: "level") as? String else { continue }
                   guard let englishWordTR = word.value(forKey: "turkishTranslation") as? String else {continue}
                    guard let exampleSentenceEn = word.value(forKey: "exampleSentenceEn") as? String else { continue }
                    guard let exampleSentenceTR = word.value(forKey: "exampleSentenceTR") as? String else { continue }
                    print("Word: \(englishWord), Type: \(wordType), Level: \(level), Example (EN): \(exampleSentenceEn), Example (TR): \(exampleSentenceTR)")
               }
           } catch {
               print("Veriler çekilemedi: \(error)")
           }
       }
    
    //KELİMELERİ SEVİYELERİNE GÖRE AYIRIP DERSLERE ATAMA YAPILACAK !!! -->>>>>
    // Kelimeleri belirli bir seviyeye göre çekme
    func fetchWords(forLevel level: String) -> [WordEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<WordEntity>(entityName: "WordEntity")
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "level == %@", level),
            NSPredicate(format: "isHidden == NO")
        ])

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Veriler çekilemedi: \(error)")
            return []
        }
    }
    
    func groupWordsIntoLessons(words: [WordEntity], wordsPerLesson: Int) -> [[WordEntity]] {
        var lessons: [[WordEntity]] = []
        let totalWords = words.count
        let numberOfLessons = (totalWords + wordsPerLesson - 1) / wordsPerLesson // Tamsayı bölme

        for i in 0..<numberOfLessons {
            let startIndex = i * wordsPerLesson
            let endIndex = min(startIndex + wordsPerLesson, totalWords)
            let lesson = Array(words[startIndex..<endIndex])
            lessons.append(lesson)
        }
        return lessons
    }
    
    func fetchAndGroupWords(forLevel level: String, wordsPerLesson: Int) -> [[WordEntity]] {
          let words = fetchVisibleWords(forLevel: level)
        return groupWordsIntoLessons(words: words, wordsPerLesson: wordsPerLesson)
      }
    func fetchAllWords() -> [WordEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<WordEntity>(entityName: "WordEntity")
        
        fetchRequest.predicate = NSPredicate(format: "isHidden == NO")
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Tüm kelimeler çekilemedi: \(error)")
            return []
        }
    }
    
 
}
extension DataManager {
    func hideWord(_ englishWord: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        // İlgili kelimeyi bulmak için fetch request kullanıyoruz
        let fetchRequest = NSFetchRequest<WordEntity>(entityName: "WordEntity")
        fetchRequest.predicate = NSPredicate(format: "englishWord == %@", englishWord)
        
        do {
            let words = try context.fetch(fetchRequest)
            if let word = words.first {
                word.isHidden = true // Kelimeyi gizle
                try context.save()
                print("Kelime gizlendi: \(englishWord)")
            } else {
                print("Kelime bulunamadı: \(englishWord)")
            }
        } catch {
            print("Kelime gizleme işlemi başarısız: \(error)")
        }
    }
    func fetchVisibleWords(forLevel level: String) -> [WordEntity] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<WordEntity>(entityName: "WordEntity")
        
        // Sadece gizlenmemiş kelimeleri çekmek için predicate ekliyoruz
        fetchRequest.predicate = NSPredicate(format: "level == %@ AND isHidden == %@", level, NSNumber(value: false))

        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Görünür kelimeler çekilemedi: \(error)")
            return []
        }
    }

}



