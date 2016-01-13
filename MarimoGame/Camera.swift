//
//  Camera.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/5/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Camera: SKNode, UpdateReceiver {
    func update(currentTime: NSTimeInterval) {
        if let player = gPlayer {
            let action = SKAction.moveTo(player.position, duration: 0.5)
            action.timingMode = SKActionTimingMode.EaseOut
            runAction(action)
        }
    }
}
