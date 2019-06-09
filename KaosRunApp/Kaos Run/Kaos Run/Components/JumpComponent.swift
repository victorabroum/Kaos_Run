//
//  JumpComponent.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import GameplayKit

class JumpComponent: GKComponent {
    var impulse: CGVector
    private(set) var isJumping: Bool = false
    
    init(impulse: CGVector) {
        self.impulse = impulse
        super.init()
    }
    
    private func canJump() -> Bool {
        guard let node = self.entity?.component(ofType: GKSKNodeComponent.self)?.node else { return false }
        guard let physicsBody = node.physicsBody else { return false }
        for body in physicsBody.allContactedBodies() {
            return body.categoryBitMask == .floor
        }
        return false
    }
    
    public func doJump() {
        guard let physicsBody = self.entity?.component(ofType: GKSKNodeComponent.self)?.node.physicsBody else { return }
        guard canJump() else { return }
        physicsBody.applyImpulse(impulse)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
