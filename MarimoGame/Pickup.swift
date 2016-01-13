//
//  Pickup.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/6/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit


class Pickup: SKSpriteNode, ContactReceiver, UpdateReceiver {
    
    let hasUpdate: Bool
    let hasContact: Bool
    
    init(circleOfRadius r: CGFloat, hasUpdate up: Bool, hasContact cont: Bool) {
        hasUpdate = up
        hasContact = cont
        
        super.init(texture: nil, color: NSColor.whiteColor(), size: CGSize(width:r, height:r))
        
        physicsBody = SKPhysicsBody(circleOfRadius: r)
        physicsBody?.categoryBitMask = gCat_PICKUP
        physicsBody?.affectedByGravity = false
        
        if hasContact {
            physicsBody?.contactTestBitMask = gCat_PLAYER
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(currentTime: CFTimeInterval) { }
    func didBeginContact(withOther: SKNode) { }
    func didEndContact(withOther: SKNode) { }
}