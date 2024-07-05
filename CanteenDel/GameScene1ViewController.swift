//
//  GameScene1ViewController.swift
//  CanteenDel
//
//  Created by Foundation-022 on 02/07/24.
//

import UIKit
import SpriteKit

class GameScene1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(goToLevelScreen), name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        if let view = self.view as! SKView? {
            
            if let scane = SKScene(fileNamed: "GameScene1") {
                scane.scaleMode = .aspectFill
                
                view.presentScene(scane)
                print("Scene Open")
            }
            
            view.showsNodeCount = true
            view.showsFPS = true
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
