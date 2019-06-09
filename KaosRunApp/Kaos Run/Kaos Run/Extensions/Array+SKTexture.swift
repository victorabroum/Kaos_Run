//
//  Array+SKTexture.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import SpriteKit

extension Array where Element == SKTexture {
    init (withFormat format: String, range: ClosedRange<Int>) {
        self = range.map({ (index) in
            let imageNamed = String(
                format: format,
                index <= 9 ? "0\(index)" : "\(index)")
            return SKTexture(imageNamed: imageNamed)
        })
    }
    
    static let playerWalk = [SKTexture].init(withFormat: "blue_starff_walk_%@", range: 1...16)
    static let slimeWalk = [SKTexture].init(withFormat: "slime_walk_%@", range: 1...16)
}
