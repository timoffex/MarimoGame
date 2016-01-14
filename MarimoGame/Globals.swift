//
//  Globals.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/4/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit



/* CATEGORIES */
let gCat_PLAYER: UInt32 = 0x1 << 0
let gCat_PICKUP: UInt32 = 0x1 << 1
let gCat_MONSTER: UInt32 = 0x1 << 2
let gCat_GROUND: UInt32 = 0x1 << 3
/* END CATEGORIES */


var gPlayer: Player?
var gCamera: Camera?



/*
    Note: Currently, this class does NOT use texture atlases. It could be greatly optimized.
*/
class Textures {
    private static let textureMap: NSMutableDictionary = NSMutableDictionary()
    
    static func get(name: String) -> SKTexture {
        let val = textureMap[name]
        
        if val is SKTexture {
            return val as! SKTexture
        } else {
            let new = SKTexture(imageNamed: name)
            
            // texture will either exist or be a placeholder
            textureMap[name] = new
            
            return new
        }
    }
}