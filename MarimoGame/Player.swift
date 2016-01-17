//
//  Player.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/3/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode, UpdateReceiver, ContactReceiver {
    
    let maxForceRoll: CGFloat = 100
    let maxForceSink: CGFloat = 80
    var maxForceFloat: CGFloat {
        return 50 + CGFloat(bubbles) * 5
    }
    
    
    
    private var _bubbles: Double = 0
    private var _gems: Double = 0
    
    
    var bubbles: Double {
        get { return _bubbles }
        set {
            _bubbles = newValue
            self.bubbleEmitter.particleBirthRate = CGFloat(_bubbles)
        }
    }
    var gems: Double {
        get { return _gems }
        set {
            grow(CGFloat(1.0 + 0.2 * (newValue-_gems)))
            _gems = newValue
        }
    }
    
    
    private var bubbleEmitter: SKEmitterNode
    
    init(world: SKNode) {
        bubbleEmitter = SKEmitterNode(fileNamed: "BubbleParticle")!
        
        let smiling = Textures.get("marimo_smiling")
        
        super.init(texture: smiling, color: NSColor(red: 0, green: 1, blue: 0, alpha: 1), size: CGSize(width: 50, height: 50))
        
        
        // Physics configuration
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        physicsBody?.categoryBitMask = gCat_PLAYER
        physicsBody?.density = 8
        physicsBody?.linearDamping = 0.8
        
        physicsBody?.collisionBitMask = gCat_MONSTER | gCat_GROUND
        physicsBody?.contactTestBitMask = gCat_MONSTER
        
        
        // Particle effect configuration
        bubbleEmitter.targetNode = world
        bubbleEmitter.particlePositionRange = CGVectorMake(50,50)
        bubbleEmitter.particleZPosition = 1
        bubbleEmitter.particleBirthRate = 0
        bubbleEmitter.name = "bubbleEmitter"
        
        addChild(bubbleEmitter)
    }

    required init?(coder aDecoder: NSCoder) {
        
        self._bubbles = aDecoder.valueForKey("_bubbles") as! Double
        self._gems = aDecoder.valueForKey("_gems") as! Double
        self.bubbleEmitter = aDecoder.valueForKey("bubbleEmitter") as! SKEmitterNode
        
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
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
    
    
    func grow(factor: CGFloat) {
        
        let original = bubbleEmitter.particlePositionRange
        let duration: CFTimeInterval = 1
        
        let myScaleAction = SKAction.scaleBy(factor, duration: duration)
        
        let action = SKAction.group([
            myScaleAction,
            
            SKAction.runAction(myScaleAction.reversedAction(), onChildWithName: "bubbleEmitter"),
            
            SKAction.customActionWithDuration(duration) { (node, elapsedTime) in
                let player = node as! Player
                
                player.bubbleEmitter.particlePositionRange = (Double(elapsedTime * (factor-1))/duration) * original + original
            }
            ])
        
        runAction(action)
    }
    
    
    
    func update(currentTime: NSTimeInterval) {
        
        // carrying bubbles causes an upward force!
        physicsBody?.applyForce(CGVectorMake(0, CGFloat(bubbles)))
    }
    
    func didBeginContact(withOther: SKNode) {
        if withOther is Goldfish {
            self.texture = Textures.get("marimo_surprised")
        }
    }
    
    func didEndContact(withOther: SKNode) {
        if withOther is Goldfish {
            self.texture = Textures.get("marimo_smiling")
        }
    }
}
