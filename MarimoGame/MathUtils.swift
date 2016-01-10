//
//  MathUtils.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/4/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import Foundation



func distance(x: CGPoint, _ y: CGPoint) -> Double {
    let dx = Double(x.x - y.x)
    let dy = Double(x.y - y.y)
    return sqrt(dx*dx + dy*dy)
}


func randomDouble() -> Double {
    return Double(random()) / Double(RAND_MAX)
}

func randomPositionInRect(rect: CGRect) -> CGPoint {
    let x = CGFloat(randomDouble())*rect.width + rect.minX
    let y = CGFloat(randomDouble())*rect.height + rect.minY
    
    return CGPointMake(x, y)
}

func randomPositionInWidth(width: CGFloat, height: CGFloat) -> CGPoint {
    let x = CGFloat(randomDouble())*width
    let y = CGFloat(randomDouble())*height
    
    return CGPointMake(x, y)
}