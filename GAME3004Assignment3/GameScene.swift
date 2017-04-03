//
//  GameScene.swift
//  GAME3004Assignment3
//
//  Created by Christopher Aytona on 2017-03-11.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: Scene {
    private var pauseButton : Button?
    private var restartButton : Button?
    private var quitButton : Button?
    
    // To demo game over screen
    private let pauseMenu = PauseMenu()
    private var gameOverOverlay : SKNode?
    
    override func didMove(to view: SKView) {
        // Set up pause button and menu
        pauseButton = (self.childNode(withName: "//UI_Other//Pause") as! Button)
        pauseButton?.SetName("Pause")
        restartButton = (self.childNode(withName: "//Parent//UI_PauseMenu//PausePanel//RestartButton") as! Button)
        restartButton?.SetName("Restart")
        quitButton = (self.childNode(withName: "//Parent//UI_PauseMenu//PausePanel//QuitButton") as! Button)
        quitButton?.SetName("Quit")
        
        pauseMenu.name = "PauseMenu"
        pauseMenu.SetupPauseMenu(self)
        pauseMenu.SetKey((pauseButton?.Attach(pauseMenu))!, pauseButton!)
        pauseMenu.SetKey((restartButton?.Attach(pauseMenu))!, restartButton!)
        pauseMenu.SetKey((quitButton?.Attach(pauseMenu))!, quitButton!)
        
        // Clean up UI visuals
        let UIVisuals = UIVisualController(self)
        UIVisuals.SetupUI()
        
        gameOverOverlay = self.childNode(withName: "//UI_GameOverMenu")
        gameOverOverlay?.xScale = 0
        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        gameOverOverlay?.xScale = 1
        
        if(pos.y > 0)
        {
            gameOverOverlay?.zRotation = CGFloat(M_PI)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        gameOverOverlay?.xScale = 0
        gameOverOverlay?.zRotation = 0
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
