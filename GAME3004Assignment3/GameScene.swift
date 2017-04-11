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
    
    private var gameManager : GameManager?
    
    let sprites = [#imageLiteral(resourceName: "panda"), #imageLiteral(resourceName: "pig"), #imageLiteral(resourceName: "elephant"), #imageLiteral(resourceName: "monkey"), #imageLiteral(resourceName: "parrot"), #imageLiteral(resourceName: "penguin"), #imageLiteral(resourceName: "hippo")]
    
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
        
        gameManager = GameManager(self.childNode(withName: "//Parent/Player1/Panda") as! Player, self.childNode(withName: "//Parent/Player2/Pig") as! Player, self.childNode(withName: "//Parent/UI_Player1/StaminaFill") as! SKSpriteNode, self.childNode(withName: "//Parent/UI_Player2/StaminaFill") as! SKSpriteNode, self.childNode(withName: "//Parent//UI_Player1//HealthStars")!, self.childNode(withName: "//Parent//UI_Player2//HealthStars")!)

        let bgAudio : SKAudioNode = SKAudioNode(fileNamed: "BattleMusic.mp3")
        bgAudio.autoplayLooped = true
        self.addChild(bgAudio)
        
        // Set random sprite
        var rand = Int(arc4random_uniform(UInt32(sprites.count)))
        (self.childNode(withName: "//Parent//Player1//Panda") as! SKSpriteNode).texture = SKTexture(image: sprites[rand])
        rand = Int(arc4random_uniform(UInt32(sprites.count)))
        (self.childNode(withName: "//Parent//Player2//Pig") as! SKSpriteNode).texture = SKTexture(image: sprites[rand])

    }
    
    func GameOver() {
        gameManager?.CurrentGameState = GameState.Pause
        let player1 = self.childNode(withName: "//Parent/Player1/Panda") as! Player
        
        gameOverOverlay?.xScale = 1
        
        if player1.GetHealth() == 0 {
            gameOverOverlay?.zRotation = CGFloat.pi
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
//        gameOverOverlay?.xScale = 1
//        
//        if(pos.y > 0)
//        {
//            gameOverOverlay?.zRotation = CGFloat.pi
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        gameOverOverlay?.xScale = 0
//        gameOverOverlay?.zRotation = 0
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
        gameManager?.GameUpdate()
        if gameManager?.CurrentGameState == GameState.GameOver {
            GameOver()
        }
    }
}
