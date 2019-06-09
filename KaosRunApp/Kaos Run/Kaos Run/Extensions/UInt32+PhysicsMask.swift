//
//  UInt32+PhysicsMask.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import SpriteKit

extension UInt32 {
    static let base: UInt32 = 0b1
    static let player = UInt32.base << 0
    static let floor = UInt32.base << 1
    
    static let allMasks: [UInt32] = [
        UInt32.player,
        UInt32.floor
    ]
    
    static func contactWithAllCategories(less: [UInt32] = []) -> UInt32 {
        var result: UInt32 = 0b00
        
        for category in UInt32.allMasks {
            if !less.contains(category) {
                result |= category
            }
        }
        
        return result
    }
}
