//
//  EntityManager.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

class EntityManager {
    
    /// Set of All entities in game, this should the only place of the entity is strong reference
    private(set) var entities = Set<GKEntity>()
    
    /// Set for control entities to remove
    private var toRemove = Set<GKEntity> ()
    
    /// Instance for scene where the entity manager will act
    private var scene: SKScene
    
    /// All components systems
    // Insert any entity that needs updating here as a GKComponentSystem
    lazy private var componentSystems: [GKComponentSystem] = {
        return [ ]
    }()
    
    
    init(_ scene: SKScene) {
        self.scene = scene
    }
    
    /// To Add an Entity
    public func add(_ entity: GKEntity) {
        
        self.entities.insert(entity)
        
        // Add rigth components systems
        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
        
        // If has SpriteComponent, so it's rendered on Scene
        if let node = entity.component(ofType: GKSKNodeComponent.self)?.node,
            let worldNode = scene.childNode(withName: .worldNodeName) {
            worldNode.addChild(node)
        }
    }
    
    /// To Remove an Entity
    public func remove(_ entity: GKEntity) {
        self.toRemove.insert(entity)
    }
    
    /// To remove all entities
    public func removeAll() {
        for entity in self.entities {
            self.toRemove.insert(entity)
        }
    }
    
    public func update(_ deltaTime: CFTimeInterval) {
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: deltaTime)
        }
        
        // Update Components in System
        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }
        
        // Remove right component
        for currentRemove in toRemove {
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
            entities.remove(currentRemove)
        }
        toRemove.removeAll()
    }

}
