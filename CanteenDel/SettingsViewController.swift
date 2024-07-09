import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var muteBgSound: UIImageView!
    
    @IBOutlet weak var muteSoundClick: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateMuteIcon()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(muteBgSoundTapped(_:)))
        muteBgSound.isUserInteractionEnabled = true
        muteBgSound.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc func muteBgSoundTapped(_ sender: UITapGestureRecognizer) {
        AudioManager.shared.isMuted.toggle()
        updateMuteIcon()
    }
    
    func updateMuteIcon() {
        let iconName = AudioManager.shared.isMuted ? "logo-muteBgSound.png" : "logo-bgsound.png"
        muteBgSound.image = UIImage(named: iconName)
    }
}
