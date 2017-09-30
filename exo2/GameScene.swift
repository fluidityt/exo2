//
//  GameScene.swift
//  exo2
//
//  Created by justin fluidity on 9/27/17.
//  Copyright © 2017 justin fluidity. All rights reserved.
//

    import SpriteKit
    import GameplayKit


    // Workaround to not having any references to the scene off top my head..
    // Simply add `gScene = self` in your didMoveToViews... or add a base scene and `super.didMoveToView()`
    var gScene = GameScene()

    class GameScene: SKScene {
      
      override func didMove(to view: SKView) {
        gScene = self
      }
      
      // initialized in GVC.swift
      var gkScene: GKScene!
      
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







