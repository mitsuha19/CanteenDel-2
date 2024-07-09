import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    var backgroundMusicPlayer: AVAudioPlayer?
    var isMuted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isMuted")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isMuted")
            if newValue {
                backgroundMusicPlayer?.stop()
            } else {
                playBackgroundMusic(fileName: "bgmusic", fileType: "wav")
            }
        }
    }
    
    var isClickSoundMuted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isClickSoundMuted")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isClickSoundMuted")
        }
    }
    
    private init() {}
    
    func playBackgroundMusic(fileName: String, fileType: String) {
        if !isMuted {
            if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
                let url = URL(fileURLWithPath: path)
                do {
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                    backgroundMusicPlayer?.numberOfLoops = -1
                    backgroundMusicPlayer?.play()
                } catch {
                    print("Error playing background music: \(error)")
                }
            }
        }
    }
    
    func playSoundEffect(fileName: String, fileType: String) {
        if !isClickSoundMuted {
            if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
                let url = URL(fileURLWithPath: path)
                do {
                    let soundEffectPlayer = try AVAudioPlayer(contentsOf: url)
                    soundEffectPlayer.play()
                } catch {
                    print("Error playing sound effect: \(error)")
                }
            }
        }
    }
    
    
}
