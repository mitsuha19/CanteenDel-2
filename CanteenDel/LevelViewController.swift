import UIKit

class LevelViewController: UIViewController {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Username: UILabel!
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
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        }
        
    @IBAction func Next(_ sender: Any) {
        AudioManager.shared.playClickSound()
        if level == 1 {
            if UserDefaults.standard.bool(forKey: "Level1Won") {
                ImageView.image = UIImage(named: "level2")
                level = 2
            } else {
                ImageView.image = UIImage(named: "level2lock")
                level = 2
            }
        } else if level == 2 {
            ImageView.image = UIImage(named: "level3")
            level = 3
        }
    }
    
    @IBAction func Back(_ sender: Any) {
        AudioManager.shared.playClickSound()
        if level == 3 {
            if UserDefaults.standard.bool(forKey: "Level1Won") {
                ImageView.image = UIImage(named: "level2")
                level = 2
            } else {
                ImageView.image = UIImage(named: "level2lock")
                level = 2
            }
        } else if level == 2 {
            ImageView.image = UIImage(named: "level1")
            level = 1
        }
    }
    
    @IBAction func GoToGameLevel1(_ sender: Any) {
        if level == 1 {
            AudioManager.shared.playClickSound()
            self.performSegue(withIdentifier: "goToGameLevel1", sender: self)
        } else if level == 2 {
            if UserDefaults.standard.bool(forKey: "Level1Won") {
                AudioManager.shared.playClickSound()
                self.performSegue(withIdentifier: "goToGameLevel2", sender: self)
            } else {
                AudioManager.shared.playClickSound()
            }
        } else if level == 3 {
            AudioManager.shared.playClickSound()
            self.performSegue(withIdentifier: "goToGameLevel3", sender: self)

        }
    }
    
    @IBAction func goHomePage(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        AudioManager.shared.playClickSound()
    }
    
    @objc func goToLevelScreen() {
            navigationController?.popViewController(animated: false)
        AudioManager.shared.playClickSound()
        }
}
