//
//  SpriteComponent.swift
//  exo2
//
//  Created by justin fluidity on 9/30/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit
import GameplayKit

// Another simple example, without guards:
class SpriteComponent: GKComponent {
  
  @GKInspectable var uniqueName: String = "CRASH!" // Must change this to match the node's name in SKS.
  
  lazy var spriteNode: SKSpriteNode = {
    return gScene.childNode(withName: self.uniqueName) as! SKSpriteNode // If you see this line highlighted on a crash, check that your sks node name and the gkinspectable uniquename are the same.
  }()
}


protocol HasSpriteComponent {
  var node: SKSpriteNode { get }
}

extension HasSpriteComponent where Self: GKComponent {
  
  // A bit inefficient (because computed property), but makes life simpler..
  // Alternative would be to boilerplate this as a lazy every time.
  // Would be worth analyzing performance differences with many components that use this.
  var node: SKSpriteNode {
    for component in self.entity!.components {
      if let spriteComponent = component as? SpriteComponent { return spriteComponent.spriteNode }
    }
    fatalError("added component that requires SpriteComponent to a node/entity without a SpriteComponent!")
  }
}


