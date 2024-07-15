//
//  OnBoardingViewController.swift
//  CanteenDel
//
//  Created by Foundation-020 on 11/07/24.
//

import UIKit

class OnBoardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AudioManager.shared.playBackgroundMusic()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func gotohomepage(_ sender: Any) {
        AudioManager.shared.playClickSound()
        performSegue(withIdentifier: "onBoardingToHomePage", sender: self)
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
