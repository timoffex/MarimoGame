//
//  Monster.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/4/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Monster: SKSpriteNode, UpdateReceiver, ContactReceiver {
    
    private weak var target: SKNode?
    
    
    init(width: CGFloat, height: CGFloat) {
        super.init(texture: nil, color: NSColor.whiteColor(), size: CGSize(width: width, height: height))
        
        physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: width, height: height))
        
        physicsBody?.categoryBitMask = gCat_MONSTER
    }
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.categoryBitMask = gCat_MONSTER
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: CFTimeInterval) { }
    func didBeginContact(withOther: SKNode) { }
    func didEndContact(withOther: SKNode) { }
}