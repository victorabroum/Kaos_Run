//
//  DebugMode.swift
//  Kaos Run
//
//  Created by Victor Vasconcelos on 09/06/19.
//  Copyright © 2019 FF Studios. All rights reserved.
//

import Foundation

struct DebugMode {
    
    static let showPhysics = { () -> Bool in
        #if DEBUG
            return true
        #else
            return false
        #endif
    }()
    
    static let showsFPS = { () -> Bool in
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    static let showsNodeCount = { () -> Bool in
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
}
