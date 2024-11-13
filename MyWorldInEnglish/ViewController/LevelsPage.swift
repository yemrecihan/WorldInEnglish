import UIKit
//import GoogleMobileAds
class LevelsPage: UIViewController  {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel = LevelsPageViewModel()
    private let levels = ["A1", "A2", "B1", "B2", "C1", "C2"] // Seviyeler
    var userName: String?
    //var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupNavigation()
        messageLabel.text = viewModel.message()
        // Kullanıcı adını ViewModel'e atıyoruz
        if let userName = userName {
            viewModel.userName = userName
        }
        // Banner reklamını oluşturuyoruz
        /*bannerView = GADBannerView(adSize: GADAdSizeBanner) // Hata burada düzeltilmeli
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-3575757618432419/4636143419"  // Buraya AdMob'dan aldığınız Ad Unit ID'sini yapıştırın
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        // Reklamı ekranın altına yerleştiriyoruz
        bannerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.view.frame.size.width, height: 50)
        self.view.addSubview(bannerView)*/
        
    }
    private func setupCollectionView() {
           collectionView.delegate = self
           collectionView.dataSource = self
           
       }
       
    private func setupNavigation() {
        self.navigationItem.title = "Levels"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 212/255, green: 196/255, blue: 184/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear
    
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
extension LevelsPage: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelsPageCollectionViewCell", for: indexPath) as? LevelsPageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let level = viewModel.getLevels()[indexPath.row]
        cell.configureCell(level: level.code, isUnlocked: level.isUnlocked, name: level.name)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension LevelsPage: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedLevel = viewModel.getLevels()[indexPath.row]
        
        if viewModel.isLevelUnlocked(level: selectedLevel) {
            performSegue(withIdentifier: "toLessonAndTestPageVC", sender: selectedLevel.code)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLessonAndTestPageVC",
           let navigationController = segue.destination as? UINavigationController,
           let lessonsPageVC = navigationController.topViewController as? LessonsAndTestPage {
            lessonsPageVC.selectedLevel = sender as? String
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LevelsPage: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - (padding * 3)
        let width = availableWidth / 2
        return CGSize(width: width, height: 190)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Satırlar arası boşluk
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Sütunlar arası boşluk
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Dış kenarlardan boşluk
    }
}

