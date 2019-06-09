//
//  Scene+PhysicsContactDelegate.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import SpriteKit

extension Scene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {

        guard let entityA = contact.bodyA.node?.entity, let entityB = contact.bodyB.node?.entity else { return }
        
        if let _ = entityA.component(ofType: AttackComponent.self), let _ = entityB.component(ofType: MortalComponent.self) {
            print("Player perdeu! A")
        }
        
        if let _ = entityB.component(ofType: AttackComponent.self), let _ = entityA.component(ofType: MortalComponent.self) {
            print("Player perdeu! B")
        }
        
    }
}
