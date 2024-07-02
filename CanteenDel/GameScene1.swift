import SpriteKit

class GameScene1: SKScene {

    var draggableNodes = [SKSpriteNode]()
    var activeTouches = [UITouch: SKSpriteNode]()
    var initialPositions = [SKSpriteNode: CGPoint]()
    
    var settingsButton: SKSpriteNode?
    var settingsPopup: SKSpriteNode?
    
    var reverseTimeEnabled = false
    var reverseDuration: TimeInterval = 5.0
    var timeLabel: SKLabelNode!
    
    var countdownTime: TimeInterval = 60
    var countdownAction: SKAction!

    // Inisiasi ompreng
       var ompreng: SKSpriteNode!
       var omprengPosition = 1
    
    override func didMove(to view: SKView) {
        print("Hello")
        
        // Inisialisasi dan tambahkan label waktu
        timeLabel = SKLabelNode(text: "01:00")
        timeLabel.fontSize = 36
        timeLabel.fontColor = .black
        timeLabel.position = CGPoint(x: 0, y: 270)
        timeLabel.zPosition = 10
        addChild(timeLabel)
        
        // Mulai hitung mundur
        startCountdown()
        
        // Inisialisasi ompreng node
        if let omprengNode = self.childNode(withName: "//ompreng") as? SKSpriteNode {
            ompreng = omprengNode
        } else {
            print("Ompreng node not found")
        }
        
        if let ayam = self.childNode(withName: "//ayam") as? SKSpriteNode {
            draggableNodes.append(ayam)
            initialPositions[ayam] = ayam.position
            print("Ayam node found")
        }
        if let ikan = self.childNode(withName: "//ikan") as? SKSpriteNode {
            draggableNodes.append(ikan)
            initialPositions[ikan] = ikan.position
            print("ikan node found")
        }
        if let telur = self.childNode(withName: "//telur") as? SKSpriteNode {
            draggableNodes.append(telur)
            initialPositions[telur] = telur.position
            print("Telur node found")
        }
        if let semangka = self.childNode(withName: "//semangka") as? SKSpriteNode {
            draggableNodes.append(semangka)
            initialPositions[semangka] = semangka.position
            print("semangka node found")
        }
        if let jeruk = self.childNode(withName: "//jeruk") as? SKSpriteNode {
            draggableNodes.append(jeruk)
            initialPositions[jeruk] = jeruk.position
            print("jeruk node found")
        }
        if let apel = self.childNode(withName: "//apel") as? SKSpriteNode {
            draggableNodes.append(apel)
            initialPositions[apel] = apel.position
            print("apel node found")
        }
    }

    func updateOmprengPosition(){
        ompreng.run(SKAction.moveBy(x: 0, y: 170, duration: 0.5))
    }
    
    func startCountdown() {
        countdownAction = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.updateCountdown()
            },
            SKAction.wait(forDuration: 1.0)
        ])
        
        run(SKAction.repeat(countdownAction, count: Int(countdownTime)))
    }

    func updateCountdown() {
        if countdownTime > 0 {
            countdownTime -= 1
            
            let minutes = Int(countdownTime) / 60
            let seconds = Int(countdownTime) % 60
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
            // Waktu habis, lakukan sesuatu
            timeLabel.text = "00:00"
            // Misalnya, Anda bisa memanggil metode game over di sini
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            if ompreng.contains(touchLocation) {
                updateOmprengPosition()
            }
            
            for node in draggableNodes {
                if node.contains(touchLocation) {
                    activeTouches[touch] = node
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if let node = activeTouches[touch] {
                let touchLocation = touch.location(in: self)
                node.position = touchLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeTouches.removeValue(forKey: touch)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            activeTouches.removeValue(forKey: touch)
        }
    }
    
    
    func enableReverseTime() {
        reverseTimeEnabled = true
        run(SKAction.wait(forDuration: reverseDuration)) { [weak self] in
            self?.reverseTimeEnabled = false
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if reverseTimeEnabled {
            // Logika untuk membalikkan waktu
            for (node, initialPosition) in initialPositions {
                node.position = CGPoint(
                    x: node.position.x - (node.position.x - initialPosition.x) * 0.1,
                    y: node.position.y - (node.position.y - initialPosition.y) * 0.1
                )
            }
        }
    }
}
