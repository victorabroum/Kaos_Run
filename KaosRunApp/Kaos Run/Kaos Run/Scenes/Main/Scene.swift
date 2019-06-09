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
        physicsWorld.contactDelegate = self
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
        
        if GameControlConfiguration.hasFinishedGame {
            resetGame()
        }
        
        if let worldNode = childNode(withName: .worldNodeName) {
            if let playerJumpComponent = worldNode.childNode(withName: .playerNodeName)?
                .entity?.component(ofType: JumpComponent.self) {
                playerJumpComponent.doJump()
            } else {
                entityManager.add(Player())
                GameControlConfiguration.isPlaying = true
            }
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
    
    func gameLost() {
        entityManager.pause()
        GameControlConfiguration.isPlaying = false
        guard let player = entityManager.getPlayer() else { return }
        guard let node = player.component(ofType: GKSKNodeComponent.self)?.node else { return }
        
        if let particle = SKEmitterNode(fileNamed: "Died") {
            node.addChild(particle)
        }
        
        appearLabelLost()
    }
    
    func appearLabelLost() {
        guard let worldNode = childNode(withName: .worldNodeName) else { return }
        
        guard worldNode.childNode(withName: .labelLostNodeName) == nil else { return }
        
        let labelLost = SKLabelNode(text: "YOU LOST 😱")
        labelLost.name = .labelLostNodeName
        labelLost.xScale = 0.3
        labelLost.yScale = 0.3
        labelLost.position.y = 100
        
        labelLost.run(SKAction.moveTo(y: 20, duration: 1.5)) {
            GameControlConfiguration.hasFinishedGame = true
        }
        
        worldNode.addChild(labelLost)
    }
    
    func resetGame() {
        entityManager.removeAll()
        GameControlConfiguration.hasFinishedGame = false
        
        guard let worldNode = childNode(withName: .worldNodeName) else { return }
        if let node = worldNode.childNode(withName: .labelLostNodeName) {
            node.removeFromParent()
        }
    }
}
