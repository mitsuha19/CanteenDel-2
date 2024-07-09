import UIKit

class HomePageViewController: UIViewController {

    var name = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.shared.playBackgroundMusic(fileName: "bgmusic", fileType: "wav")
    }
    
    func alertWithTF() {
        let alert = UIAlertController(title: "Input Your Name", message: "", preferredStyle: UIAlertController.Style.alert)
        
        let save = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            
            self.name = textField.text ?? ""
            
            print("HomeViewController \(self.name)")
            UserDefaults.standard.set(self.name, forKey: "USER_NAME")
            self.performSegue(withIdentifier: "goToLevel", sender: self)
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = ""
            textField.textColor = .black
        }
        
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pressPlayButton(_ sender: Any) {
        AudioManager.shared.playSoundEffect(fileName: "clickSound", fileType: "wav")
        alertWithTF()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLevel" {
            if let vc = segue.destination as? LevelViewController {
                vc.name = name
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

