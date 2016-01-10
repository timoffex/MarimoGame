//
//  Pickup.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/6/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit


class Pickup: SKSpriteNode {
    init () {
        super.init(texture: nil, color: NSColor(red: 0.2, green: 0, blue: 1, alpha: 1), size: CGSize(width: 10, height: 10))
        
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        physicsBody?.categoryBitMask = gCat_PICKUP
        physicsBody?.contactTestBitMask = gCat_PLAYER
        physicsBody?.affectedByGravity = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}