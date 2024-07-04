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
    
    var char1: SKSpriteNode?
    var char2: SKSpriteNode?
    var char3: SKSpriteNode?
    var btnPause: SKSpriteNode?

    // Inisiasi ompreng
    var ompreng: SKSpriteNode!
    var omprengPressed = false
    
    var gamePaused = false
    
    override func didMove(to view: SKView) {
        print("Hello")
        
        char1 = self.childNode(withName: "//char1") as? SKSpriteNode
        char2 = self.childNode(withName: "//char2") as? SKSpriteNode
        char3 = self.childNode(withName: "//char3") as? SKSpriteNode
        
        // Panggil fungsi untuk menampilkan popup
               showPopup()
        
        
        
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
        
        
        
        btnPause = SKSpriteNode(imageNamed: "resume.png")
        btnPause?.name = "btnPause"
        btnPause?.position = CGPoint(x: 580, y: 230)
        btnPause?.setScale(0.5)  // Mengubah skala node

        // Menyesuaikan ukuran fisik dengan skala yang diberikan
        btnPause?.size = CGSize(width: btnPause!.size.width * 0.6, height: btnPause!.size.height * 0.6)

        addChild(btnPause!)

//      btnPause = SKSpriteNode(imageNamed: "resume.png")
//      btnPause?.name = "btnPause"
//      btnPause?.position = CGPoint(x: 550, y: 200)
//      addChild(btnPause!)

        
        
    }
    
    // Fungsi untuk menampilkan popup
       func showPopup() {
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
    

    func createDraggableNode(named name: String) {
        if let nodeTemplate = self.childNode(withName: "//\(name)") as? SKSpriteNode {
            let node = nodeTemplate.copy() as! SKSpriteNode
            node.position = initialPositions[nodeTemplate] ?? nodeTemplate.position
            node.zPosition = nodeTemplate.zPosition
            node.name = name
            addChild(node)
            draggableNodes.append(node)
            initialPositions[node] = node.position
        }
    }
    
    func creatInitialNodes() {
        createDraggableNode(named: "ayam")
        createDraggableNode(named: "ikan")
        createDraggableNode(named: "telur")
        createDraggableNode(named: "semangka")
        createDraggableNode(named: "jeruk")
        createDraggableNode(named: "apel")
    }
    
    func updateOmprengPosition(){
        ompreng.run(SKAction.moveBy(x: 0, y: 170, duration: 0.5))
    }
    
    func startCountdown() {
        countdownAction = SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.run { [weak self] in
                self?.updateCountdown()
            }
        ])
        
        let repeatAction = SKAction.repeatForever(countdownAction)
        run(repeatAction, withKey: "countdown")
    }
    
    func pauseCount() {
        removeAction(forKey: "countdown")
        let remainingTime = countdownTime
        gamePaused = true
        print("Game Paused at \(remainingTime) seconds remaining")
        btnPause?.texture = SKTexture(imageNamed: "pause.png")
    }
    
    func continueCount() {
        startCountdown()
        gamePaused = false
        btnPause?.texture = SKTexture(imageNamed: "resume.png")
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
            var isTouchHandled = false
            let touchLocation = touch.location(in: self)
            
            if ompreng.contains(touchLocation) && !omprengPressed {
                updateOmprengPosition()
                omprengPressed = true
            }
            
            for node in draggableNodes {
                if node.contains(touchLocation) {
                    activeTouches[touch] = node
                }
            }
            
            // Jika sentuhan tidak ditemukan di draggableNodes, cek di tombol popup
            if !isTouchHandled {
                let touchedNode = atPoint(touchLocation)
                
                // Jika tombol OK ditekan, panggil fungsi untuk memulai gerakan karakter
                if touchedNode.name == "okButton" {
                    moveCharacterToCenter()
                    touchedNode.parent?.removeFromParent() // Hapus popup setelah tombol OK ditekan
                    isTouchHandled = true
                }
                
                // Jika tombol Cancel ditekan, cukup hapus popup
                if touchedNode.name == "cancelButton" {
                    touchedNode.parent?.removeFromParent()
                    isTouchHandled = true
                }
            }
            
            // Periksa apakah sentuhan terjadi di dalam btnPause
                    if let btnPause = btnPause, btnPause.contains(touchLocation) {
                        if gamePaused {
                            self.isPaused = false
                            continueCount()  // Jika game sedang di-pause, lanjutkan
                        } else {
                            pauseCount()  // Jika game sedang berjalan, pause
                            self.isPaused = true
                        }
                        return  // Keluar dari loop setelah menemukan sentuhan yang valid
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


// Add your code here
// testing branch otniel
