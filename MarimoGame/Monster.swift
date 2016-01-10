//
//  Monster.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/4/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Monster: SKSpriteNode {
    
    private weak var target: SKNode?
    
    
    init() {
        let width = 100
        let height = 100
        
        super.init(texture: nil, color: NSColor(red: 1, green: 0, blue: 0, alpha: 1), size: CGSize(width: width, height: height))
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: height, height: width))
        physicsBody?.categoryBitMask = gCat_MONSTER
        physicsBody?.contactTestBitMask = gCat_PICKUP
    }
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = gCat_MONSTER
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: CFTimeInterval) {
        
        if target == nil {
            var minDist = Double.infinity
            var minNode: SKNode?
            scene?.enumerateChildNodesWithName("//pickup") { (c, _) in
                let dist = distance(self.position, c.position)
                if dist < minDist {
                    minDist = dist
                    minNode = c
                }
            }
            
            target = minNode
            
            if let target = target {
                runAction(SKAction.moveTo(target.position, duration: minDist/100))
            } else if let player = gPlayer {
                runAction(SKAction.moveTo(player.position, duration: 3))
            }
        }
    }
}