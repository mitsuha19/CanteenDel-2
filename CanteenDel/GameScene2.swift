import SpriteKit
import AudioToolbox

class GameScene2: SKScene {

    var draggableNodes = [SKSpriteNode]()
    var activeTouches = [UITouch: SKSpriteNode]()
    var alreadyDragNodes = [SKSpriteNode]()
    var initialPositions = [SKSpriteNode: CGPoint]()
    var positionInOmpreng = [SKSpriteNode: CGPoint]()
    
    var settingsButton: SKSpriteNode?
    var settingsPopup: SKSpriteNode?
    
    var reverseTimeEnabled = false
    var reverseDuration: TimeInterval = 5.0
    var timeLabel: SKLabelNode!
    
    var countdownTime: TimeInterval = 90
    var countdownAction: SKAction!
    
    var char1: SKSpriteNode?
    var char2: SKSpriteNode?
    var char3: SKSpriteNode?
    var char4: SKSpriteNode?
    var char5: SKSpriteNode?
    var char6: SKSpriteNode?
    var char7: SKSpriteNode?
    var char8: SKSpriteNode?
    var char9: SKSpriteNode?
    var char10: SKSpriteNode?
    
    
    
    // Tabel Target Mahasiswa
    var targetCount: Int = 5
    var currentTargetCount: Int = 0
    var coloredStarCount: Int = 0
    
    var targetLabel: SKLabelNode!
    var omprengs = [SKSpriteNode]()
    var omprengPressed = false
    
    var pesanans = [SKSpriteNode]()
    var pesanan: SKSpriteNode?
    let forbidden1xRange: ClosedRange<CGFloat> = -125 ... -40
    let forbidden1yRange: ClosedRange<CGFloat> = -150 ... -93
    let forbidden2xRange: ClosedRange<CGFloat> = -40...120
    let forbidden2yRange: ClosedRange<CGFloat> = -150 ... -93
    let forbidden3xRange: ClosedRange<CGFloat> = -125 ... -70
    let forbidden3yRange: ClosedRange<CGFloat> = -220 ... -160
    let forbidden4xRange: ClosedRange<CGFloat> = 70 ... 130
    let forbidden4yRange: ClosedRange<CGFloat> = -220 ... -160
    let forbidden5xRange: ClosedRange<CGFloat> = -60 ... 60
    let forbidden5yRange: ClosedRange<CGFloat> = -220 ... -130
    
    var isOrderCorrect1 = false;
    var isOrderCorrect2 = false;
    var isOrderCorrect3 = false;
    var isOrderCorrect4 = false;
    var isOrderCorrect5 = false;
    
    let price = [25000, 18000, 30000,15000, 25000, 18000, 30000, 15000, 25000,25000 ]
    var profitLabel: SKLabelNode!
    var score: Int = 0
    
    var isWinning = false
    var currentCharIndex = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        AudioManager.shared.stopBgMusic()
        AudioManager.shared.playBackgroundMusicScene()
        char1 = self.childNode(withName: "//char1") as? SKSpriteNode
        char2 = self.childNode(withName: "//char2") as? SKSpriteNode
        char3 = self.childNode(withName: "//char3") as? SKSpriteNode
        char4 = self.childNode(withName: "//char4") as? SKSpriteNode
        char5 = self.childNode(withName: "//char5") as? SKSpriteNode
        char6 = self.childNode(withName: "//char6") as? SKSpriteNode
        char7 = self.childNode(withName: "//char7") as? SKSpriteNode
        char8 = self.childNode(withName: "//char8") as? SKSpriteNode
        char9 = self.childNode(withName: "//char9") as? SKSpriteNode
        char10 = self.childNode(withName: "//char10") as? SKSpriteNode
        
        
        showStartPopup()
        
        timeLabel = SKLabelNode(text: "01:00")
        timeLabel.fontName = "Helvetica-bold"
        timeLabel.fontSize = 36
        timeLabel.fontColor = .black
        timeLabel.position = CGPoint(x: 0, y: 270)
        timeLabel.zPosition = 10
        addChild(timeLabel)
        
        
        targetLabel = SKLabelNode(text: " Target : \(currentTargetCount)")
        targetLabel.fontName = "Helvetica-Bold"
        targetLabel.fontSize = 25
        targetLabel.fontColor = .black
        targetLabel.position = CGPoint(x: -450, y: 270)
        targetLabel.zPosition = 10
        addChild(targetLabel)
        
        profitLabel = SKLabelNode(text: "Profit: Rp.\(score)")
        profitLabel.fontSize = 25
        profitLabel.fontName = "Helvetica-Bold"
        profitLabel.fontColor = .black
        profitLabel.position = CGPoint(x: 450, y: 270)
        profitLabel.zPosition = 10
        addChild(profitLabel)
        
        if let omprengNode = self.childNode(withName: "//ompreng") as? SKSpriteNode {
            omprengs.append(omprengNode)
            initialPositions[omprengNode] = omprengNode.position
        } else {
            print("Ompreng node not found")
        }
        
        let draggableNodeNames = ["ayam", "ikan", "telur", "semangka", "jeruk", "apel","nasi","selada", "brokoli"]
        for nodeName in draggableNodeNames {
            if let node = self.childNode(withName: "//\(nodeName)") as? SKSpriteNode {
                draggableNodes.append(node)
                initialPositions[node] = node.position
            }
        }
        
        //winningGame()
    }
    
    
    
    func resetOrder() {
        isOrderCorrect1 = false;
        isOrderCorrect2 = false;
        isOrderCorrect3 = false;
        isOrderCorrect4 = false;
        isOrderCorrect5 = false;
    }
    
    func showStartPopup() {
        let popupContainer = SKNode()
        popupContainer.name = "startPopup"
        
        let background = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 200))
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 100
        
        let outline = SKShapeNode(rectOf: CGSize(width: 300, height: 200))
        outline.position = CGPoint(x: frame.midX, y: frame.midY)
        outline.strokeColor = SKColor.black // Set the color of the outline
        outline.lineWidth = 2 // Set the thickness of the outline
        outline.zPosition = 101 // Ensure the outline is above the background
        
        let title = SKLabelNode(text: "Target")
        title.fontSize = 40
        title.fontName = "Helvetica-Bold"
        title.fontColor = SKColor.black
        title.position = CGPoint(x: 0, y: 40)
        
        let label = SKLabelNode(text: "10 Mahasiswa")
        label.fontSize = 20
        label.fontName = "Helvetica-Bold"
        label.fontColor = SKColor.black
        label.position = CGPoint(x: 0, y: -20)
        
        let okButton = SKLabelNode(text: "OK")
        okButton.fontColor = SKColor.blue
        okButton.fontSize = 20
        okButton.fontName = "Helvetica-Bold"
        okButton.name = "okButton"
        okButton.position = CGPoint(x: 50, y: -80)
        okButton.zPosition = 102
        
        let cancelButton = SKLabelNode(text: "Cancel")
        cancelButton.fontColor = SKColor.red
        cancelButton.fontSize = 20
        cancelButton.fontName = "Helvetica-Bold"
        cancelButton.name = "cancelButton"
        cancelButton.position = CGPoint(x: -50, y: -80)
        cancelButton.zPosition = 103
        
        popupContainer.addChild(background)
        background.addChild(label)
        background.addChild(okButton)
        background.addChild(cancelButton)
        background.addChild(outline)
        background.addChild(title)
        
        addChild(popupContainer)
    }

    func gameOverPopup() {
        let background = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 200))
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 100
        
        let outline = SKShapeNode(rectOf: CGSize(width: 300, height: 200))
        outline.position = CGPoint(x: frame.midX, y: frame.midY)
        outline.strokeColor = SKColor.black // Set the color of the outline
        outline.lineWidth = 2 // Set the thickness of the outline
        outline.zPosition = 101 // Ensure the outline is above the background
        
        let timeOverlabel = SKLabelNode(text: "Times Over")
        timeOverlabel.fontName = "Helvetica-Bold"
        timeOverlabel.fontSize = 20
        timeOverlabel.fontColor = SKColor.black
        timeOverlabel.position = CGPoint(x: 0, y: 70)
        
        let playAgainButton = SKLabelNode(text: "Play Again")
        playAgainButton.fontColor = SKColor.red
        playAgainButton.fontName = "Helvetica-Bold"
        playAgainButton.fontSize = 20
        playAgainButton.name = "playAgainButton"
        playAgainButton.position = CGPoint(x: -50, y: -80)
        playAgainButton.zPosition = 102
        
        let homeButton = SKLabelNode(text: "Home")
        homeButton.fontColor = SKColor.blue
        homeButton.fontName = "Helvetica-Bold"
        homeButton.fontSize = 20
        homeButton.name = "homeButton"
        homeButton.position = CGPoint(x: 50, y: -80)
        homeButton.zPosition = 103
        
        // Tambahkan bintang-bintang berdasarkan jumlah target yang tercapai
        let star1 = SKSpriteNode(imageNamed: coloredStarCount >= 1 ? "coloredStar" : "bintangKosong1")
        star1.size = CGSize(width: 30, height: 30)
        star1.position = CGPoint(x: -50, y: 30)
        
        let star2 = SKSpriteNode(imageNamed: coloredStarCount >= 2 ? "coloredStar" : "bintangKosong2")
        star2.size = CGSize(width: 60, height: 60)
        star2.position = CGPoint(x: 0, y: 30)
        
        let star3 = SKSpriteNode(imageNamed: coloredStarCount >= 3 ? "coloredStar" : "bintangKosong3")
        star3.size = CGSize(width: 30, height: 30)
        star3.position = CGPoint(x: 50, y: 30)
        
        let scoreButton = SKLabelNode(text: "Score: \(score)")
        scoreButton.fontColor = SKColor.black
        scoreButton.fontName = "Helvetica-Bold"
        scoreButton.fontSize = 20
        scoreButton.name = "scoreButton"
        scoreButton.position = CGPoint(x: 0, y: -45)
        
        background.addChild(timeOverlabel)
        background.addChild(playAgainButton)
        background.addChild(homeButton)
        background.addChild(star1)
        background.addChild(star2)
        background.addChild(star3)
        background.addChild(scoreButton)
        AudioManager.shared.playMusicLose()
        
        addChild(background)
    }

    func winningPopup() {
        let background = SKSpriteNode(color: SKColor.white, size: CGSize(width: 300, height: 200))
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = 100

        let winnerLabel = SKLabelNode(text: "Winner")
        winnerLabel.fontName = "Helvetica-bold"
        winnerLabel.fontSize = 20
        winnerLabel.fontColor = SKColor.black
        winnerLabel.position = CGPoint(x: 0, y: 70)

        let nextButton = SKLabelNode(text: "Next")
        nextButton.fontName = "Helvetica-bold"
        nextButton.fontColor = SKColor.blue
        nextButton.fontSize = 20
        nextButton.name = "nextButton"
        nextButton.position = CGPoint(x: 50, y: -80)

        let playAgainButton = SKLabelNode(text: "Play Again")
        playAgainButton.fontName = "Helvetica-bold"
        playAgainButton.fontColor = SKColor.red
        playAgainButton.fontSize = 20
        playAgainButton.name = "playAgainButton"
        playAgainButton.position = CGPoint(x: -50, y: -80)

        // Tambahkan bintang-bintang berdasarkan jumlah target yang tercapai
        let star1 = SKSpriteNode(imageNamed: coloredStarCount >= 1 ? "coloredStar" : "bintangKosong1")
        star1.size = CGSize(width: 30, height: 30)
        star1.position = CGPoint(x: -50, y: 30)

        let star2 = SKSpriteNode(imageNamed: coloredStarCount >= 2 ? "coloredStar" : "bintangKosong2")
        star2.size = CGSize(width: 60, height: 60)
        star2.position = CGPoint(x: 0, y: 30)

        let star3 = SKSpriteNode(imageNamed: coloredStarCount >= 3 ? "coloredStar" : "bintangKosong3")
        star3.size = CGSize(width: 30, height: 30)
        star3.position = CGPoint(x: 50, y: 30)

        let scoreButton = SKLabelNode(text: "Score: \(score)")
        scoreButton.fontName = "Helvetica-bold"
        scoreButton.fontColor = SKColor.black
        scoreButton.fontSize = 20
        scoreButton.name = "scoreButton"
        scoreButton.position = CGPoint(x: 0, y: -45)

        background.addChild(winnerLabel)
        background.addChild(playAgainButton)
        background.addChild(nextButton)
        background.addChild(star1)
        background.addChild(star2)
        background.addChild(star3)
        background.addChild(scoreButton)

        addChild(background)
    }

    func restartGame() {
        if let scene = SKScene(fileNamed: "GameScene2") {
            scene.scaleMode = .aspectFill
            
            let transition = SKTransition.fade(with: .white, duration: 1)
            view?.presentScene(scene, transition: transition)
        }
    }

    func createDraggableNode(named name: String) {
        if let nodeTemplate = self.childNode(withName: "//\(name)") as? SKSpriteNode {
            let node = nodeTemplate.copy() as! SKSpriteNode
            node.position = initialPositions[nodeTemplate] ?? nodeTemplate.position
            node.zPosition = 2
            node.name = name
            self.addChild(node)
            draggableNodes.append(node)
            initialPositions[node] = node.position
        }
    }
    
    func updateOmprengPosition() {
        for ompreng in omprengs {
            ompreng.run(SKAction.moveBy(x: 0, y: 170, duration: 0.5))
        }
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
            
            if isWinning == false {
                countdownTime -= 1
            }
            
            let minutes = Int(countdownTime) / 60
            let seconds = Int(countdownTime) % 60
            timeLabel.text = String(format: "%02d:%02d", minutes, seconds)
            
            if seconds == 0 {
                if isWinning == false {
                    gameOverPopup()
                    self.isPaused = true
                } else if isWinning == true {
                    winningPopup()
                    self.isPaused = true
                }
            }
        }
    }
    
    func showPesanan(for character: SKSpriteNode) {
        if pesanan == nil {
            pesanan = SKSpriteNode(imageNamed: "pesanan\(currentCharIndex + 1)")
            pesanan?.size = CGSize(width: 300, height: 225)
            pesanan?.position = CGPoint(x: 180, y: 150)
            pesanan?.zPosition = 10
            addChild(pesanan!)
            pesanans.append(pesanan!)
        }
    }
    
    func hidePesanan(){
        pesanan?.removeFromParent()
        pesanan = nil
    }
            
    func moveCharacterToCenter(characters: [SKSpriteNode], delayBetweenCharacters: TimeInterval = 1.0) {
        guard !characters.isEmpty else { return }

        let centerPosition = CGPoint(x: frame.midX, y: characters.first!.position.y)
        var previousPosition = centerPosition
        let distanceApart: CGFloat = 60.0

        for (index, char) in characters.enumerated() {
            let delayDuration = delayBetweenCharacters * Double(index)
            let moveToCenter = SKAction.move(to: previousPosition, duration: 3.0)
            let delayAction = SKAction.wait(forDuration: delayDuration)
            let sequence = SKAction.sequence([delayAction, moveToCenter])
            char.run(sequence) { [weak self] in
                self?.showPesanan(for: char)
            }

            previousPosition = CGPoint(x: previousPosition.x - char.size.width / 2 - distanceApart, y: char.position.y)
        }
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
                if node.contains(touchLocation) &&  omprengPressed{
                    activeTouches[touch] = node
                }
            }
            
            for node in alreadyDragNodes {
                if node.contains(touchLocation) {
                    activeTouches[touch] = node
                }
            }
            
            let scaleAction = SKAction.scale(by: 0, duration: 0.5)
            let movetoYAction = SKAction.moveTo(y: 50, duration: 0.5)
            let deleteAction = SKAction.removeFromParent()
            
            let sequence = SKAction.sequence([movetoYAction, scaleAction])
            let sequence1 = SKAction.sequence([movetoYAction, scaleAction, deleteAction])
            
            let characters = [char1, char2, char3, char4, char5, char6, char7, char8, char9, char10].compactMap { $0 }

            if currentCharIndex < characters.count && characters[currentCharIndex].contains(touchLocation) && omprengPressed {
                
                switch currentCharIndex {
                case 0:
                    for node in alreadyDragNodes {
                        if node.name == "selada" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ayam" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "semangka" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "telur" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 1:
                    for node in alreadyDragNodes {
                        if node.name == "brokoli" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ikan" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "jeruk" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "apel" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 2:
                    for node in alreadyDragNodes {
                        if node.name == "ikan" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ayam" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "selada" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "telur" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 3:
                    for node in alreadyDragNodes {
                        if node.name == "telur" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "brokoli" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
//                        if node.name == "jeruk" {
//                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
//                                isOrderCorrect3 = true
//                            } else {
//                                isOrderCorrect3 = false
//                            }
//                        }
                        isOrderCorrect3 = true
                        if node.name == "apel" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 4:
                    for node in alreadyDragNodes {
                        if node.name == "selada" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ayam" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "semangka" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "telur" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                        
                        
                    }
                case 5:
                    for node in alreadyDragNodes {
                        if node.name == "brokoli" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ikan" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "jeruk" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "apel" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 6:
                    for node in alreadyDragNodes {
                        if node.name == "ikan" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ayam" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "selada" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "telur" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 7:
                    for node in alreadyDragNodes {
                        if node.name == "telur" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "brokoli" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
//                        if node.name == "jeruk" {
//                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
//                                isOrderCorrect3 = true
//                            } else {
//                                isOrderCorrect3 = false
//                            }
//                        }
                        isOrderCorrect3 = true
                        if node.name == "apel" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                case 8:
                    for node in alreadyDragNodes {
                        if node.name == "selada" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ayam" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "semangka" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "telur" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                    }
                    
                case 9:
                    for node in alreadyDragNodes {
                        if node.name == "selada" {
                            if forbidden1xRange.contains(node.position.x) && forbidden1yRange.contains(node.position.y) {
                                isOrderCorrect1 = true
                            } else {
                                isOrderCorrect1 = false
                            }
                        }
                        if node.name == "ayam" {
                            if forbidden2xRange.contains(node.position.x) && forbidden2yRange.contains(node.position.y) {
                                isOrderCorrect2 = true
                            } else {
                                isOrderCorrect2 = false
                            }
                        }
                        if node.name == "semangka" {
                            if forbidden3xRange.contains(node.position.x) && forbidden3yRange.contains(node.position.y) {
                                isOrderCorrect3 = true
                            } else {
                                isOrderCorrect3 = false
                            }
                        }
                        if node.name == "telur" {
                            if forbidden4xRange.contains(node.position.x) && forbidden4yRange.contains(node.position.y) {
                                isOrderCorrect4 = true
                            } else {
                                isOrderCorrect4 = false
                            }
                        }
                        if node.name == "nasi" {
                            if forbidden5xRange.contains(node.position.x) && forbidden5yRange.contains(node.position.y) {
                                isOrderCorrect5 = true
                            } else {
                                isOrderCorrect5 = false
                            }
                        }
                        
                    }
                    
                default:
                    print()
                }
                
                if isOrderCorrect1 && isOrderCorrect2 && isOrderCorrect3 && isOrderCorrect4 && isOrderCorrect5{
                    
                    let scoreValue = price[currentCharIndex]
                    score += scoreValue
                    
                    profitLabel.text = "Profit: Rp.\(score)"
                    
                    let scoreText = "+ \(scoreValue)"
                    let scoreLabel = SKLabelNode(text: scoreText)
                    scoreLabel.fontSize = 20
                    scoreLabel.fontColor = SKColor.red
                    scoreLabel.fontName = "Helvetica-Bold"
                    scoreLabel.position = CGPoint(x: 0, y: 0)
                    self.addChild(scoreLabel)
                    
                    AudioManager.shared.playMusicOrederFinished()
                    
                    let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.3)
                    let waitAction = SKAction.wait(forDuration: 1)
                    let scaleDownAction = SKAction.scale(to: 0, duration: 0.3)
                    let removeAction = SKAction.removeFromParent()
                    let sequenceLabel = SKAction.sequence([scaleUpAction, waitAction, scaleDownAction, removeAction])
                    
                    scoreLabel.run(sequenceLabel)
                    
                    resetOrder()
                    
                    for node in alreadyDragNodes {
                        node.run(sequence1)
                    }
                    
                    hidePesanan()
                    
                    if !omprengs.isEmpty {
                        let firstOmpreng = omprengs[0]
                        omprengs.remove(at: 0)
                        firstOmpreng.run(sequence)
                        omprengPressed = false
                        
                        // Move current character to the right after receiving ompreng
                        let moveRight = SKAction.moveBy(x: 750, y: 0, duration: 5.0)
                        
                        // Delay before moving the current character to the right
                        let delayAction = SKAction.wait(forDuration: 1.5) // Ubah durasi jeda sesuai kebutuhan
                        
                        characters[currentCharIndex].run(SKAction.sequence([delayAction, moveRight]))
                        
                        // Move next character to the center with delay
                           if currentCharIndex + 1 < characters.count {
                               moveCharacterToCenter(characters: Array(characters[(currentCharIndex + 1)...]), delayBetweenCharacters: 3.0)
                           }

                           currentCharIndex += 1
                        // Tambahkan target setelah ompreng diberikan
                              updateTargetCount()
                    }
                } else {
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
            }
            
            if !isTouchHandled {
                let touchedNode = atPoint(touchLocation)
                
                if touchedNode.name == "okButton" {
                    if let popup = self.childNode(withName: "startPopup") {
                        popup.removeFromParent()
                    }
                    
                    if let char1 = char1, let char2 = char2, let char3 = char3 , let char4 = char4 , let char5 = char5, let char6 = char6, let char7 = char7, let char8 = char8, let char9 = char9, let char10 = char10{
                        let characters = [char1, char2, char3, char4, char5,char6,char7,char8,char9,char10]
                        moveCharacterToCenter(characters: characters)
                    }
                    
                    startCountdown()
                    isTouchHandled = true
                }
                
                if touchedNode.name == "cancelButton" {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
                    isTouchHandled = true
                    AudioManager.shared.stopBgMusicScene()
                    AudioManager.shared.playBackgroundMusic()
                }
                
                if touchedNode.name == "playAgainButton" {
                    restartGame()
                    isTouchHandled = true
                }
                
                if touchedNode.name == "homeButton" {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GoToLevelScreen"), object: nil)
                    isTouchHandled = true
                    AudioManager.shared.stopBgMusicScene()
                    AudioManager.shared.playBackgroundMusic()
                }
                
                if touchedNode.name == "nextButton" {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "GoToComingSoon"), object: nil)
                    isTouchHandled = true
                
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
                    let dropLocation = node.position
                    // daerah ompreng
                    let forbiddenXRange = -125...125
                    let forbiddenYRange = -198 ... -93
                    // daerah tempat sampah
                    let forbiddenxSampahRange = 320 ... 560
                    let forbiddenySampahRange = -320 ... -240
                    if forbiddenXRange.contains(Int(dropLocation.x)) && forbiddenYRange.contains(Int(dropLocation.y)) {
                        if draggableNodes.contains(node) {
                            // Jika drop di area yang diperbolehkan, buat salinan node
                            createDraggableNode(named: node.name!)
                            if let index = draggableNodes.firstIndex(of: node) {
                                draggableNodes.remove(at: index)
                            }
                            alreadyDragNodes.append(node)
                            positionInOmpreng[node] = node.position
                        } else if alreadyDragNodes.contains(node) {
                            // Kembalikan node ke posisi awal jika already dragged node
                            node.position = positionInOmpreng[node] ?? CGPoint.zero
                        }
                    } else {
                        // Jika drop di luar area yang diperbolehkan
                        if draggableNodes.contains(node) {
                            // Kembalikan node ke posisi awal jika draggable node
                            node.position = initialPositions[node] ?? CGPoint.zero
                        } else if alreadyDragNodes.contains(node) {
                            // Kembalikan node ke posisi awal jika already dragged node
                            node.position = positionInOmpreng[node] ?? CGPoint.zero
                        }
                    }
                    
                    if forbiddenxSampahRange.contains(Int(dropLocation.x)) && forbiddenySampahRange.contains(Int(dropLocation.y)) {
                        if alreadyDragNodes.contains(node) {
                            node.removeFromParent()
                        }
                    }
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
        winningGame()
        
        if reverseTimeEnabled {
            for (node, initialPosition) in initialPositions {
                node.position = CGPoint(
                    x: node.position.x - (node.position.x - initialPosition.x) * 0.1,
                    y: node.position.y - (node.position.y - initialPosition.y) * 0.1
                )
            }
        }
    }
    
    func updateTargetCount() {
        currentTargetCount += 1
        targetLabel.text = " Target : \(currentTargetCount)"

        if currentTargetCount >= 5 {
            coloredStarCount = 1
        }
        if currentTargetCount >= 7 {
            coloredStarCount = 2
        }
        if currentTargetCount >= 10{
            coloredStarCount = 3
        }
    }
    
    func winningGame () {
        if currentCharIndex > 9 {
            isWinning = true
            winningPopup()
        }
    }
}
