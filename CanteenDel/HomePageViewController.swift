import UIKit

class HomePageViewController: UIViewController {

    var name = ""
    var ismusikBackground = true;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ismusikBackground {
            AudioManager.shared.playBackgroundMusic()
            ismusikBackground = false
        } else {
            AudioManager.shared.stopBgMusicScene()
        }
        
        setupImageViewAsButton()
        setupOptionViewAsButton()
    }
    
//    func alertWithTF() {
//        let alert = UIAlertController(title: "Input Your Name", message: "", preferredStyle: UIAlertController.Style.alert)
//        
//        let save = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
//            let textField = alert.textFields![0] as UITextField
//            AudioManager.shared.playClickSound()
//            
//            self.name = textField.text ?? ""
//            
//            print("HomeViewController \(self.name)")
//            // Simpan ke user default
//            UserDefaults.standard.set(self.name, forKey: "USER_NAME")
//            
//            // Logic Segue
//            self.performSegue(withIdentifier: "goToLevel", sender: self)
//        }
//        
//        alert.addTextField { (textField) in
//            textField.placeholder = ""
//            textField.textColor = .black
//        }
//        
//        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in
//            AudioManager.shared.playClickSound()
//        }
//        
//        alert.addAction(cancel)
//        alert.addAction(save)
//
//        self.present(alert, animated: true, completion: nil)
//    }
    
    @IBAction func pressPlayButton(_ sender: Any) {
        //alertWithTF()
        performSegue(withIdentifier: "goToLevel", sender: self)
        AudioManager.shared.playClickSound()
    }
    
    @IBOutlet weak var presPlay: UIImageView!
    @IBOutlet weak var pressOptions: UIImageView!
    
    func setupImageViewAsButton() {
        presPlay.isUserInteractionEnabled = true // Enable user interaction
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        presPlay.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func setupOptionViewAsButton(){
        presPlay.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(optionsTapped))
        pressOptions.addGestureRecognizer(tap)
    }
    
    @objc func optionsTapped() {
        AudioManager.shared.playClickSound()
        self.performSegue(withIdentifier: "gotoSetting", sender: self)
    }
    
    
    @objc func imageTapped() {
//        alertWithTF()
        performSegue(withIdentifier: "goToLevel", sender: self)
        AudioManager.shared.playClickSound()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLevel" {
            if let vc = segue.destination as? LevelViewController {
                vc.name = name
            }
        } else if segue.identifier == "OptionsViewController" {
            
        }
    }
}
