//
//  Scene.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import SpriteKit
import GameplayKit
import ARKit

class Scene: SKScene {
    
    var initialAnchor: ARAnchor!
    var entityManager: EntityManager!
    
    var lastUpdateTime: TimeInterval = 0.0
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        entityManager = EntityManager(self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        super.update(currentTime)
        
        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let deltaTime = currentTime - self.lastUpdateTime
        
        self.entityManager.update(deltaTime)
        
        if GameControlConfiguration.isPlaying && CACurrentMediaTime() - lastUpdateTime > EnemyConfiguration.spawnTime {
            lastUpdateTime = CACurrentMediaTime()
            entityManager.spawnSlime(onPosition: EnemyConfiguration.spawPoint)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let worldNode = childNode(withName: .worldNodeName) {
            if let playerJumpComponent = worldNode.childNode(withName: .playerNodeName)?
                .entity?.component(ofType: JumpComponent.self) {
                playerJumpComponent.doJump()
            } else {
                entityManager.add(Player())
            }
            GameControlConfiguration.isPlaying = true
            return
        }
        createWorld()
        
    }
}

extension Scene {
    private func createWorld() {
        guard let sceneView = self.view as? ARSKView else {
            return
        }
        
        // Create anchor using the camera's current position
        if let currentFrame = sceneView.session.currentFrame {
            
            // Create a transform with a translation of 0.2 meters in front of the camera
            var translation = matrix_identity_float4x4
            translation.columns.3.z = -0.3
            let transform = simd_mul(currentFrame.camera.transform, translation)
            
            // Add a new anchor to the session
            initialAnchor = ARAnchor(transform: transform)
            sceneView.session.add(anchor: initialAnchor)
        }
    }
}
