//
//  player.swift
//  RoadGame
//
//  Created by uics7 on 4/22/15.
//  Copyright (c) 2015 uics7. All rights reserved.
//

import Foundation
import SpriteKit

class Player {
    
    var player: SKSpriteNode
    var emit = false
    var emitFrameCount = 0
    var maxEmitFrameCount = 1000
    var particles: SKEmitterNode
    
    
    init(player: SKSpriteNode, particles: SKEmitterNode){
        self.player = player
        self.particles = particles
    }
}