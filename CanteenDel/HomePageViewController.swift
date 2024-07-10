import UIKit

class HomePageViewController: UIViewController {

    var name = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func alertWithTF(){
            let alert = UIAlertController(title: "Input Your Name", message: "", preferredStyle:UIAlertController.Style.alert)
            
            let save = UIAlertAction(title: "Ok", style: .default) {(alertAction) in
                let textField = alert.textFields![0] as UITextField
                
                self.name = textField.text ?? ""
                
                print("HomeViewController \(self.name)")
                // Simpan ke user default
                UserDefaults.standard.set(self.name, forKey: "USER_NAME")
                
                // Logic Segue
                self.performSegue(withIdentifier: "goToLevel", sender: self)
                
            }
            
            alert.addTextField {
                (textField) in textField.placeholder = ""
                textField.textColor = .black
            }
            
            alert.addAction(save)
            // cancel
            let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
            alert.addAction(cancel)
            //OR single line action
            //alert.addAction(UIAlertAction(title: "Cancel",style: .default) { (alertAction) in })

            self.present(alert, animated:true, completion: nil)

        }
        
    @IBAction func pressPlayButton(_ sender: Any) {
        alertWithTF()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLevel" {
            if let vc = segue.destination as? LevelViewController {
                vc.name = name
            }
        }
    }
}
