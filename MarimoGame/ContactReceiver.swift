//
//  ContactReceiver.swift
//  MarimoGame
//
//  Created by Tima Peshin on 1/12/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit


protocol ContactReceiver: AnyObject {
    func didBeginContact(withOther: SKNode)
    func didEndContact(withOther: SKNode)
}