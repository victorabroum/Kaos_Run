//
//  GameplayConfiguration.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import SpriteKit

struct PlayerConfiguration {
    static let impulse = CGVector(dx: 0.04, dy: 1)
    static let scaleFactor: CGFloat = 0.03
}

struct EnemyConfiguration {
    
    static let mass: CGFloat = 1
    
    static let maxVelocity: CGFloat = 5
    
    static var spawPoint: CGPoint {
        get {
            return CGPoint(x: .random(in: 70...80), y: 3)
        }
    }
    
    static var spawnTime: TimeInterval {
        get {
            return TimeInterval.random(in: 3...10)
        }
    }
    
    static var velocity: CGFloat {
        get {
            return CGFloat.random(in: 9...10)
        }
    }
    
    static let scaleFactor: CGFloat = 0.03
}
