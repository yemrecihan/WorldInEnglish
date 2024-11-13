//
//  WordsPageVC.swift
//  MyWorldInEnglish
//
//  Created by Yunus emre cihan on 29.10.2024.
//

import UIKit

class WordsPageVC: UIViewController {

    @IBOutlet weak var cartView: UIView!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var wordLabelTR: UILabel!
    @IBOutlet weak var wordTypeLabel: UILabel!
    
    @IBOutlet weak var sentencesEnLabel: UILabel!
    
    @IBOutlet weak var sentencesTrLabel: UILabel!
    
    @IBOutlet weak var translationButton: UIButton!
    
    var viewModel : WordsPageViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
  
      setupNavigation()
     
      styleCartView()
        updateWordDisplay()
      
    }
    // Kart görünümünün stilini ayarlayan fonksiyon
    func styleCartView() {
        cartView.layer.cornerRadius = 15 // Köşe yuvarlama
        cartView.layer.borderWidth = 2 // Çerçeve kalınlığı
        cartView.layer.borderColor = UIColor.darkGray.cgColor // Çerçeve rengi
        cartView.layer.shadowColor = UIColor.black.cgColor // Gölge rengi
        cartView.layer.shadowOpacity = 0.2 // Gölge opaklığı
        cartView.layer.shadowOffset = CGSize(width: 0, height: 4) // Gölge yönü
        cartView.layer.shadowRadius = 6 // Gölge bulanıklığı
    }
    private func setupNavigation() {
        let backButton = UIBarButtonItem(title: "<- Back", style: .plain, target: self, action: #selector(backButtonTapped))
        // Attributed string ile başlığı kalın yap
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17) // Kalın bir font belirle
        ]
        backButton.setTitleTextAttributes(attributes, for: .normal)
        backButton.tintColor = UIColor.systemGray
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "Flashcards " // Navigation bar başlığını ayarlama
        self.navigationController?.navigationBar.prefersLargeTitles = true // Büyük başlık kullanma
    }
    // Kelime bilgilerini UI üzerinde güncelleyen fonksiyon
    func updateWordDisplay() {
        wordLabel.text = viewModel.wordText
        wordLabelTR.text = viewModel.turkishTranslation
        wordTypeLabel.text = viewModel.wordType
        sentencesEnLabel.text = viewModel.exampleSentenceEn
        sentencesTrLabel.text = viewModel.exampleSentenceTr
        sentencesTrLabel.isHidden = true // Başlangıçta Türkçe çeviriyi gizliyoruz
    }
    
    
    @objc func backButtonTapped() {
        // Ekranı kapatmak için dismiss kullanıyoruz
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func translationButtonTap(_ sender: Any) {
        // Türkçe çeviriyi göster/gizle
        sentencesTrLabel.isHidden.toggle()
    }
    
    @IBAction func forwardButton(_ sender: Any) {
        // Bir sonraki kelimeye geçiş
        viewModel.goToNextWord()
        // Kart geçişi animasyonu
            UIView.transition(with: cartView, duration: 0.5, options: [.transitionFlipFromRight], animations: {
                // Yeni kelime bilgilerini yükle
                self.updateWordView()
            }, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        // Bir önceki kelimeye geçiş
        viewModel.goToPreviousWord()
        // Kart geçişi animasyonu
            UIView.transition(with: cartView, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
                // Yeni kelime bilgilerini yükle
                self.updateWordView()
            }, completion: nil)
       /* updateWordDisplay()*/
    }
    func updateWordView() {
        wordLabel.text = viewModel.wordText
        wordLabelTR.text = viewModel.turkishTranslation
        wordTypeLabel.text = viewModel.wordType
        sentencesEnLabel.text = viewModel.exampleSentenceEn
        sentencesTrLabel.text = viewModel.exampleSentenceTr
    }
    

}
