//
//  Player.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import GameplayKit

class Player: GKEntity {
    
    override init() {
        super.init()
        
        // Add node component
        addNodeComponent()
        
        // Add Jump Component
        addComponent(JumpComponent(impulse: PlayerConfiguration.impulse))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let node = self.component(ofType: GKSKNodeComponent.self)?.node {
            node.removeFromParent()
        }
    }
    
}

// MARK: Extension to setup Components
extension Player {
    
    private func addNodeComponent() {
        let node = SKSpriteNode(texture: nil, color: .green, size: CGSize(width: 5, height: 5))
        node.position = .zero
        node.name = "playerNode"
        
        let physicBody = SKPhysicsBody(rectangleOf: node.size)
        physicBody.affectedByGravity = true
        physicBody.categoryBitMask = .player
        physicBody.collisionBitMask = .contactWithAllCategories()
        physicBody.contactTestBitMask = ~(.contactWithAllCategories(less:[.floor]))
        
        node.physicsBody = physicBody
        
        addComponent(GKSKNodeComponent(node: node))
    }
}
