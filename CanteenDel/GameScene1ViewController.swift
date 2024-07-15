import UIKit
import SpriteKit

class GameScene1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToLevelScreen), name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToComingSoon), name: NSNotification.Name(rawValue: "GoToComingSoon"), object: nil)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        if let view = self.view as! SKView? {
            
            if let scane = SKScene(fileNamed: "GameScene1") {
                scane.scaleMode = .aspectFill
                
                view.presentScene(scane)
                print("Scene Open")
            }
        }
    }
    
    @objc func goToLevelScreen() {
        let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromRight
            navigationController?.view.layer.add(transition, forKey: kCATransition)
            navigationController?.popViewController(animated: false)
    }
    
    @objc func goToComingSoon() {
        
       // performSegue(withIdentifier: "ComingSoon", sender: self)
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromRight
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        let vc = storyboard?.instantiateViewController(withIdentifier: "ComingSoonViewController")
        navigationController?.pushViewController(vc!, animated: false)
    }
}
