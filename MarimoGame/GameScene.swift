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
        layerMiddle.addChild(gPlayer!)
        
        testInitMonsters()
        testInitPickups()
        
        
        world = SKNode()
        world.addChild(layerMiddle)
        world.addChild(gCamera!)
        
        self.addChild(world)
        
        
        nextResponder = controls
        
        contactDelegate = PlayerPickupContactDelegate()
        physicsWorld.contactDelegate = contactDelegate
        physicsWorld.gravity = CGVector.zero
    }
    
    
    private func testInitMonsters() {
        let m = Monster();
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
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
        layerMiddle.enumerateChildNodesWithName("monster") { (c,stopPtr) in
            (c as! Monster).update(currentTime)
        }
        
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
