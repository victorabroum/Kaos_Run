//
//  FloorNode.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import SpriteKit

class FloorNode: SKNode {
    
    override init() {
        super.init()
        
        let floorNode = SKSpriteNode(texture: nil, color: .brown, size: CGSize(width: 80, height: 10))
        floorNode.position = CGPoint(x: 0, y: -5)
        floorNode.name = .floorNodeName
        
        let physicsBody = SKPhysicsBody(rectangleOf: floorNode.size)
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.mass = 10e5
        
        physicsBody.categoryBitMask = .floor
        physicsBody.collisionBitMask = .contactWithAllCategories()
        physicsBody.contactTestBitMask = ~(.contactWithAllCategories())
        
        floorNode.physicsBody = physicsBody
        
        self.addChild(floorNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
