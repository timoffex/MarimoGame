//
//  Player.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/3/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    /* Player movement actions */
    
    var a_up: SKAction = SKAction.repeatActionForever(SKAction.moveByX(0, y: 400, duration: 1))
    var a_down: SKAction = SKAction.repeatActionForever(SKAction.moveByX(0, y: -400, duration: 1))
    var a_left: SKAction = SKAction.repeatActionForever(SKAction.moveByX(-400, y: 0, duration: 1))
    var a_right: SKAction = SKAction.repeatActionForever(SKAction.moveByX(400, y: 0, duration: 1))
    
    init() {
        
        let smiling = Textures.marimosAtlas.textureNamed("marimo_smiling")
        
        super.init(texture: smiling, color: NSColor(red: 0, green: 1, blue: 0, alpha: 1), size: CGSize(width: 50, height: 50))
        
        
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        physicsBody?.categoryBitMask = gCat_PLAYER
        physicsBody?.affectedByGravity = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func actionMoveUp() { runAction(a_up, withKey: "verticalMove") }
    func actionMoveDown() { runAction(a_down, withKey: "verticalMove") }
    func actionMoveLeft() { runAction(a_left, withKey: "horizontalMove") }
    func actionMoveRight() { runAction(a_right, withKey: "horizontalMove") }
    
    func actionMoveStopVertical() {
        removeActionForKey("verticalMove")
    }
    
    func actionMoveStopHorizontal() {
        removeActionForKey("horizontalMove")
    }
}
