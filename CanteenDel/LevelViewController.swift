//
//  LevelViewController.swift
//  Sotargoda**
//
//  Created by Foundation-022 on 01/07/24.
//

import UIKit

class LevelViewController: UIViewController {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var Username: UILabel!
    var level = 1
    var name = "-"
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("levelViewController \(self.name)")
            
            
            
            if let storedName = UserDefaults.standard.string(forKey: "USER_NAME") {
                Username.text = "Welcome " + storedName
            }
            
            // Do any additional setup after loading the view.
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
    
    // branch test
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
