//
//  instructionScene.swift
//  RoadGame
//
//  Created by uics7 on 5/7/15.
//  Copyright (c) 2015 uics7. All rights reserved.
//

import Foundation
import SpriteKit

class instructionScene : SKScene , SKPhysicsContactDelegate {
    
    
    override func didMoveToView(view: SKView) {
        println("in the home")
        backgroundColor = SKColor.blackColor()
        var label:SKLabelNode = SKLabelNode(fontNamed: "Code Bold")
        label.text = "INSTRUCTIONS!"
        label.fontColor = SKColor.whiteColor()
        label.fontSize = 30
        label.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 160)
        self.addChild(label)
        
        var label1:SKLabelNode = SKLabelNode(fontNamed: "Code")
        label1.text = "* Touch and hold the car to move "
        label1.fontColor = SKColor.whiteColor()
        label1.fontSize = 15
        label1.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 80)
        self.addChild(label1)
        
        var label2:SKLabelNode = SKLabelNode(fontNamed: "Code")
        label2.text = " * Collect coins to earn more points"
        label2.fontColor = SKColor.whiteColor()
        label2.fontSize = 15
        label2.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 40)
        self.addChild(label2)
        
        var bounty1 = SKSpriteNode(imageNamed: "bounty1.png")
        bounty1.position = CGPointMake(self.frame.size.width/2 - 20, self.frame.size.height/2)
        addChild(bounty1)
        
        var bounty2 = SKSpriteNode(imageNamed: "starbounty.png")
        bounty2.position = CGPointMake(self.frame.size.width/2 + 20, self.frame.size.height/2)
        addChild(bounty2)
        
        
        var label3:SKLabelNode = SKLabelNode(fontNamed: "Code")
        label3.text = " * Collect starBounty to run through enemies"
        label3.fontColor = SKColor.whiteColor()
        label3.fontSize = 15
        label3.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 40)
        self.addChild(label3)
        
        var label4:SKLabelNode = SKLabelNode(fontNamed: "Code")
        label4.text = " * Choose from scene for different adventures"
        label4.fontColor = SKColor.whiteColor()
        label4.fontSize = 15
        label4.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 80)
        self.addChild(label4)
        
        // exit button
        var exit = SKSpriteNode(imageNamed: "exit.jpg")
        exit.position = CGPointMake(self.frame.size.width/2 , self.frame.size.height/2 - 160)
        exit.name = "exit"
        addChild(exit)
        


    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        
        
        /* Called when a touch begins */
        
        var touch : UITouch
        for touch: AnyObject in touches {
            let location :CGPoint = touch.locationInNode(self)
            let node : SKNode = self.nodeAtPoint(location)
            if (node.name == "exit"){
                let gamescene = homeScene(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.3)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the home scene")
                
            }

        }
}

}














