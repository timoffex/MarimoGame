//
//  Ground.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/10/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Ground: SKSpriteNode {
    init(width: CGFloat, height: CGFloat) {
        let size = CGSize(width: width, height: height)
        
        super.init(texture: nil, color: NSColor(red: 0.6, green: 0.4, blue: 0, alpha: 1), size: size)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.dynamic = false
        physicsBody?.categoryBitMask = gCat_GROUND
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}