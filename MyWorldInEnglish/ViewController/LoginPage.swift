//
//  ViewController.swift
//  MyWorldInEnglish
//
//  Created by Yunus emre cihan on 26.10.2024.
//

import UIKit

class LoginPage: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Arka plan resmini ayarlama
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "ee.jpg")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
             
        // Arka planı en arkaya ekleme
        self.view.insertSubview(backgroundImage, at: 0)
             
        // Auto Layout Constraints ayarlama
        NSLayoutConstraint.activate([
            backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        setupButton()
    }
    
    func setupButton(){
        nextButton.layer.cornerRadius = 20
        nextButton.clipsToBounds = true
    }


    @IBAction func nextButton(_ sender: Any) {
        print("Tıklandı")
        performSegue(withIdentifier: "toFirstPage", sender: nil)
    }
    
}

