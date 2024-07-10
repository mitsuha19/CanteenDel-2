import UIKit

class LevelViewController: UIViewController {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Username: UILabel!
    var level = 1
    var name = "-"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            NotificationCenter.default.addObserver(self, selector: #selector(goToLevelScreen), name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
            
            print("levelViewController \(self.name)")
            
            if let storedName = UserDefaults.standard.string(forKey: "USER_NAME") {
                Username.text = "Welcome " + storedName
            }
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        }
        
    @IBAction func Next(_ sender: Any) {
        if level == 1 {
            ImageView.image = UIImage(named: "level2lock")
            level = 2
            ImageView.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func Back(_ sender: Any) {
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
    }
    
    @objc func goToLevelScreen() {
            navigationController?.popViewController(animated: true)
        }
}
