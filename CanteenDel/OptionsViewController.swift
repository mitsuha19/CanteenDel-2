import UIKit

class OptionsViewController: UIViewController {

    @IBOutlet weak var volumeBgSoundSlider: UISlider!
    @IBOutlet weak var muteBgSound: UIImageView!
    
    @IBOutlet weak var muteClickSound: UIImageView!
    @IBOutlet weak var volumeClickSoundSlider: UISlider!
    
    @IBOutlet weak var btnBackToHome: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVolumeSlider()
        updateMuteIcons()
        AudioManager.shared.stopBgMusicScene()
        
        let bgSoundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(muteBgSoundTapped(_:)))
        muteBgSound.isUserInteractionEnabled = true
        muteBgSound.addGestureRecognizer(bgSoundTapGestureRecognizer)
        
        volumeBgSoundSlider.addTarget(self, action: #selector(volumeSliderChanged(_:)), for: .valueChanged)
        
        let clickSoundTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(muteClickSoundTapped(_:)))
        muteClickSound.isUserInteractionEnabled = true
        muteClickSound.addGestureRecognizer(clickSoundTapGestureRecognizer)
        
        volumeClickSoundSlider.addTarget(self, action: #selector(clickVolumeSliderChanged(_:)), for: .valueChanged)
        
        let backToHomeTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backToHomeTapped(_:)))
        btnBackToHome.isUserInteractionEnabled = true
        btnBackToHome.addGestureRecognizer(backToHomeTapGestureRecognizer)
    }
    
    @objc func muteBgSoundTapped(_ sender: UITapGestureRecognizer) {
        AudioManager.shared.isMuted.toggle()
        updateMuteIcons()
        AudioManager.shared.playClickSound()  // Play click sound on mute action
    }
    
    @objc func volumeSliderChanged(_ sender: UISlider) {
        let volume = sender.value
        AudioManager.shared.setVolume(volume)
        updateMuteIcons()
    }
    
    @objc func muteClickSoundTapped(_ sender: UITapGestureRecognizer) {
        AudioManager.shared.isClickSoundMuted.toggle()
        updateMuteIcons()
        AudioManager.shared.playClickSound()  // Play click sound on mute action
    }
    
    @objc func clickVolumeSliderChanged(_ sender: UISlider) {
        let volume = sender.value
        AudioManager.shared.setClickVolume(volume)
        updateMuteIcons()
    }
    
    @objc func backToHomeTapped(_ sender: UITapGestureRecognizer) {
        AudioManager.shared.playClickSound()
        self.dismiss(animated: false, completion: nil)
    }
    
    func updateMuteIcons() {
        let bgSoundIconName = AudioManager.shared.isMuted || AudioManager.shared.volume == 0 ? "logo-muteBgSound.png" : "logo-bgsound.png"
        muteBgSound.image = UIImage(named: bgSoundIconName)
        volumeBgSoundSlider.value = AudioManager.shared.isMuted ? 0 : AudioManager.shared.volume
        
        let clickSoundIconName = AudioManager.shared.isClickSoundMuted ? "logo-muteSoundClick.png" : "logo-soundClick.png"
        muteClickSound.image = UIImage(named: clickSoundIconName)
        volumeClickSoundSlider.value = AudioManager.shared.isClickSoundMuted ? 0 : AudioManager.shared.clickVolume
    }
    
    func setupVolumeSlider() {
        volumeBgSoundSlider.minimumValue = 0
        volumeBgSoundSlider.maximumValue = 1
        volumeBgSoundSlider.value = AudioManager.shared.isMuted ? 0 : AudioManager.shared.volume
        
        volumeClickSoundSlider.minimumValue = 0
        volumeClickSoundSlider.maximumValue = 1
        volumeClickSoundSlider.value = AudioManager.shared.isClickSoundMuted ? 0 : AudioManager.shared.clickVolume
    }
}
