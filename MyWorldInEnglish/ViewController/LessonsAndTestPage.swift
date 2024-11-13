

import UIKit

class LessonsAndTestPage: UITableViewController {
    
    var selectedLevel: String?
    var lessons: [LessonModel] = []
    var viewModel = LessonAndTestViewModel()
    
    // Kullanıcı ilerlemesini almak
    var unlockedLessonsCount = 1 // Başlangıçta sadece Ders 1 ve Test 1 açık
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
   
        // Hücreler arasındaki çizgiyi kaldır
         tableView.separatorStyle = .none
        setupNavigation()
        loadLessonsAndTests()
        
        // İlerleme bilgisini al
        unlockedLessonsCount = UserDefaults.standard.integer(forKey: "\(selectedLevel ?? "")_unlockedLessons")
        if unlockedLessonsCount == 0 {
            unlockedLessonsCount = 1 // Varsayılan olarak ilk ders ve test açık
        }
        
    }
    private func setupNavigation() {
        let backButton = UIBarButtonItem(title: "<- Back", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        self.navigationItem.title = "Lesson and Test" // Navigation bar başlığını ayarlama
        self.navigationController?.navigationBar.prefersLargeTitles = true // Büyük başlık kullanma
        // Arka plan rengini ayarla
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 212/255, green: 196/255, blue: 184/255, alpha: 1) // #E0DAD3
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black] // Başlık rengi
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black] // Büyük başlık rengi
        
        // Çizgiyi kaldırmak için shadowImage ve shadowColor ayarla
        appearance.shadowImage = UIImage() // Çizgiyi kaldırır
        appearance.shadowColor = .clear // Gölgeyi kaldırır

        // Görünümü navigation bar'a uygula
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    @objc func backButtonTapped() {
        // Ekranı kapatmak için dismiss kullanıyoruz
        self.dismiss(animated: true, completion: nil)
    }
    func loadLessonsAndTests() {
        guard let level = selectedLevel else { return } // Seçilen seviyeyi al
        viewModel.loadLessonsAndTests(forLevel: level) // Seçilen seviyeyi yükle
        lessons = viewModel.lessons
        // Yüklenen ders sayısını kontrol et
        print("Yüklenen ders sayısı: \(lessons.count)") // Burada ders sayısını konsola yazdır
        
        // Eğer dersler boşsa, bir mesaj da yazdırabilirsiniz
        if lessons.isEmpty {
            print("Seçilen seviyeye ait ders bulunamadı.")
        }
        tableView.reloadData() // Verileri güncelle
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lessons.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as! LessonAndTestCell
        let lesson = lessons[indexPath.row]
        
        // Ders ve test butonlarını ayarla
        cell.lessonButton.setTitle(lesson.title, for: .normal)
        cell.testButton.setTitle("Test \(indexPath.row + 1)", for: .normal)
        
        // Kullanıcı ilerlemesine göre butonları etkinleştir/pasifleştir
        if indexPath.row < unlockedLessonsCount {
            cell.lessonButton.isEnabled = true
            cell.testButton.isEnabled = true
            cell.lessonButton.alpha = 1.0
            cell.testButton.alpha = 1.0
        } else {
            cell.lessonButton.isEnabled = false
            cell.testButton.isEnabled = false
            cell.lessonButton.alpha = 0.5
            cell.testButton.alpha = 0.5
        }
        
        // Ders ve test butonlarına action ekle
        cell.lessonButton.tag = indexPath.row
        cell.testButton.tag = indexPath.row
        cell.lessonButton.addTarget(self, action: #selector(openLesson), for: .touchUpInside)
        cell.testButton.addTarget(self, action: #selector(openTest), for: .touchUpInside)
        
        return cell
    }
  

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 // İstediğiniz yükseklik (örneğin, 80)
    }

    
    // Ders sayfasına yönlendirme
    @objc func openLesson(sender: UIButton) {
        let selectedLesson = lessons[sender.tag]
        // Ders sayfasına yönlendirme kodlarını burada ekleyin
        performSegue(withIdentifier: "toWordsPageVC", sender: selectedLesson)
        // lesson.words kullanarak dersi doldurabilirsiniz
    }
    // Test sayfasına yönlendirme
    @objc func openTest(sender: UIButton) {
        let selectedTest = viewModel.tests[sender.tag]
        // Test sayfasına yönlendirme kodlarını burada ekleyin
        performSegue(withIdentifier: "toTestPageVC", sender: selectedTest)
        // test.words kullanarak testi doldurabilirsiniz
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare(for segue:) çağrıldı")
        
        if segue.identifier == "toWordsPageVC" {
            print("Segue identifier doğru - toWordsPageVC") // Identifier doğruluğunu kontrol etmek için
            
            if let navController = segue.destination as? UINavigationController,
               let destinationVC = navController.topViewController as? WordsPageVC {
               
                print("DestinationVC doğru türde: WordsPageVC") // destination türü doğru
                
                if let selectedLesson = sender as? LessonModel {
                    // Kelimeleri aktar
                    destinationVC.viewModel = WordsPageViewModel(words: selectedLesson.words)
                    print("viewModel başarılı şekilde WordsPageVC'ye aktarıldı")
                } else {
                    print("sender, LessonModel türünde değil")
                }
            } else {
                print("destinationVC, NavigationController ya da WordsPageVC türünde değil")
            }
        } else if segue.identifier == "toTestPageVC" {
            print("Segue identifier doğru - toTestPageVC") // Identifier doğruluğunu kontrol etmek için
            
            if let navController = segue.destination as? UINavigationController,
               let destinationVC = navController.topViewController as? TestPageVC {
               
                print("DestinationVC doğru türde: TestPageVC") // destination türü doğru
                
                if let selectedTest = sender as? TestModel {
                    destinationVC.delegate = self // Delegate ataması
                    // Test kelimelerini aktar
                    let allWords = viewModel.allWords
                    destinationVC.viewModel = TestPageViewModel(words: selectedTest.words, allWords: allWords)
                    print("viewModel başarılı şekilde TestPageVC'ye aktarıldı")
                } else {
                    print("sender, TestModel türünde değil")
                }
            } else {
                print("destinationVC, NavigationController ya da TestPageVC türünde değil")
            }
        } else {
            print("Bilinmeyen segue identifier")
        }
    }

    
}
extension LessonsAndTestPage: TestPageVCDelegate {
    func didCompleteTest(withScore score: Int) {
        if score >= 70 {
            unlockedLessonsCount += 1
            UserDefaults.standard.set(unlockedLessonsCount, forKey: "\(selectedLevel ?? "")_unlockedLessons")
            tableView.reloadData()
            
            if unlockedLessonsCount >= lessons.count {
                unlockNextLevel()
            }
        }
    }
    private func unlockNextLevel() {
        let levels = ["A1", "A2", "B1", "B2", "C1", "C2"]
        
        // Geçerli seviyeyi bul
        guard let currentLevel = selectedLevel,
              let currentIndex = levels.firstIndex(of: currentLevel),
              currentIndex < levels.count - 1 else {
            return // En son seviye ise çık
        }
        
        // Bir sonraki seviyeyi al ve kaydet
        let nextLevel = levels[currentIndex + 1]
        UserDefaults.standard.set(true, forKey: "\(nextLevel)_isUnlocked")
        
        // Kullanıcıya mesaj göster (isteğe bağlı)
        let alert = UIAlertController(title: "Tebrikler!", message: "\(nextLevel) seviyesinin kilidi açıldı!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

