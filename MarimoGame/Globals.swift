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
/* END CATEGORIES */


var gPlayer: Player?
var gCamera: Camera?


class Textures {
    static var marimosAtlas: SKTextureAtlas = SKTextureAtlas(named: "marimos.atlas")
}