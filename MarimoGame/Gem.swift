//
//  Gem.swift
//  MarimoGame
//
//  Created by Reshma Zachariah on 1/13/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Gem: Pickup {
    init() {
        // set size and texture
        super.init(circleOfRadius: 25, hasUpdate: false, hasContact: true)
        self.texture = Textures.get("gem1")
        
        // make all Gems detect contact with players
        self.physicsBody?.contactTestBitMask |= gCat_PLAYER
        
        // make Gems react to gravity
        self.physicsBody?.affectedByGravity = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // override this method to detect contact with other Nodes
    override func didBeginContact(withOther: SKNode) {
        if withOther is Player {
            let player = withOther as! Player
            
            player.gems++
            self.removeFromParent()
        }
    }
}
