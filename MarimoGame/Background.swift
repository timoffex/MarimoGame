//
//  Background.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/13/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit

class Background: SKNode {
    init(size: CGRect) {
        super.init()
        
        createBubbles(size)
        
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createBubbles(size: CGRect) {
        let numBubbles = 15
        
        let spawnZone = size
        
        for _ in 0..<numBubbles {
            let radius = CGFloat(randomDouble()*15 + 5)
            let lifeSpan = randomDouble()*5 + 2
            
            self.addChild(BackgroundBubble(radius: radius, spawnZone: spawnZone, lifeSpan: lifeSpan))
        }
    }
    
    
    
    class BackgroundBubble: SKSpriteNode {
        let spawnZone: CGRect
        let lifeSpan: CFTimeInterval
        
        init(radius r: CGFloat, spawnZone spawn: CGRect, lifeSpan life: CFTimeInterval) {
            spawnZone = spawn
            lifeSpan = life
            
            super.init(texture: Textures.get("bubble"), color: NSColor.whiteColor(), size: CGSize(width:2*r, height:2*r))
            
            self.alpha = 0.0
            

            let sideToSideTiming = 1 + (randomDouble()*0.4 - 0.2)
            let speed = 40 + 40*randomDouble()

            
            // Basic actions (float up + (float right / float left) + (fade in / fade out))
            let floatUp = SKAction.moveByX(0, y: CGFloat(life * speed), duration: life)
            let floatRight = SKAction.moveByX(20, y: 0, duration: sideToSideTiming)
            let floatLeft = SKAction.moveByX(-20, y: 0, duration: sideToSideTiming)
            let fadeIn = SKAction.fadeAlphaTo(0.4, duration: min(2, 0.5*life))
            let fadeOut = SKAction.fadeAlphaTo(0.0, duration: life - fadeIn.duration)
            
            
            
            floatRight.timingMode = SKActionTimingMode.EaseInEaseOut
            floatLeft.timingMode = SKActionTimingMode.EaseInEaseOut
            
            
            
            // Float right followed by float left
            let rightLeft = SKAction.repeatAction(SKAction.sequence([floatRight, floatLeft]),
                count: Int(life/(2.0*sideToSideTiming)))
            
            // Fade in followed by fade out
            let totalFade = SKAction.sequence([fadeIn, fadeOut])
            
            
            
            // Full animation
            let fullAnimation = SKAction.sequence([
                SKAction.runBlock {self.position = randomPositionInRect(self.spawnZone)}, // move to start
                SKAction.group([floatUp, rightLeft, totalFade])])
            
            runAction(SKAction.repeatActionForever(fullAnimation))
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
