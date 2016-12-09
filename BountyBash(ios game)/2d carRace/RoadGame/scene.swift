//
//  scene.swift
//  RoadGame
//
//  Created by uics7 on 5/7/15.
//  Copyright (c) 2015 uics7. All rights reserved.
//

import Foundation
import SpriteKit

class Scene : SKScene , SKPhysicsContactDelegate {
    
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.blackColor()
        
        var label1:SKLabelNode = SKLabelNode(fontNamed: "Calibri Bold")
        label1.text = "SELECT SCENE"
        label1.fontColor = SKColor.whiteColor()
        label1.fontSize = 30
        label1.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 160)
        self.addChild(label1)
        
        var label2:SKLabelNode = SKLabelNode(fontNamed: "Calibri Bold")
        label2.text = "SPACE"
        label2.fontColor = SKColor.whiteColor()
        label2.fontSize = 20
        label2.name = "space"
        label2.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + 80)
        self.addChild(label2)
        
        var space = SKSpriteNode(imageNamed: "spaceShuttle.png")
        space.position = CGPointMake(self.frame.size.width/2 - 70, self.frame.size.height/2 + 80)
        space.name = "space"
        addChild(space)

        backgroundColor = SKColor.blackColor()
        var label3:SKLabelNode = SKLabelNode(fontNamed: "Calibri Bold")
        label3.text = "GROUND"
        label3.fontColor = SKColor.whiteColor()
        label3.fontSize = 20
        label3.name = "ground"
        label3.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 )
        self.addChild(label3)

        var ground = SKSpriteNode(imageNamed: "car.png")
        ground.position = CGPointMake(self.frame.size.width/2 - 70, self.frame.size.height/2 )
        ground.name = "ground"
        addChild(ground)
        
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
            
            if (node.name == "ground"){
                let gamescene = GameScene(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.1)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the home scene")
                
            }
            
            if (node.name == "space"){
                let gamescene = GameScene2(size : size)
                gamescene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(0.1)
                view?.presentScene(gamescene, transition: transitionType)
                println("in the home scene")
                
            }


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

