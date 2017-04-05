//
//  GameScene.swift
//  Game2
//
//  Created by Viet Anh on 3/30/17.
//  Copyright © 2017 Viet Anh. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
class GameScene: SKScene {
    var ball:SKSpriteNode!
    var enemy:SKSpriteNode!
    var main:SKSpriteNode!
    var score = [Int]()
    var toplbl = SKLabelNode()
    var botlbl = SKLabelNode()
    var touched1: Bool = false
    var touched2: Bool = false
    var player: AVAudioPlayer?
   
    func playSong(){
        let url = Bundle.main.url(forResource: "Fade", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    
    }

    override func didMove(to view: SKView) {
        playSong()
        //add cac doi tuong
        toplbl = self.childNode(withName: "toplbl") as! SKLabelNode
        botlbl = self.childNode(withName: "botlbl") as! SKLabelNode
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 100
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 100
        //lam bong chuyen dong va quy dinh toc do
        //        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        let border = SKPhysicsBody(edgeLoopFrom : self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
        //lam bong chuyen dong va va vao cac canh border ?
        startGame()
    }
    func startGame(){
        score = [0,0]
        toplbl.text = "\(score[0])"
        botlbl.text = "\(score[1])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 18 , dy: 18))
    }
    func addScore(playWhoWon : SKSpriteNode) {
        ball.position = CGPoint(x:0 , y: 0)
        // cho vao 1 lan tang them 1 lan
        //        ball.physicsBody?.applyImpulse(CGVector(dx: 5 , dy: 5))
        if playWhoWon == main {
            score[0] += 1
            //            ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
        }else if playWhoWon == enemy{
            score[1] += 1
            //            ball.physicsBody?.applyImpulse(CGVector(dx: -5, dy: -5))
        }
        toplbl.text = "\(score[0])"
        botlbl.text = "\(score[1])"
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.y > 0 {
                touched1 = true
                enemy.run(SKAction.moveTo(x: location.x, duration: 0.01))
//                enemy.run(SKAction.moveTo(x: location.y, duration: 0.2))
            }
            if location.y < 0 {
                touched2 = true
                main.run(SKAction.moveTo(x: location.x, duration: 0.01))
//                main.run(SKAction.moveTo(x: location.y, duration: 0.2))
                
                
            }
        }
        
        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if location.y > 0 {
                touched1 = true
                enemy.run(SKAction.moveTo(x: location.x, duration: 0.05))
//                enemy.run(SKAction.moveTo(x: location.y, duration: 0.2))
            }
            if location.y < 0 {
                touched2 = true
                main.run(SKAction.moveTo(x: location.x, duration: 0.05))
//                main.run(SKAction.moveTo(x: location.y, duration: 0.2))
                
            }
            
        }
        //        for touch in touches {
        //            let location = touch.location(in: self)
        //            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        //            main.run(SKAction.moveTo(y: location.y, duration: 0.2))
        //        }
        //        for touch1 in touches {
        //            let location1 = touch1.location(in: self)
        //            enemy.run(SKAction.moveTo(x: location1.x, duration: 0.2))
        //            enemy.run(SKAction.moveTo(y: location1.y, duration: 0.2))
        //        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched1 = false
        touched2 = false
    }
    override func update(_ currentTime: TimeInterval) {
        
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playWhoWon: main)
          
        }
    }
    
}
