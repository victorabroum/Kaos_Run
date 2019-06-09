//
//  RunHotel.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import UIKit
import ARKit
import SpriteKit

class RunHotel: SKScene {
    
    var worldAnchor: ARAnchor?
    var entityManager: EntityManager!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)

        entityManager = EntityManager(self)
        
        guard let worldAnchor = worldAnchor else { return }
        guard let sceneView = self.view as? ARSKView else { return }
        
        sceneView.session.add(anchor: worldAnchor)
    }
    
}
