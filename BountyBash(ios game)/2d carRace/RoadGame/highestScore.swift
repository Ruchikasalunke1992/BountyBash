//
//  highestScore.swift
//  RoadGame
//
//  Created by uics7 on 5/6/15.
//  Copyright (c) 2015 uics7. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class highestScore : SKScene , SKPhysicsContactDelegate {
    var musicPlayer:AVAudioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        
        playMusic()
        
        let Particles = SKEmitterNode(fileNamed: "magicMyParticle.sks")
        self.addChild(Particles)
        backgroundColor = SKColor.blackColor()
        var label:SKLabelNode = SKLabelNode(fontNamed: "Calibari")
        label.text = "Congratulations"
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 30
        label.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 50)
        self.addChild(label)
        
        var label1:SKLabelNode = SKLabelNode(fontNamed: "Calibari")
        label1.text = " You got Highestscore"
        label1.fontColor = SKColor.whiteColor()
        label1.fontSize = 30
        label1.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(label1)

        
        
        
        // add startGame button
        let exitGameButton = SKSpriteNode(imageNamed: "exit.jpg")
        exitGameButton.position = CGPointMake(size.width/2, size.height/2 - 160)
        exitGameButton.name = "exitgame"
        addChild(exitGameButton)
        
        
    }
    
    func playMusic() {
        
        var bgMusicURL:NSURL = NSBundle.mainBundle().URLForResource("applause", withExtension: "wav")!
        musicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        musicPlayer.numberOfLoops = -1
        musicPlayer.prepareToPlay()
        musicPlayer.play()
       
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        
        /* Called when a touch begins */
        
        var touch : UITouch
        for touch: AnyObject in touches {
            let location :CGPoint = touch.locationInNode(self)
            let node : SKNode = self.nodeAtPoint(location)
            if (node.name == "exitgame"){
                let gamescene = homeScene(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the home scene")
                
                
                
            }
            
        }
    }}
