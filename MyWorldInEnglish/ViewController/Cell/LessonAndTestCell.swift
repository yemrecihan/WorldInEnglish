
import UIKit

class LessonAndTestCell: UITableViewCell {

 
    @IBOutlet weak var testButton: UIButton!
    @IBOutlet weak var lessonButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
     
    
    }
    
    func setup() {
        // Ders Butonu Stili
        lessonButton.layer.cornerRadius = 10
        lessonButton.layer.borderWidth = 1
        lessonButton.layer.borderColor = UIColor.systemBlue.cgColor
        lessonButton.setTitleColor(.white, for: .normal)
        lessonButton.backgroundColor = UIColor.systemBlue
  
     
        // Ders Butonu Gölgesi
        lessonButton.layer.shadowColor = UIColor.black.cgColor // Gölge rengi
        lessonButton.layer.shadowOffset = CGSize(width: 0, height: 4) // Gölgenin konumu
        lessonButton.layer.shadowOpacity = 0.2 // Gölge opaklığı
        lessonButton.layer.shadowRadius = 4 // Gölge bulanıklığı/yumuşaklığı
        
        // Test Butonu Stili
        testButton.layer.cornerRadius = 10
        testButton.layer.borderWidth = 1
        testButton.layer.borderColor = UIColor.systemGreen.cgColor
        testButton.setTitleColor(.white, for: .normal)
        testButton.backgroundColor = UIColor.systemGreen
        // Test Butonu Gölgesi
        testButton.layer.shadowColor = UIColor.black.cgColor
        testButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        testButton.layer.shadowOpacity = 0.2
        testButton.layer.shadowRadius = 4
 
        // containerView stil ayarları
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        // ContainerView Gölgesi
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowOpacity = 0.1
        containerView.layer.shadowRadius = 6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

    @IBAction func TestButton(_ sender: Any) {
        print("Test butonuna tıklandı.")
    }
    @IBAction func lessonButton(_ sender: Any) {
        print("Ders butonuna tıklandı.")
    }
}
