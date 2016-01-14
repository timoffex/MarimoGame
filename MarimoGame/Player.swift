//
//  Player.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/3/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode, UpdateReceiver {
    
    var maxForceRoll: CGFloat = 100
    var maxForceFloat: CGFloat = 50
    var maxForceSink: CGFloat = 80
    
    var bubbles: Double = 0
    var gems: Double = 0
    
    init() {
        let smiling = Textures.get("marimo_smiling")
        
        super.init(texture: smiling, color: NSColor(red: 0, green: 1, blue: 0, alpha: 1), size: CGSize(width: 50, height: 50))
        
        
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        physicsBody?.categoryBitMask = gCat_PLAYER
        physicsBody?.density = 8
        physicsBody?.linearDamping = 0.8
        
        physicsBody?.collisionBitMask = gCat_MONSTER | gCat_GROUND
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func forceAction(dx: CGFloat, _ dy: CGFloat) -> SKAction {
        return SKAction.customActionWithDuration(1) { (node, _) in
            node.physicsBody!.applyForce(CGVectorMake(dx, dy))
        }
    }
    
    func controlRollRight() { runAction(forceAction(maxForceRoll, 0), withKey: "horizontal") }
    func controlRollLeft() { runAction(forceAction(-maxForceRoll, 0), withKey: "horizontal") }
    func controlRollNone() { removeActionForKey("horizontal") }
    
    func controlVFloat() { runAction(forceAction(0, maxForceFloat), withKey: "vertical") }
    func controlVSink() { runAction(forceAction(0, -maxForceSink), withKey: "vertical") }
    func controlVNone() { removeActionForKey("vertical") }
    
    func controlSpecial() {
        let goldfish = scene!.childNodeWithName("//monster")!
        
        let action = SKAction.customActionWithDuration(4, actionBlock: { (node, elapsedTime) in
                let delta = goldfish.position - self.position
                let force = Double(self.physicsBody!.mass*1000) * delta/length(delta)
                node.physicsBody!.applyForce(force)
            })
        
        runAction(action, withKey: "custom")
    }
    
    
    
    
    func update(currentTime: NSTimeInterval) {
        
        // carrying bubbles causes an upward force!
        physicsBody?.applyForce(CGVectorMake(0, CGFloat(bubbles)))
    }
}
