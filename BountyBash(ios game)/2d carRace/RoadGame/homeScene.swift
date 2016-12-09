//
//  homeScene.swift
//  RoadGame
//
//  Created by uics7 on 4/21/15.
//  Copyright (c) 2015 uics7. All rights reserved.
//

import Foundation
import SpriteKit

class homeScene : SKScene , SKPhysicsContactDelegate {
    

    override func didMoveToView(view: SKView) {
    

        println("in the home page")
        backgroundColor = SKColor.blackColor()
        var label:SKLabelNode = SKLabelNode(fontNamed: "Code")
        label.text = "Bounty Bash!"
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 40
        label.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 140)
        self.addChild(label)
        
        // add startGame button
        let logoGameButton = SKSpriteNode(imageNamed: "logoCar.png")
        logoGameButton.position = CGPointMake(size.width/2, size.height/2 + 250)
        logoGameButton.name = "logogame"
        addChild(logoGameButton)


        // add startGame button
        let startGameButton = SKSpriteNode(imageNamed: "gameStart.jpg")
        startGameButton.position = CGPointMake(size.width/2, size.height/2)
        startGameButton.name = "startgame"
        addChild(startGameButton)
        
        // add instructions scenes and highscore list

        var instructionLabel:SKLabelNode = SKLabelNode(fontNamed: "Arial Bold")
        instructionLabel.text = "INSTRUCTIONS"
        instructionLabel.fontColor = SKColor.redColor()
        instructionLabel.fontSize = 15
        instructionLabel.name  = "instruction"
        instructionLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 150)
        self.addChild(instructionLabel)

        var sceneLabel:SKLabelNode = SKLabelNode(fontNamed: "Arial Bold")
        sceneLabel.text = "SELECT SCENE"
        sceneLabel.fontColor = SKColor.redColor()
        sceneLabel.fontSize = 15
        sceneLabel.name = "scene"
        sceneLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 190)
        self.addChild(sceneLabel)

        
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    
    
        
        /* Called when a touch begins */
        
        var touch : UITouch
        for touch: AnyObject in touches {
            let location :CGPoint = touch.locationInNode(self)
            let node : SKNode = self.nodeAtPoint(location)
            if (node.name == "startgame"){
                let gamescene = GameScene(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the game scene")
                
            }
            if (node.name == "instruction"){
                let gamescene = instructionScene(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the instruction scene")
                
                
                
            }
            
            if (node.name == "scene"){
                let gamescene = Scene(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the  scene")
                
                
                
            }



        }
    }}
