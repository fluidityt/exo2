//
//  Platform_BoxPathComponent.swift
//  exo2
//
//  Created by justin fluidity on 9/30/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit
import GameplayKit

class Platforms_BoxPathComponent: GKComponent {
  
  private enum MovingDirection: String { case up, down, left, right }
  
  private var node: SKSpriteNode!
  
  private var state: MovingDirection = .right
  
  private lazy var startingPos: CGPoint = { self.node.position }()
  
  @GKInspectable var startingDirection: String = "down"
  @GKInspectable var uniqueName: String = "CRASH INC" // you have to change this in the editor...
  @GKInspectable var xPathSize: CGFloat = 300
  @GKInspectable var yPathSize: CGFloat = 400
  
  // Moves in clockwise:
  private var isTooFarRight: Bool { return self.node.position.x > (self.startingPos.x + self.xPathSize) }
  private var isTooFarDown: Bool { return self.node.position.y < (self.startingPos.y - self.yPathSize) }
  private var isTooFarLeft: Bool { return self.node.position.x < self.startingPos.x }
  private var isTooFarUp: Bool { return self.node.position.y > self.startingPos.y }
  
  override func didAddToEntity() {
    print("adding component")
    // can't add node here because nodes aren't part of scene yet :(
    // possibly do a thread?
  }
  
  override func update(deltaTime seconds: TimeInterval) {
    if node == nil {
      node = gScene.childNode(withName: uniqueName) as! SKSpriteNode
      
      // for some reason this is glitching out and needed to be redeclared..
      // showing 0 despite clearly not being 0, both here and in the SKS editor:
      xPathSize = 300
    }
    
    let amount: CGFloat = 2 // Amount to move platform (could also be for for velocity)
    
    // Moves in clockwise:
    switch state {
      
    case .up:
      if isTooFarUp {
        state = .right
        fallthrough
      } else { node.position.y += amount }
      
    case .right:
      if isTooFarRight {
        state = .down
        fallthrough
      } else { node.position.x += amount }
      
    case .down:
      if isTooFarDown {
        state = .left
        fallthrough
      } else { node.position.y -= amount }
      
    case .left:
      if isTooFarLeft {
        state = .up
        fallthrough
      } else { node.position.x -= amount }
      
    default:
      print("this is not really a default, just a restarting of the loop :)")
      node.position.y += amount
    }
  }
}
