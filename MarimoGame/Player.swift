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
    /* Player movement actions */
    
    private enum HorizontalMovement { case NONE, RIGHT, LEFT }
    private enum VerticalMovement { case NONE, FLOAT, SINK }
    private var horizontalAction: HorizontalMovement = .NONE
    private var verticalAction: VerticalMovement = .NONE
    
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
        physicsBody?.mass = 1
        physicsBody?.linearDamping = 0.8
        
        physicsBody?.collisionBitMask &= ~gCat_PICKUP
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func controlRollRight() { horizontalAction = .RIGHT }
    func controlRollLeft() { horizontalAction = .LEFT }
    func controlRollNone() { horizontalAction = .NONE }
    
    func controlVFloat() { verticalAction = .FLOAT }
    func controlVSink() { verticalAction = .SINK }
    func controlVNone() { verticalAction = .NONE }
    
    
    
    
    func update(currentTime: NSTimeInterval) {
        /*
            horizontalAction = whether to roll right, left or not roll
            verticalAction = whether to try to float up, to sink down, or neither
        */
        
        switch horizontalAction {
        case .NONE: break
        case .RIGHT: physicsBody?.applyForce(CGVectorMake(maxForceRoll, 0)); break
        case .LEFT: physicsBody?.applyForce(CGVectorMake(-maxForceRoll, 0)); break
        }
        
        switch verticalAction {
        case .NONE: break
        case .FLOAT: physicsBody?.applyForce(CGVectorMake(0, maxForceFloat)); break
        case .SINK: physicsBody?.applyForce(CGVectorMake(0, -maxForceSink)); break
        }
        
        // carrying bubbles causes an upward force!
        physicsBody?.applyForce(CGVectorMake(0, CGFloat(bubbles)))
    }
}
