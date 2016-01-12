//
//  Gem.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/11/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Bubble: Pickup {
    init() {
        // set size and texture
        super.init(circleOfRadius: 10, hasUpdate: false, hasContact: true)
        self.texture = Textures.get("bubble")
        
        // make all Bubbles detect contact with players
        self.physicsBody?.contactTestBitMask |= gCat_PLAYER
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // I should allow an update() function to streamline AI coding
    
    // override this method to detect contact with other Nodes
    override func didBeginContact(withOther: SKNode) {
        if withOther is Player {
            let player = withOther as! Player
            
            player.bubbles++
            self.removeFromParent()
        }
    }
}
