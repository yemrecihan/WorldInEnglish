

import UIKit

protocol TestPageVCDelegate: AnyObject {
    func didCompleteTest(withScore score: Int)
}

class TestPageVC: UIViewController {

    @IBOutlet weak var testCardView: UIView!
    
    @IBOutlet weak var wordLabel: UILabel!
    
    @IBOutlet weak var wordTypeLabel: UILabel!
    
    @IBOutlet weak var optionDButton: UIButton!
    @IBOutlet weak var optionCButton: UIButton!
    @IBOutlet weak var optionBButton: UIButton!
    @IBOutlet weak var optionAButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    var viewModel : TestPageViewModel!
    weak var delegate: TestPageVCDelegate?
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupNavigation()
        updateUI()
       styleCartView()
        setupButton()
    }
    // Kart görünümünün stilini ayarlayan fonksiyon
    func styleCartView() {
        testCardView.layer.cornerRadius = 15 // Köşe yuvarlama
        testCardView.layer.borderWidth = 2 // Çerçeve kalınlığı
        testCardView.layer.borderColor = UIColor.darkGray.cgColor // Çerçeve rengi
        testCardView.layer.shadowColor = UIColor.black.cgColor // Gölge rengi
        testCardView.layer.shadowOpacity = 0.2 // Gölge opaklığı
        testCardView.layer.shadowOffset = CGSize(width: 0, height: 4) // Gölge yönü
        testCardView.layer.shadowRadius = 6 // Gölge bulanıklığı
    }
    private func setupNavigation() {
        let backButton = UIBarButtonItem(title: "<- Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        // Attributed string ile başlığı kalın yap
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 17) // Kalın bir font belirle
        ]
        backButton.setTitleTextAttributes(attributes, for: .normal)
        backButton.tintColor = UIColor.systemGray
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "Test " // Navigation bar başlığını ayarlama
        self.navigationController?.navigationBar.prefersLargeTitles = true // Büyük başlık kullanma
    }
    func setupButton(){
        let buttons = [optionAButton, optionBButton, optionCButton, optionDButton]
        buttons.forEach { button in
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitleColor(.white, for: .normal)
            button?.layer.cornerRadius = 10 // Köşe yuvarlama
            button?.layer.borderWidth = 1   // Çerçeve kalınlığı
            button?.layer.borderColor = UIColor.darkGray.cgColor
            button?.clipsToBounds = true
        }
    }
    // UI'yi güncelleme
    private func updateUI() {
        
        wordLabel.text = viewModel.currentWord.englishWord
        wordTypeLabel.text = viewModel.currentWord.wordType
        let options = viewModel.options
        optionAButton.setTitle(options[0], for: .normal)
        optionBButton.setTitle(options[1], for: .normal)
        optionCButton.setTitle(options[2], for: .normal)
        optionDButton.setTitle(options[3], for: .normal)
        
        setupInitialButtonAppearance()
    }
    // Başlangıç buton görünümlerini ayarla
    private func setupInitialButtonAppearance() {
        [optionAButton, optionBButton, optionCButton, optionDButton].forEach { button in
            button?.backgroundColor = .systemBlue
            button?.setTitleColor(.white, for: .normal)
            button?.isEnabled = true
        }
        forwardButton.isEnabled = true
    }

    // Şıkların doğruluğunu kontrol et
    private func checkAnswer(selectedButton: UIButton) {
        let selectedAnswer = selectedButton.title(for: .normal) ?? ""
        let isCorrect = viewModel.checkAnswer(selectedAnswer)
        selectedButton.backgroundColor = isCorrect ? .systemGreen : .systemRed
        if !isCorrect {
            highlightCorrectAnswer(correctAnswer: viewModel.correctAnswer ?? "")
        }
        disableOptionButtons()
        
        if viewModel.isLastQuestion() {
            finishTest()
        }
       
    }
    private func highlightCorrectAnswer(correctAnswer: String) {
        [optionAButton, optionBButton, optionCButton, optionDButton].forEach { button in
            if button?.title(for: .normal) == correctAnswer {
                button?.backgroundColor = .systemGreen
            }
        }
    }

    // Tüm butonları başlangıç rengine döndürme ve aktif hale getirme
    private func resetButtonAppearance() {
        let buttons = [optionAButton, optionBButton, optionCButton, optionDButton]
        buttons.forEach { button in
            button?.backgroundColor = UIColor.systemBlue
            button?.setTitleColor(.white, for: .normal)
            button?.alpha = 1.0
            button?.isEnabled = true
        }
    }
    // Cevaplandıktan sonra butonları devre dışı bırakma
    private func disableOptionButtons() {
        [optionAButton, optionBButton, optionCButton, optionDButton].forEach { $0?.isEnabled = false }
    }
    private func finishTest() {
        let score = viewModel.calculateScore()
        let message = "Test bitti. Alınan puan: \(score)"
        
        let alert = UIAlertController(title: "Sonuç", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { [weak self] _ in
            self?.forwardButton.isEnabled = false
            self?.delegate?.didCompleteTest(withScore: score)
            self?.navigationController?.popViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }


    
    @objc func backButtonTapped() {
        // Ekranı kapatmak için dismiss kullanıyoruz
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func optionAButtonTap(_ sender: UIButton) {
        checkAnswer(selectedButton: sender)
    }
    
    @IBAction func optionBButtonTap(_ sender: UIButton) {
        checkAnswer(selectedButton: sender)
    }
    
    @IBAction func optionCButtonTap(_ sender: UIButton) {
        checkAnswer(selectedButton: sender)
    }
    
    @IBAction func optionDButtonTap(_ sender: UIButton) {
        checkAnswer(selectedButton: sender)
    }

    @IBAction func forwardButton(_ sender: Any) {
        viewModel.goToNextQuestion()
        resetButtonAppearance()
       
       
        UIView.transition(with: testCardView, duration: 0.5, options: [.transitionFlipFromRight], animations: {
               // Yeni kelime bilgilerini güncelle
               self.updateUI()
           }, completion: nil)
    }
    
 
    @IBAction func backButton(_ sender: Any) {
        viewModel.goToPreviousQuestion()
        resetButtonAppearance()
        updateUI()
        
        UIView.transition(with: testCardView, duration: 0.5, options: [.transitionFlipFromLeft], animations: {
               // Yeni kelime bilgilerini güncelle
               self.updateUI()
           }, completion: nil)
       
    }
    
}
