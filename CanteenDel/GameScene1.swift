import SpriteKit

class GameScene1: SKScene {

    var draggableNodes = [SKSpriteNode]()
    var activeTouches = [UITouch: SKSpriteNode]()
    var alreadyDragNodes = [SKSpriteNode]()
    var initialPositions = [SKSpriteNode: CGPoint]()
    
    var settingsButton: SKSpriteNode?
    var settingsPopup: SKSpriteNode?
    
    var reverseTimeEnabled = false
    var reverseDuration: TimeInterval = 5.0
    var timeLabel: SKLabelNode!
    
    var countdownTime: TimeInterval = 60
    var countdownAction: SKAction!
    
    var char1: SKSpriteNode?
    var char2: SKSpriteNode?
    var char3: SKSpriteNode?

    // Inisiasi ompreng
    var omprengs = [SKSpriteNode]()
    //var ompreng: SKSpriteNode!
    var omprengPressed = false
    
    var isGameOver = false
    
    override func didMove(to view: SKView) {
        print("Hello")
        
        char1 = self.childNode(withName: "//char1") as? SKSpriteNode
        char2 = self.childNode(withName: "//char2") as? SKSpriteNode
        char3 = self.childNode(withName: "//char3") as? SKSpriteNode
        
        // Panggil fungsi untuk menampilkan popup
        showStartPopup()
        
        // Inisialisasi dan tambahkan label waktu
        timeLabel = SKLabelNode(text: "01:00")
        timeLabel.fontSize = 36
        timeLabel.fontColor = .black
        timeLabel.position = CGPoint(x: 0, y: 270)
        timeLabel.zPosition = 10
        addChild(timeLabel)
        
        // Inisialisasi ompreng node
        if let omprengNode = self.childNode(withName: "//ompreng") as? SKSpriteNode {
            omprengs.append(omprengNode)
            initialPositions[omprengNode] = omprengNode.position
        } else {
            print("Ompreng node not found")
        }
                
        let draggableNodeNames = ["ayam", "ikan", "telur", "semangka", "jeruk", "apel"]
            for nodeName in draggableNodeNames {
                if let node = self.childNode(withName: "//\(nodeName)") as? SKSpriteNode {
                    draggableNodes.append(node)
                    initialPositions[node] = node.position
                    print("\(nodeName) node found")
                    }
                }
            }
    
    // Fungsi untuk menampilkan popup
       func showStartPopup() {
           // Buat background node
           let background = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 200))
           background.position = CGPoint(x: frame.midX, y: frame.midY)
           background.zPosition = 100 // Letakkan di atas semua node lain
           
           // Buat label teks
           let label = SKLabelNode(text: "Target 8 Mahasiswa")
           label.fontSize = 20
           label.fontColor = SKColor.black
           label.position = CGPoint(x: 0, y: 20)
           
           // Buat tombol OK
           let okButton = SKLabelNode(text: "OK")
           okButton.fontColor = SKColor.blue
           okButton.fontSize = 20
           okButton.name = "okButton"
           okButton.position = CGPoint(x: -50, y: -40)
           
           // Buat tombol Cancel
           let cancelButton = SKLabelNode(text: "Cancel")
           cancelButton.fontColor = SKColor.red
           cancelButton.fontSize = 20
           cancelButton.name = "cancelButton"
           cancelButton.position = CGPoint(x: 50, y: -40)
           
           // Tambahkan semua node ke popup
           background.addChild(label)
           background.addChild(okButton)
           background.addChild(cancelButton)
           
           // Tambahkan popup ke scene
           addChild(background)
       }
    
    func gameOverPopup() {
        let background = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 200))
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 100 // Letakkan di atas semua node lain
        
        // Buat label teks
        let timeOverlabel = SKLabelNode(text: "Timer Over")
        timeOverlabel.fontSize = 20
        timeOverlabel.fontColor = SKColor.black
        timeOverlabel.position = CGPoint(x: 0, y: 70)
        
        // buat label teks
        // Hands On in here buat score
        
        //buat bintang dan perhitungan bintang
        // Hands On in here buat perhitungan animasi dan munculnya bintang
        
        // Buat tombol OK
        let playAgainButton = SKLabelNode(text: "Play Again")
        playAgainButton.fontColor = SKColor.black
        playAgainButton.fontSize = 20
        playAgainButton.name = "playAgainButton"
        playAgainButton.position = CGPoint(x: -50, y: -80)
        
        // Buat tombol Cancel
        let homeButton = SKLabelNode(text: "Home")
        homeButton.fontColor = SKColor.black
        homeButton.fontSize = 20
        homeButton.name = "homeButton"
        homeButton.position = CGPoint(x: 50, y: -80)
        
        // Tambahkan semua node ke popup
        background.addChild(timeOverlabel)
        background.addChild(playAgainButton)
        background.addChild(homeButton)
        
        // Tambahkan popup ke scene
        addChild(background)
    }
    
    func restartGame() {
        if let scene = SKScene(fileNamed: "GameScene1") {
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: .white, duration: 1)
            view?.presentScene(scene, transition: transition)
        }
    }

    func createDraggableNode(named name: String) {
        if let nodeTemplate = self.childNode(withName: "//\(name)") as? SKSpriteNode {
            let node = nodeTemplate.copy() as! SKSpriteNode
            node.position = initialPositions[nodeTemplate] ?? nodeTemplate.position
            node.zPosition = 1
            node.name = name
            //self.ompreng.addChild(nodeTemplate)
            self.addChild(node)
            draggableNodes.append(node)
            initialPositions[node] = node.position
        }
    }
    
    func updateOmprengPosition(){
        for ompreng in omprengs {
            ompreng.run(SKAction.moveBy(x: 0, y: 170, duration: 0.5))
        }
        
    }
    
    func startCountdown() {
        countdownAction = SKAction.sequence([
            SKAction.run { [weak self] in
                self?.updateCountdown()
            },
            SKAction.wait(forDuration: 0.1)
        ])
        
        run(SKAction.repeat(countdownAction, count: Int(countdownTime)))
    }

    func updateCountdown() {
        
        if countdownTime > 0 {
            countdownTime -= 1
            
            let minutes = Int(countdownTime) / 60
            let seconds = Int(countdownTime) % 60
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            if seconds == 0 {
                isGameOver = true
                gameOverPopup()
                self.isPaused = true
            }
        }
    }
            
    func moveCharacterToCenter() {
        // Memastikan char1 dan char2 tidak nil
        guard let char1 = char1, let char2 = char2, let char3 = char3 else { return }

        // Menentukan posisi awal dan akhir untuk char1 dan char2
        let startPositionChar1 = CGPoint(x: frame.minX - char1.size.width / 2, y: char1.position.y)
        let centerPosition = CGPoint(x: frame.midX, y: char1.position.y)
        
        // Memindahkan char1 ke posisi awal
        char1.position = startPositionChar1
        
        // Membuat aksi untuk menggerakkan char1 ke tengah
        let moveToCenterChar1 = SKAction.move(to: centerPosition, duration: 3.0)
        
        // Menjalankan aksi pada char1
        char1.run(moveToCenterChar1)
        
        // Mengatur posisi char2 agar berada di samping kiri char1
        let distanceApart = CGFloat(-200.0)  // Jarak antara char1 dan char2
        let char2XPosition = centerPosition.x - char1.size.width / 2 - char2.size.width / 2 - distanceApart
        let char2YPosition = char2.position.y
        let char2FinalPosition = CGPoint(x: char2XPosition, y: char2YPosition)
        
        // Membuat aksi untuk menggerakkan char2 ke posisi samping kiri char1
        let moveToSideChar2 = SKAction.move(to: char2FinalPosition, duration: 3.0)
        
        // Menjalankan aksi pada char2 setelah char1 selesai bergerak ke tengah
        let delayAction = SKAction.wait(forDuration: 5.0)
        let sequenceChar2 = SKAction.sequence([delayAction, moveToSideChar2])
        char2.run(sequenceChar2)
        
        // Mengatur posisi char3 agar berada di samping kiri char2
           let distanceApart2 = CGFloat(-200.0)  // Jarak antara char2 dan char3
           let char3XPosition = char2FinalPosition.x - char2.size.width / 2 - char3.size.width / 2 - distanceApart2
           let char3YPosition = char3.position.y
           let char3FinalPosition = CGPoint(x: char3XPosition, y: char3YPosition)
           
           // Membuat aksi untuk menggerakkan char3 ke posisi samping kiri char2
           let moveToSideChar3 = SKAction.move(to: char3FinalPosition, duration: 3.0)
        
        // Menjalankan aksi pada char3 setelah char2 selesai bergerak ke posisi akhir
           let delayActionChar3 = SKAction.wait(forDuration: 9.0)
           let sequenceChar3 = SKAction.sequence([delayActionChar3, moveToSideChar3])
           char3.run(sequenceChar3)
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            var isTouchHandled = false
            let touchLocation = touch.location(in: self)
            
            for ompreng in omprengs {
                if ompreng.contains(touchLocation) && !omprengPressed {
                    let newOmpreng = ompreng.copy() as! SKSpriteNode
                    newOmpreng.zPosition = 1
                    newOmpreng.name = name
                    self.addChild(newOmpreng)
                    initialPositions[newOmpreng] = newOmpreng.position
                    updateOmprengPosition()
                    omprengs.append(newOmpreng)
                    omprengPressed = true
                }
            }
            
            
            for node in draggableNodes {
                if node.contains(touchLocation) {
                    activeTouches[touch] = node
                }
            }
            
            let scaleAction = SKAction.scale(by: 0, duration: 1)
            let movetoYAction = SKAction.moveTo(y: 50, duration: 0.5)
            let deleteAction = SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([movetoYAction,scaleAction])
            let sequence1 = SKAction.sequence([movetoYAction,scaleAction,deleteAction])
            
            if ((char1?.contains(touchLocation)) == true && omprengPressed) {
                for node in alreadyDragNodes {
                    node.run(sequence1)
                }
                
                if !omprengs.isEmpty {
                    let firstOmpreng = omprengs[0]
                    omprengs.remove(at: 0)
                    firstOmpreng.run(sequence)
                    omprengPressed = false
                    
                }
//                for ompreng in omprengs {
//                    ompreng.run(sequence)
//                    omprengPressed = false
//                }
                
            }
            
            
            
            // Jika sentuhan tidak ditemukan di draggableNodes, cek di tombol popup
            if !isTouchHandled {
                let touchedNode = atPoint(touchLocation)
                
                // Jika tombol OK ditekan, panggil fungsi untuk memulai gerakan karakter
                if touchedNode.name == "okButton" {
                    moveCharacterToCenter()
                    startCountdown()
                    touchedNode.parent?.removeFromParent() // Hapus popup setelah tombol OK ditekan
                    isTouchHandled = true
                }
                
                // Jika tombol Cancel ditekan, cukup hapus popup
                if touchedNode.name == "cancelButton" {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
                    isTouchHandled = true
                }
                
                // Jika tombol Play Again ditekan, dia akan kembali ke pertama
                if touchedNode.name == "playAgainButton" {
                    restartGame()
                    isTouchHandled = true
                }
                
                // Jika tombol Home ditekan, maka dia akan pergi ke levelViewController
                if touchedNode.name == "homeButton" {
                    // Hands On HomeButton
                    isTouchHandled = true
                    //ini mengunakan notification
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
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
            if let node = activeTouches[touch] {
                createDraggableNode(named: node.name!)
                alreadyDragNodes.append(node)
                activeTouches.removeValue(forKey: touch)
            }
            
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

