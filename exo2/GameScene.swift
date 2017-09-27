//
//  GameScene.swift
//  exo2
//
//  Created by justin fluidity on 9/27/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import SpriteKit
import GameplayKit

var gScene = GameScene()

fileprivate enum MovingDirection: String { case up, down, left, right }

class Platforms_BoxPathComponent: GKComponent {
  
  private var node: SKSpriteNode!
  
  private var state: MovingDirection = .right
  
  @GKInspectable var startingDirection: String = "down"
  
  @GKInspectable var uniqueName: String = "default"
  
  @GKInspectable var xPathSize: CGFloat = 200
  
  @GKInspectable var yPathSize: CGFloat = 400
  
  private lazy var startingPos: CGPoint = { self.node.position }()
  
  // Start at top right, moving clockwise:
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
    if node == nil { node = gScene.childNode(withName: uniqueName) as! SKSpriteNode }
    
    let amount: CGFloat = 1
    
    // Start at top left, moving clockwise:
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
      print("and xcode said i will never be exectured")
      node.position.y += amount
    }
    
  }
  
}

class GameScene: SKScene {

  override func didMove(to view: SKView) {
    gScene = self
  }
  
  var entities = [GKEntity]()
  var graphs = [String : GKGraph]()
  
  private var lastUpdateTime : TimeInterval = 0
  
  
  func gkUpdate(_ currentTime: TimeInterval) -> TimeInterval {
    if (self.lastUpdateTime == 0) {
      self.lastUpdateTime = currentTime
    }
    
    let dt = currentTime - self.lastUpdateTime
    
    for entity in self.entities {
      entity.update(deltaTime: dt)
    }
    
    return currentTime
  }
  
  override func update(_ currentTime: TimeInterval) {
    self.lastUpdateTime = gkUpdate(currentTime)
    
  }
}
