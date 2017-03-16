//
//  GameScene.swift
//  GAME3004Assignment3
//
//  Created by Christopher Aytona on 2017-03-11.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var restartButton : Button?
    
    private let obs1 = ObserverTestObject()
    private let obs2 = ObserverTestObject()
    private let obs3 = ObserverTestObject()
    
    override func didMove(to view: SKView) {
        restartButton = (self.childNode(withName: "//Player1//Panda") as! Button)
        restartButton?.SetName("Panda")
        restartButton?.SetTimer(3)
        
        obs1.name = "one"
        obs2.name = "two"
        obs3.name = "three"
        
        //obs1.SetKey((button?.Attach(obs1))!, button!)
        //obs2.SetKey((button?.Attach(obs2))!, button!)
        //obs3.SetKey((button?.Attach(obs3))!, button!)
        
        obs1.SetKey((restartButton?.Attach(obs1))!, restartButton!)
        obs2.SetKey((restartButton?.Attach(obs2))!, restartButton!)
        
        let UIVisuals = UIVisualController(self)
        UIVisuals.SetupUI()
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered

    }
}
