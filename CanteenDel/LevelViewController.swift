import UIKit

class LevelViewController: UIViewController {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Username: UILabel!
    var level2Image = UIImage(named: "level2lock")
    var level = 1
    var name = "-"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            AudioManager.shared.stopBgMusicScene()
            AudioManager.shared.playBackgroundMusic()
            NotificationCenter.default.addObserver(self, selector: #selector(goToLevelScreen), name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)

            
            print("levelViewController \(self.name)")
            
            if let storedName = UserDefaults.standard.string(forKey: "USER_NAME") {
                Username.text = "Welcome " + storedName
            }
            
            if UserDefaults.standard.bool(forKey: "Level1Won"){
                level2Image = UIImage(named: "level2")
                level = 2
                ImageView.image = level2Image
                ImageView.isUserInteractionEnabled = false
            } else {
                ImageView.image = UIImage(named: "level1")
                level = 1
                ImageView.isUserInteractionEnabled = true
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        }
        
    @IBAction func Next(_ sender: Any) {
        
        if UserDefaults.standard.bool(forKey: "Level1Won"){
            level2Image = UIImage(named: "level2")
            level = 2
            ImageView.image = level2Image
            ImageView.isUserInteractionEnabled = false
        } else {
            ImageView.image = UIImage(named: "level1")
            level = 1
            ImageView.isUserInteractionEnabled = true
        }
        
        AudioManager.shared.playClickSound()
        if level == 1 {
            ImageView.image = level2Image
            level = 2
            ImageView.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        
        if UserDefaults.standard.bool(forKey: "Level1Won"){
            level2Image = UIImage(named: "level2")
            level = 2
            ImageView.image = level2Image
            ImageView.isUserInteractionEnabled = false
        } else {
            ImageView.image = UIImage(named: "level1")
            level = 1
            ImageView.isUserInteractionEnabled = true
        }
        
        AudioManager.shared.playClickSound()
        if level == 2 {
            ImageView.image = UIImage(named: "level1")
            level = 1
            ImageView.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func nor(_ sender: Any) {
        if level == 1 {
            performSegue(withIdentifier: "goGameLevel1", sender: nil)
        } else {
            let alert = UIAlertController(title: "Level Locked", message: "Level 2 is locked. Please unlock it first.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func goHomePage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        AudioManager.shared.playClickSound()
    }
    
    @objc func goToLevelScreen() {
            navigationController?.popViewController(animated: true)
        AudioManager.shared.playClickSound()
        }
}
