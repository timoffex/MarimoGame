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
    
    private var contactDelegate: PlayerPickupContactDelegate!
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */        
        gPlayer = Player()
        gCamera = Camera()
        
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
        
        contactDelegate = PlayerPickupContactDelegate()
        physicsWorld.contactDelegate = contactDelegate
        physicsWorld.gravity = CGVectorMake(0, -0.05)
    }
    
    
    private func testInitMonsters() {
        let m = Goldfish();
        m.name = "monster"
        m.position = CGPointMake(300, 0)
        layerMiddle.addChild(m)
    }
    
    private func testInitPickups() {
        for _ in 0..<10 {
            let p = Pickup()
            p.name = "pickup"
            
            p.position = randomPositionInRect(CGRect(
                x: self.frame.origin.x-self.frame.width/2,
                y: self.frame.origin.y-self.frame.height/2,
                width: self.frame.width, height: self.frame.height))
            
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
        
        
        
        // update all nodes marked "monster"
        layerMiddle.enumerateChildNodesWithName("monster") { (c,stopPtr) in
            (c as! Monster).update(currentTime)
        }
        
        // update player
        gPlayer?.update(currentTime)
        
        // move camera
        gCamera?.update(currentTime)
        centerOnCamera()
        
        
    }
    
    private func centerOnCamera() {
        if let cam = gCamera {
            let cpos = convertPoint(cam.position, fromNode: world)
            world.position = CGPointMake(world.position.x-cpos.x + size.width/2, world.position.y-cpos.y + size.height/2)
        }
    }
}
