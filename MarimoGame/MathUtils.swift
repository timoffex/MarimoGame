//
//  MathUtils.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/4/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import Foundation


func length(vec: CGVector) -> Double {
    return sqrt(Double(vec.dx*vec.dx + vec.dy*vec.dy))
}

func -(left: CGPoint, right: CGPoint) -> CGVector {
    return CGVectorMake(left.x-right.x, left.y-right.y)
}



func +(left: CGVector, right: CGVector) -> CGVector {
    return CGVectorMake(left.dx + right.dx, left.dy + right.dy)
}
func -(left: CGVector, right: CGVector) -> CGVector {
    return left + (-right)
}
prefix func -(vec: CGVector) -> CGVector {
    return CGVectorMake(-vec.dx, -vec.dy)
}

func /(left: CGVector, right: Double) -> CGVector {
    let r = CGFloat(right)
    return CGVectorMake(left.dx/r, left.dy/r)
}

func *(left: CGVector, right: Double) -> CGVector {
    let r = CGFloat(right)
    return CGVectorMake(left.dx*r, left.dy*r)
}

func *(left: Double, right: CGVector) -> CGVector {
    return right * left
}



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