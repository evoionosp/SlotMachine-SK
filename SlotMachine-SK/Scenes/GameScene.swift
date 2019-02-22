//
//  GameScene.swift
//  SlotMachine-SK
//
//  Created by Shubh Patel on 2019-02-21.
//  Copyright © 2019 Shubh Patel. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var score = Int(0)
    var credit = Int(10000)
    var winning = Int(0)
    var jackpot = Int(0)
    var bet = Int(0)
    
    var jackpotLabel = SKLabelNode()
    var creditLabel = SKLabelNode()
    var winningLabel = SKLabelNode()
    var betLabel = SKLabelNode()
    
    var bet1Btn = SKSpriteNode()
    var bet10Btn = SKSpriteNode()
    var bet100Btn = SKSpriteNode()
    var betMaxBtn = SKSpriteNode()
    var betBtns = SKNode()
    var spinBtn = SKSpriteNode()
    
    var spinOne = SKSpriteNode()
    var spinTwo = SKSpriteNode()
    var spinThree = SKSpriteNode()

    
    
    override func sceneDidLoad() {
        
    }
    
    override func didMove(to view: SKView) {
        setupScene()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            let location = touch.location(in: self)
            if spinBtn.contains(location){
                if bet > 0 {
                    resetSpin()
                    spinAll()
                }
            }
            if bet1Btn.contains(location){
                if credit >= 1 {
                    credit -= 1
                    bet += 1
                }
            }
            if bet10Btn.contains(location){
                if credit >= 10 {
                    credit -= 10
                    bet += 10
                }
            }
            if bet100Btn.contains(location){
                if credit >= 100 {
                    credit -= 100
                    bet += 100
                }
            }
            if betMaxBtn.contains(location){
                bet += credit
                credit = 0
                
            }
            
            updateLabels()
            
        }
    }
    
    
    func resetScene(){
        self.removeAllChildren()
        self.removeAllActions()
        score = Int(0)
        credit = Int(10000)
        winning = Int(0)
        jackpot = Int(0)
        bet = Int(0)
        setupScene()
    }
    
    func updateLabels() {
        jackpotLabel.text = "\(jackpot)"
        winningLabel.text = "\(winning)"
        creditLabel.text = "\(credit)"
        betLabel.text = "\(bet)"
        
    }
    
    func spinAll() {
        let rnd1 = Int.random(in: 0...7)
        spinOne.position.y = spinOne.position.y - CGFloat(rnd1 * 69)
        
        let rnd2 = Int.random(in: 0...7)
        spinTwo.position.y = spinTwo.position.y - CGFloat(rnd2 * 69)
        
        let rnd3 = Int.random(in: 0...7)
        spinThree.position.y = spinThree.position.y - CGFloat(rnd3 * 69)
        
        //print("\(rnd1)   \(rnd2)   \(rnd3)")
        
        checkWin(a: rnd1, b: rnd2, c: rnd3)
        
    }
    
    func checkWin(a: Int, b: Int, c: Int){
        //animateNodes([spinOne, spinTwo, spinThree])
        if a == b && b == c {
            print("Jackpot")
            
        }
        else  if a == b || b == c || a == c {
            print("2 Same")
        } else {
            print("None")
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
    func setupScene(){
        self.backgroundColor = SKColor(red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background_1")
        background.anchorPoint = CGPoint.init(x: 0, y: 0)
        background.position = CGPoint(x:0, y:0)
        background.zPosition = ZPositions.background
        background.name = "background"
        background.size = (self.view?.bounds.size)!
        self.addChild(background)
        
        jackpotLabel = createLabel(x: self.frame.width/2, y: self.frame.height - 105)
        self.addChild(jackpotLabel)
        
        creditLabel = createLabel(x: self.frame.width/2 - 90, y: 170)
        self.addChild(creditLabel)
        
        betLabel = createLabel(x: self.frame.width/2, y: 170)
        self.addChild(betLabel)
        
        winningLabel = createLabel(x: self.frame.width/2 + 90, y: 170)
        self.addChild(winningLabel)
        
        
        
        betBtns = createBetButtons()
        self.addChild(betBtns)
        
        spinOne = SKSpriteNode(imageNamed: "spin2")
        spinOne.position = CGPoint(x: UIScreen.main.bounds.width/2 - 74, y: UIScreen.main.bounds.height/2 + 414)
        spinOne.zPosition = ZPositions.spin
        self.addChild(spinOne)
        
        print("Height \(spinOne.frame.height) Width \(spinOne.frame.width)")
        
        spinTwo = SKSpriteNode(imageNamed: "spin2")
        spinTwo.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 + 414)
        spinTwo.zPosition = ZPositions.spin
        self.addChild(spinTwo)
        
        spinThree = SKSpriteNode(imageNamed: "spin2")
        spinThree.position = CGPoint(x: UIScreen.main.bounds.width/2 + 74, y: UIScreen.main.bounds.height/2 + 414)
        spinThree.zPosition = ZPositions.spin
        self.addChild(spinThree)
        
       
        updateLabels()
    }
    
    func increaseScore() {
        print("Height: \(UIScreen.main.bounds.height), Width: \(UIScreen.main.bounds.width)")
        score += 1
        jackpotLabel.text = "\(score)"
        if score == -1{
            jackpotLabel.text = "0"
        }
        
    }
    
    func resetSpin() {
        spinOne.position = CGPoint(x: UIScreen.main.bounds.width/2 - 74, y: UIScreen.main.bounds.height/2 + 414)
        spinTwo.position = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 + 414)
        spinThree.position = CGPoint(x: UIScreen.main.bounds.width/2 + 74, y: UIScreen.main.bounds.height/2 + 414)
    }
    
    
    func gameOver() {
        print("Game Over !")
        UserDefaults.standard.set(score, forKey: "RecentScore")
        if score > UserDefaults.standard.integer(forKey: "HighScore"){
            UserDefaults.standard.set(score, forKey: "HighScore")
        }
    }
    
    
    
    func createBetButtons() -> SKNode {
        
        let betBtns = SKNode()
        betBtns.name = "betButtons"
        
        bet1Btn = SKSpriteNode(imageNamed: "bet1Button")
        bet1Btn.size = CGSize(width:55, height:50)
        bet1Btn.position = CGPoint(x: self.frame.width - 70, y: 90)
        bet1Btn.zPosition = ZPositions.buttons
        betBtns.addChild(bet1Btn)
        
        bet10Btn = SKSpriteNode(imageNamed: "bet10Button")
        bet10Btn.size = CGSize(width:55, height:50)
        bet10Btn.position = CGPoint(x: self.frame.width - (30 + 100), y: 90)
        bet10Btn.zPosition = ZPositions.buttons
        betBtns.addChild(bet10Btn)
        
        bet100Btn = SKSpriteNode(imageNamed: "bet100Button")
        bet100Btn.size = CGSize(width:55, height:50)
        bet100Btn.position = CGPoint(x: self.frame.width - (30 + 2*40 + 80), y: 90)
        bet100Btn.zPosition = ZPositions.buttons
        betBtns.addChild(bet100Btn)
        
        betMaxBtn = SKSpriteNode(imageNamed: "betMaxButton")
        betMaxBtn.size = CGSize(width:55, height:50)
        betMaxBtn.position = CGPoint(x: self.frame.width - (30 + 3*40 + 100), y: 90)
        betMaxBtn.zPosition = ZPositions.buttons
        betBtns.addChild(betMaxBtn)
        
        spinBtn = SKSpriteNode(imageNamed: "spinButton")
        spinBtn.size = CGSize(width:55, height:50)
        spinBtn.position = CGPoint(x: self.frame.width - (30 + 4*40 + 120), y: 90)
        spinBtn.zPosition = ZPositions.buttons
        betBtns.addChild(spinBtn)
        
        return betBtns
        
        
    }
    

    func createLabel(x: CGFloat, y: CGFloat) -> SKLabelNode {
        let label = SKLabelNode()
        label.position = CGPoint(x: x, y: y)
        label.text = "0"
        label.zPosition = ZPositions.label
        label.fontSize = 30
        label.fontColor = UIColor.white
        label.fontName = "HelveticaNeue-Bold"
        return label
    }
    
    
    func createHighscoreLabel() -> SKLabelNode {
        let highscoreLbl = SKLabelNode()
        highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 22)
        if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
            highscoreLbl.text = "Highest Score: \(highestScore)"
        } else {
            highscoreLbl.text = "Highest Score: 0"
        }
        highscoreLbl.zPosition = ZPositions.background
        highscoreLbl.fontSize = 15
        highscoreLbl.fontName = "Helvetica-Bold"
        return highscoreLbl
    }
    
    func animateNodes(_ nodes: [SKNode]) {
        for (index, node) in nodes.enumerated() {
            node.run(.sequence([
                .wait(forDuration: TimeInterval(index) * 0.2),
                .sequence([
                    .scale(to: 1.5, duration: 0.3),
                    .scale(to: 1, duration: 0.3),
                    .wait(forDuration: 2)
                    ])
                ]))
        }
    }
    

    
}



