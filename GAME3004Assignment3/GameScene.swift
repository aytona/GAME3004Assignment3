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
    private var pauseButton : Button?
    private let pauseMenu = PauseMenu()
    
    override func didMove(to view: SKView) {
        // Set up pause button and menu
        pauseButton = (self.childNode(withName: "//UI_Other//Pause") as! Button)
        pauseButton?.SetName("Pause")
        pauseMenu.name = "PauseMenu"
        pauseMenu.SetupPauseMenu(self)
        pauseMenu.SetKey((pauseButton?.Attach(pauseMenu))!, pauseButton!)
        
        // Clean up UI visuals
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
