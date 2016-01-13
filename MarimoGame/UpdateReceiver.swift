//
//  UpdateReceiver.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/12/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit


protocol UpdateReceiver: AnyObject {
    /// Override this function to do something every frame (for example AI).
    func update(currentTime: CFTimeInterval)
}
