/*import UIKit
import GoogleMobileAds

class AdMob: UIViewController, GADBannerViewDelegate {

    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Banner reklamını oluşturuyoruz
        bannerView = GADBannerView(adSize: GADAdSizeBanner) // Hata burada düzeltilmeli
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-3575757618432419/4636143419"  // Buraya AdMob'dan aldığınız Ad Unit ID'sini yapıştırın
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        // Reklamı ekranın altına yerleştiriyoruz
        bannerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 50, width: self.view.frame.size.width, height: 50)
        self.view.addSubview(bannerView)
    }
}

*/
