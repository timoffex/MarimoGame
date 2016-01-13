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
    private var fishDashSpeed: Double = 200
    
    
    private enum AIMode { case IDLE, CHASE }
    private var mode: AIMode = .IDLE
    private var idleAI: IdleAI!
    private var chaseAI: ChaseAI!
    
    init() {
        super.init(width: 100, height: 50)
        
        self.color = NSColor(red: 0.6, green: 0.4, blue: 0, alpha: 1)
        physicsBody!.mass = 1
        
        
        idleAI = IdleAI(fish: self)
        chaseAI = ChaseAI(fish: self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(currentTime: CFTimeInterval) {
        
        
        switch mode {
        case .IDLE:
            idleAI.update(currentTime);
            if idleAI.shouldSwitch() {
                mode = .CHASE
                chaseAI.start(currentTime)
            }
            break
            
        case .CHASE:
            chaseAI.update(currentTime);
            if chaseAI.shouldSwitch() {
                mode = .IDLE
                idleAI.start(currentTime)
            }
            break
        }
    }
    
    
    private class IdleAI {
        var nextSwitch: CFTimeInterval = 0
        var direction: CGVector!
        var fishParent: Goldfish
        
        var startTime: CFTimeInterval = 0
        var willSwitchMode: Bool = false
        
        var numDirectionSwitches: Int = 0
        
        init(fish: Goldfish) { fishParent = fish }
        
        func start(currentTime: CFTimeInterval) {
            startTime = currentTime
            willSwitchMode = false
            numDirectionSwitches = 0
        }
        
        func update(currentTime: CFTimeInterval) {
            if currentTime > nextSwitch {
                direction = randomVector(magnitude: fishParent.fishSpeed)
                nextSwitch = currentTime + CFTimeInterval(randomDouble()*5)
                numDirectionSwitches++
                
                if numDirectionSwitches > 5 {
                    willSwitchMode = true
                }
            }
            
            // set angle to 0
            let myDirection = CGVectorMake(cos(fishParent.zRotation), sin(fishParent.zRotation))
            let angleDif = acos(myDirection.dx)
            let targetAngularVelocity = CGFloat(angleDif*5) * (myDirection.dy < 0 ? 1 : -1)
            let dAngularVelocity = targetAngularVelocity - fishParent.physicsBody!.angularVelocity
            fishParent.physicsBody?.applyTorque(fishParent.physicsBody!.mass * dAngularVelocity)
            
            // move in direction
            let dv = direction - fishParent.physicsBody!.velocity
            fishParent.physicsBody?.applyImpulse(Double(fishParent.physicsBody!.mass) * dv)
        }
        
        func shouldSwitch() -> Bool {
            return willSwitchMode
        }
    }
    
    private class ChaseAI {
        var fishParent: Goldfish
        
        var startTime: CFTimeInterval = 0
        var willSwitchMode: Bool = false
        
        init(fish: Goldfish) { fishParent = fish }
        
        func start(currentTime: CFTimeInterval) {
            startTime = currentTime
            willSwitchMode = false
        }
        
        func update(currentTime: CFTimeInterval) {
            if currentTime - startTime > 2 {
                willSwitchMode = true
            }
            
            if let player = gPlayer {
                let dp = player.position - fishParent.position
                let dphat = dp / length(dp)
                
                let myDirection = CGVectorMake(cos(fishParent.zRotation), sin(fishParent.zRotation))
                let angleDif = acos(myDirection • dphat)
                let targetAngularVelocity = CGFloat(angleDif*5) * (crossProductZ(myDirection,dphat) > 0 ? 1 : -1)
                let dAngularVelocity = targetAngularVelocity - fishParent.physicsBody!.angularVelocity
                
                
                // look toward player
                fishParent.physicsBody?.applyTorque(fishParent.physicsBody!.mass * dAngularVelocity)
                
                
                
                // move toward player
                let targetVel = fishParent.fishDashSpeed * dphat
                let dv = targetVel - fishParent.physicsBody!.velocity
                fishParent.physicsBody?.applyForce(Double(fishParent.physicsBody!.mass) * dv)
            } else { willSwitchMode = true }
        }
        
        func shouldSwitch() -> Bool {
            return willSwitchMode
        }
    }
}