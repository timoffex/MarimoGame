//
//  Goldfish.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/9/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Goldfish: Monster {
    
    private var fishSpeed: Double = 30
    
    override init() {
        super.init(texture: nil, color: NSColor(red: 0.6, green: 0.4, blue: 0, alpha: 1), size: CGSize(width: 100, height: 50))
        physicsBody!.mass = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        // chase player
        if let player = gPlayer {
            let dp = player.position - self.position
            let targetVel = fishSpeed * dp / length(dp)
            let dv = targetVel - physicsBody!.velocity
            physicsBody?.applyImpulse(Double(physicsBody!.mass) * dv)
        }
    }
}
