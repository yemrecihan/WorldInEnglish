//
//  LevelModel.swift
//  MyWorldInEnglish
//
//  Created by Yunus emre cihan on 9.11.2024.
//

import Foundation
struct Level {
    let code: String       // Seviyenin kodu (örn: "A1")
    let name: String       // Seviyenin ismi (örn: "Beginner")
    let isUnlocked: Bool   // Kilitli olup olmadığını belirtir
    
    init(code: String, name: String, isUnlocked: Bool = false) {
        self.code = code
        self.name = name
        self.isUnlocked = isUnlocked
    }
}
