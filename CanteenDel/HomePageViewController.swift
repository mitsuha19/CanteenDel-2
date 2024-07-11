import UIKit

class HomePageViewController: UIViewController {

    var name = ""
    var isNameReady = false
    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.shared.playBackgroundMusic()
    }
    
    func alertWithTF(){
            let alert = UIAlertController(title: "Input Your Name", message: "", preferredStyle:UIAlertController.Style.alert)
            
            let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }

            let save = UIAlertAction(title: "Ok", style: .default) {(alertAction) in
                let textField = alert.textFields![0] as UITextField
                
                self.name = textField.text ?? ""
                
                print("HomeViewController \(self.name)")
                // Simpan ke user default
                UserDefaults.standard.set(self.name, forKey: "USER_NAME")
                
                // Logic Segue
                self.performSegue(withIdentifier: "goToLevel", sender: self)
                
                self.isNameReady = true
            }
            
            alert.addTextField {
                (textField) in textField.placeholder = ""
                textField.textColor = .black
            }
            
            alert.addAction(cancel)
            alert.addAction(save)

        self.present(alert, animated:true) {
            AudioManager.shared.isMuted = false
        }
        
    }
        
    @IBAction func pressPlayButton(_ sender: Any) {
        AudioManager.shared.isMuted = true
        
        if isNameReady == false {
            alertWithTF()
        } else {
            self.performSegue(withIdentifier: "goToLevel", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLevel" {
            if let vc = segue.destination as? LevelViewController {
                vc.name = name
            }
        }
    }
}
