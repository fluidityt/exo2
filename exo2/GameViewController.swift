//
//  GameViewController.swift
//  exo2
//
//  Created by justin fluidity on 9/27/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

/*
 
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
 
 private var state: MovingDirection = .up
 
 @GKInspectable var startingDirection: String = "down"
 
 @GKInspectable var uniqueName: String = "default"
 
 @GKInspectable var xPathSize: CGFloat = 200
 
 @GKInspectable var yPathSize: CGFloat = 400
 
 private lazy var startingPos: CGPoint = { self.node.position }()
 
 // Start at top right, moving clockwise:
 // private var isTooFarRight: Bool { return self.node.position.x > (self.startingPos.x + self.xPathSize) }
 private var isTooFarDown: Bool { return self.node.position.y < (self.startingPos.y - self.yPathSize) }
 //private var isTooFarLeft: Bool { return self.node.position.x < self.startingPos.x }
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
 state = .down //.right
 fallthrough
 } else { node.position.y += amount }
 /*
 case .right:
 if isTooFarRight {
 state = .down
 fallthrough
 } else { node.position.x += amount }
 */
 case .down:
 if isTooFarDown {
 state = .up //.left
 fallthrough
 } else { node.position.y -= amount }
 /*
 case .left:
 if isTooFarLeft {
 state = .up
 // goto: start (lol)
 } else { node.position.x -= amount }
 */
 default: node.position.y += amount
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

 */
