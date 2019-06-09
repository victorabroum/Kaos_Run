//
//  MoveForwardComponent.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import GameplayKit

class MoveForwardComponent: GKComponent {
    var velocity: CGFloat
    
    init(velocity: CGFloat) {
        self.velocity = velocity
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Move Forward System
extension MoveForwardComponent {
    override func update(deltaTime seconds: TimeInterval) {
        guard let physicsBody = self.entity?.component(ofType: GKSKNodeComponent.self)?.node.physicsBody else { return }
        if physicsBody.velocity.dx <= EnemyConfiguration.maxVelocity { physicsBody.applyImpulse(CGVector(dx: -velocity, dy: 0)) }        
    }
}
