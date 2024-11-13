/*

import UIKit

class LevelsPageVC: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var a1levelView: UIView!
    
    @IBOutlet weak var a2levelView: UIView!
    
    @IBOutlet weak var b1levelView: UIView!
    
    @IBOutlet weak var b2levelView: UIView!
    
    @IBOutlet weak var c1levelView: UIView!
    
    @IBOutlet weak var c2levelView: UIView!
    
    private let viewModel = LevelsPageViewModel()
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
                setupNavigation()
                updateLevelAccess()
                messageLabel.text = viewModel.message()
        // Kullanıcı adını ViewModel'e atıyoruz
        if let userName = userName {
            viewModel.userName = userName
        }
            }
            
            private func setupViews() {
                // Her seviyeye dokunma özelliği ekliyoruz
                addTapGesture(to: a1levelView, level: "A1")
                addTapGesture(to: a2levelView, level: "A2")
                addTapGesture(to: b1levelView, level: "B1")
                addTapGesture(to: b2levelView, level: "B2")
                addTapGesture(to: c1levelView, level: "C1")
                addTapGesture(to: c2levelView, level: "C2")
                // Her bir kart görünümüne radius ekliyoruz
                applyCornerRadius(to: a1levelView)
                applyCornerRadius(to: a2levelView)
                applyCornerRadius(to: b1levelView)
                applyCornerRadius(to: b2levelView)
                applyCornerRadius(to: c1levelView)
                applyCornerRadius(to: c2levelView)
            }
    private func applyCornerRadius(to view: UIView) {
        view.layer.cornerRadius = 10 // Köşe yarıçapını istediğiniz değere göre ayarlayın
        view.layer.masksToBounds = true // Kenarların görünmesini sağlar
    }
            
            private func addTapGesture(to view: UIView, level: String) {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(levelTapped(_:)))
                view.addGestureRecognizer(tapGesture)
                view.accessibilityIdentifier = level
            }
            
            @objc func levelTapped(_ sender: UITapGestureRecognizer) {
                guard let view = sender.view, let level = view.accessibilityIdentifier else { return }
                performSegue(withIdentifier: "toLessonAndTestPageVC", sender: level)
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if let navigationController = segue.destination as? UINavigationController,
                   let lessonsPageVC = navigationController.topViewController as? LessonsAndTestPage {
                    lessonsPageVC.selectedLevel = sender as? String
                }
            }
            
            private func updateLevelAccess() {
                let levels = viewModel.getLevels()
                let views = [a1levelView, a2levelView, b1levelView, b2levelView, c1levelView, c2levelView]
                
                for (index, view) in views.enumerated() {
                    let level = levels[index]
                    let isUnlocked = viewModel.isLevelUnlocked(level: level)
                    
                    view?.alpha = isUnlocked ? 1.0 : 0.5
                    view?.isUserInteractionEnabled = isUnlocked
                }
            }
            
            private func setupNavigation() {
                // Benzer navigasyon ayarlarını buraya da ekleyebiliriz
                self.navigationItem.title = "Levels"
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(red: 234/255, green: 230/255, blue: 223/255, alpha: 1)
                appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.black, // Başlık rengi
                    .font: UIFont.systemFont(ofSize: 24, weight: .bold) // Yazı tipi ve boyut (örneğin, 24)
                ]
                // Çizgiyi kaldırmak için shadowImage ve shadowColor ayarla
                appearance.shadowImage = UIImage() // Çizgiyi kaldırır
                appearance.shadowColor = .clear // Gölgeyi kaldırır
                
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
            }
        }*/
