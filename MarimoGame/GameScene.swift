//
//  GameScene.swift
//  WinterGame
//
//  Created by Tima Peshin on 12/31/15.
//  Copyright (c) 2015 timoffex. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var layerMiddle: SKNode!
    private var playerNode: Player!
    
    private var world: SKNode!
    
    private var controls: ControlsHandler!
    
    
    
    private var contactReceivers: [ContactReceiver]!
    private var updateReceivers: [UpdateReceiver]!
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        contactReceivers = []
        updateReceivers = []
        
        gPlayer = Player()
        gCamera = Camera()
        
        updateReceivers.append(gPlayer!)
        updateReceivers.append(gCamera!)
        
        controls = ControlsHandler(player: gPlayer!)
        
        layerMiddle = SKNode()
        world = SKNode()
        
        
        
        
        layerMiddle.addChild(gPlayer!)  // add player
        testInitMonsters()              // add monsters (test)
        testInitPickups()               // add pickups (test)
        testInitGround()                // add ground (test)
        
        
        // world contains everything
        world.addChild(layerMiddle)
        world.addChild(gCamera!)
        
        self.addChild(world)
        
        
        nextResponder = controls
        
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVectorMake(0, -0.05)
    }
    
    
    private func testInitMonsters() {
        let m = Goldfish();
        m.name = "monster"
        m.position = CGPointMake(300, 0)
        layerMiddle.addChild(m)
        updateReceivers.append(m)
    }
    
    private func testInitPickups() {
        // Add bubbles!
        for _ in 0..<10 {
            let p = Bubble()
            p.name = "pickup"
            
            p.position = randomPositionInRect(CGRect(
                x: self.frame.origin.x-self.frame.width/2,
                y: self.frame.origin.y-self.frame.height/2,
                width: self.frame.width, height: self.frame.height))
            
            if p.hasContact {
                contactReceivers.append(p)
            }
            
            if p.hasUpdate {
                updateReceivers.append(p)
            }
            
            layerMiddle.addChild(p)
        }
        
        // Add gems!
        for _ in 0..<10 {
            let p = Gem()
            p.name = "pickup"
            
            p.position = randomPositionInRect(CGRect(
                x: self.frame.origin.x-self.frame.width/2,
                y: self.frame.origin.y-self.frame.height/2,
                width: self.frame.width, height: self.frame.height))
            
            if p.hasContact {
                contactReceivers.append(p)
            }
            
            if p.hasUpdate {
                updateReceivers.append(p)
            }
            
            layerMiddle.addChild(p)
        }
    }
    
    private func testInitGround() {
        let ground = Ground(width: 10000, height: 10)
        
        ground.position = CGPointMake(0, -300)
        world.addChild(ground)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
        // Updates Player, Camera, Monsters, etc.
        updateReceivers.forEach { e in e.update(currentTime) }
        
        // Centers screen on camera
        centerOnCamera()
    }
    
    private func centerOnCamera() {
        if let cam = gCamera {
            let cpos = convertPoint(cam.position, fromNode: world)
            world.position = CGPointMake(world.position.x-cpos.x + size.width/2, world.position.y-cpos.y + size.height/2)
        }
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let n1 = contact.bodyA.node!
        let n2 = contact.bodyB.node!
        
        for receiver in contactReceivers {
            if receiver === n1 {
                receiver.didBeginContact(n2)
            } else if receiver === n2 {
                receiver.didBeginContact(n1)
            }
        }
    }
    
    func didEndContact(contact: SKPhysicsContact) {
        let n1 = contact.bodyA.node!
        let n2 = contact.bodyB.node!
        
        for receiver in contactReceivers {
            if receiver === n1 {
                receiver.didEndContact(n2)
            } else if receiver === n2 {
                receiver.didEndContact(n1)
            }
        }
    }
}
