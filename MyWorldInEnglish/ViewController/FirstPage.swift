
import UIKit
import UIKit

class FirstPage: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var levelPickerView: UIPickerView!
    
    @IBOutlet weak var nextButton: UIButton!
    let levels = ["A1","A2","B1","B2","C1","C2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelPickerView.dataSource = self
        levelPickerView.delegate = self
        setupButtonStyle()
        hideKeyboard()
    }
    func hideKeyboard () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard2))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard2() {
        view.endEditing(true) // Klavyeyi kapatır
    }
    func setupButtonStyle (){
        nextButton.backgroundColor = UIColor.systemMint
        nextButton.layer.cornerRadius = 10
        nextButton.clipsToBounds = true
    }
    
   
    @IBAction func nextButton(_ sender: Any) {
        
        
        guard let userName = userNameTextField.text , !userName.isEmpty else {
            print("Please enter your username")
            return
        }
        let selectedRow = levelPickerView.selectedRow(inComponent: 0)
        let selectedLevel = levels[selectedRow]
        
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(selectedLevel,forKey: "selectedLevel")
        
        print("userName and level registered : \(selectedLevel),\(userName)")
        
        performSegue(withIdentifier: "toLevelsVC", sender: nil)
        
    }
  
    

}
extension FirstPage: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1 // Sadece bir sütun var
       }
       
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return levels.count // Verinin sayısı kadar satır
       }
       
       // UIPickerViewDelegate Protokol Fonksiyonu
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return levels[row] // Her bir satır için seviyeyi döndür
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           let selectedLevel = levels[row]
           print("Seçilen Seviye: \(selectedLevel)")
       }
}

