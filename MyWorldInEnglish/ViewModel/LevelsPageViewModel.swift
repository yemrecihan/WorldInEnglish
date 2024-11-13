import Foundation
import UIKit

class LevelsPageViewModel {
    
    var userName: String?
    private(set) var selectedLevel: String
    private var levels: [Level] // Level sınıfından bir dizi
    
    init() {
        self.userName = UserDefaults.standard.string(forKey: "userName")
        self.selectedLevel = UserDefaults.standard.string(forKey: "selectedLevel") ?? "A1"
        
        // Her seviye için Level modelini kullanarak seviyeleri tanımla
        self.levels = [
            Level(code: "A1", name: "Beginner"),
            Level(code: "A2", name: "Elementary"),
            Level(code: "B1", name: "Intermediate"),
            Level(code: "B2", name: "Upper-Intermediate"),
            Level(code: "C1", name: "Advanced"),
            Level(code: "C2", name: "Proficient")
        ]
        
        // Seçilen seviyeye kadar olan seviyeleri aç
        unlockLevelsUpToSelected()
    }
    
    private func unlockLevelsUpToSelected() {
        guard let selectedIndex = levels.firstIndex(where: { $0.code == selectedLevel }) else { return }
        for index in 0...selectedIndex {
            levels[index] = Level(code: levels[index].code, name: levels[index].name, isUnlocked: true)
        }
    }
    
    func message() -> String {
        if let userName = userName {
            return "     Hi \(userName), let's continue learning!"
        } else {
            return "Hi, learn to go"
        }
    }
    
    func isLevelUnlocked(level: Level) -> Bool {
        return level.isUnlocked
    }
    
    func getLevels() -> [Level] {
        return levels
    }
}




