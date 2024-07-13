import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    var backgroundMusicPlayer: AVAudioPlayer?
    var backgroundMusicScene: AVAudioPlayer?
    var backgroundOrderedFinished: AVAudioPlayer?
    var backgroundLose: AVAudioPlayer?
    var backgroundWin: AVAudioPlayer?
    
    
    private var isPlayingBackgroundMusic = false
    private var isPlayingBackgroundMusicScene = false
    private var isPlayingMusicOrederedFinished = false
    private var isPlayingMusicLose = false
    private var isPlayingMusicWin = false
    private var clickSoundPlayer: AVAudioPlayer?
    
    var isMuted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isMuted")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isMuted")
            if newValue {
                backgroundMusicPlayer?.volume = 0
            } else {
                backgroundMusicPlayer?.volume = volume
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
    
    private(set) var volume: Float {
        get {
            if UserDefaults.standard.object(forKey: "volume") == nil {
                UserDefaults.standard.set(0.5, forKey: "volume") // Set default volume to 50%
            }
            return UserDefaults.standard.float(forKey: "volume")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "volume")
            if !isMuted {
                backgroundMusicPlayer?.volume = newValue
            }
        }
    }
    
    private(set) var clickVolume: Float {
        get {
            if UserDefaults.standard.object(forKey: "clickVolume") == nil {
                UserDefaults.standard.set(0.5, forKey: "clickVolume") // Set default volume to 50%
            }
            return UserDefaults.standard.float(forKey: "clickVolume")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "clickVolume")
            if !isClickSoundMuted {
                clickSoundPlayer?.volume = newValue
            }
        }
    }
    
    
    
    private init() {}
    
    func playBackgroundMusic() {
        if !isPlayingBackgroundMusic {
            if let path = Bundle.main.path(forResource: "musikOnBoarding", ofType: "wav") {
                let url = URL(fileURLWithPath: path)
                do {
                    backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
                    backgroundMusicPlayer?.numberOfLoops = -1
                    backgroundMusicPlayer?.volume = isMuted ? 0 : volume
                    backgroundMusicPlayer?.play()
                    isPlayingBackgroundMusic = true
                } catch {
                    print("Error playing background music: \(error)")
                }
            }
        } else {
            backgroundMusicPlayer?.volume = isMuted ? 0 : volume
        }
    }
    
    func playBackgroundMusicScene() {
        if !isPlayingBackgroundMusic {
            if let path = Bundle.main.path(forResource: "musikGameScene", ofType: "wav") {
                let url = URL(fileURLWithPath: path)
                do {
                    backgroundMusicScene = try AVAudioPlayer(contentsOf: url)
                    backgroundMusicScene?.numberOfLoops = -1
                    backgroundMusicScene?.volume = isMuted ? 0 : volume
                    backgroundMusicScene?.play()
                    isPlayingBackgroundMusicScene = true
                } catch {
                    print("Error playing background music: \(error)")
                }
            }
        } else {
            backgroundMusicScene?.volume = isMuted ? 0 : volume
        }
    }
    
    func playMusicOrederFinished() {
        if !isClickSoundMuted {
            if let path = Bundle.main.path(forResource: "musikOrdered", ofType: "wav") {
                let url = URL(fileURLWithPath: path)
                do {
                    backgroundOrderedFinished = try AVAudioPlayer(contentsOf: url)
                    backgroundOrderedFinished?.play()
                } catch {
                    print("Error playing click sound: \(error)")
                }
            }
        }
    }
    
    func playMusicLose() {
        if !isPlayingMusicLose {
            if let path = Bundle.main.path(forResource: "musikKalah", ofType: "wav") {
                let url = URL(fileURLWithPath: path)
                do {
                    backgroundLose = try AVAudioPlayer(contentsOf: url)
                    backgroundLose?.play()
                } catch {
                    print("Error playing click sound: \(error)")
                }
            }
        }
    }
    
    func playMusicWin() {
        if !isPlayingMusicWin {
            if let path = Bundle.main.path(forResource: "musikMenang", ofType: "wav") {
                let url = URL(fileURLWithPath: path)
                do {
                    backgroundWin = try AVAudioPlayer(contentsOf: url)
                    backgroundWin?.play()
                    print("Musik WIn")
                } catch {
                    print("Error playing click sound: \(error)")
                }
            }
        }
    }
    
    func setVolume(_ volume: Float) {
        self.volume = volume
    }
    
    func setClickVolume(_ volume: Float) {
        self.clickVolume = volume
    }
    
    func playSoundEffect() {
        if !isClickSoundMuted {
            if let path = Bundle.main.path(forResource: "musikClick", ofType: "mp3") {
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
    
    func playClickSound() {
        if !isClickSoundMuted {
            if let path = Bundle.main.path(forResource: "musikClick", ofType: "wav") {
                let url = URL(fileURLWithPath: path)
                do {
                    clickSoundPlayer = try AVAudioPlayer(contentsOf: url)
                    clickSoundPlayer?.volume = clickVolume
                    clickSoundPlayer?.play()
                } catch {
                    print("Error playing click sound: \(error)")
                }
            }
        }
    }
    
    func stopBgMusic(){
        isPlayingBackgroundMusic = false
        backgroundMusicPlayer = nil
    }
    
    func stopBgMusicScene(){
        isPlayingBackgroundMusicScene = false
        backgroundMusicScene = nil
    }
}
