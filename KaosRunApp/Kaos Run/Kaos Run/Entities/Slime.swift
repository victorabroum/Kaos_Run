//
//  Goop.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import GameplayKit

class Slime: GKEntity {
    
    init(initialPosition position: CGPoint) {
        super.init()
        
        addNodeComponent(initialPosition: position)
        
        addComponent(MoveForwardComponent(velocity: EnemyConfiguration.velocity))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Slime {
    
    private func addNodeComponent(initialPosition position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "slime_walk_01")
        node.name = .slimeNodeName
        node.position = position
        node.xScale = (-EnemyConfiguration.scaleFactor)
        node.yScale = EnemyConfiguration.scaleFactor
        
        let physicBody = SKPhysicsBody(rectangleOf: node.size)
        physicBody.affectedByGravity = true
        physicBody.allowsRotation = false
        
        physicBody.mass = EnemyConfiguration.mass
        physicBody.friction = 0.30
        
        physicBody.categoryBitMask = .slime
        physicBody.collisionBitMask = .contactWithAllCategories()
        physicBody.contactTestBitMask = ~(.contactWithAllCategories(less: [.player]))
        
        node.physicsBody = physicBody
        
        addComponent(GKSKNodeComponent(node: node))
    }
}
