//
//  UpDownPlatform.swift
//  exo2
//
//  Created by justin fluidity on 9/30/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit
import GameplayKit

class UpDownPlatform: GKComponent, HasSpriteComponent {
  
  var constantSpeed: CGFloat = 50
  var firstRun = true // Workaround to component being initialized prior to node added to scene.
  
  override func update(deltaTime seconds: TimeInterval) {
    guard let scene = node.scene    else { print("node must be in scene!"); return }
    guard let pb = node.physicsBody else { print("node must have a pb!!");  return }
    
    // Initial movement is upwards: (workaround)
    if firstRun { pb.velocity.dy = constantSpeed; firstRun = false }
    
    // Handle direction change:
    if node.position.y > scene.frame.maxY      { pb.velocity.dy = -constantSpeed; return }
    else if node.position.y < scene.frame.minY { pb.velocity.dy =  constantSpeed; return }
    
    // Keep everything at constant speed:
    if pb.velocity.dy < 0 { pb.velocity.dy = -constantSpeed }
    else                  { pb.velocity.dy =  constantSpeed }
  }
}
