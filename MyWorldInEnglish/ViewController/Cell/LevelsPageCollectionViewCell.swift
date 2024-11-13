//
//  LevelsPageCollectionViewCell.swift
//  MyWorldInEnglish
//
//  Created by Yunus emre cihan on 9.11.2024.
//

import UIKit

class LevelsPageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var View: UIView!
    
    @IBOutlet weak var levelNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellStyle()
     
    }
        
    func configureCell(level: String, isUnlocked: Bool,name: String) {
        levelNameLabel.text = name
        levelLabel.text = level
        View.alpha = isUnlocked ? 1.0 : 0.5
      
        levelLabel.textColor = isUnlocked ? .black : .lightGray
    }
    private func setupCellStyle() {
        View.layer.cornerRadius = 10
        View.layer.masksToBounds = true
        View.layer.borderWidth = 1
        View.layer.borderColor = UIColor.lightGray.cgColor
        View.backgroundColor = UIColor.systemGray6 // Daha belirgin bir arka plan rengi
    }
}

