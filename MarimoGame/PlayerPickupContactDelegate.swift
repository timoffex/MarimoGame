//
//  PlayerPickupContactDelegate.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/7/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class PlayerPickupContactDelegate: NSObject, SKPhysicsContactDelegate {
    func didBeginContact(contact: SKPhysicsContact) {
        let other: SKNode
        let pickup: Pickup
        let otherType: UInt32
        
        let cat1 = contact.bodyA.categoryBitMask
        let cat2 = contact.bodyB.categoryBitMask
        
        
        if ((cat2 & gCat_PICKUP) != 0) {
            other = contact.bodyA.node!
            pickup = contact.bodyB.node as! Pickup
            otherType = cat1
        } else if ((cat1 & gCat_PICKUP) != 0) {
            other = contact.bodyB.node!
            pickup = contact.bodyA.node as! Pickup
            otherType = cat2
        } else {
            return
        }
        
        pickup.removeFromParent()
        
        if (otherType & gCat_PLAYER) != 0 {
            // picked up by a player character
            
            (other as! Player).bubbles += 1
        }
    }
}