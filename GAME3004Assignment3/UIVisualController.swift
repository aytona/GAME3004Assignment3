//
//  UIVisualController.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-15.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit

class UIVisualController
{
    let scene : SKScene
    var glassPanels : [SKSpriteNode] = []
    var pausePanel : SKSpriteNode?
    var healthBars : [SKSpriteNode] = []
    
    init(_ _scene: SKScene)
    {
        scene = _scene
    }
    
    public func SetupUI()
    {
        SetupFont()
        GetGlassPanels()
        SetGlassPanelRects()
        GetHealthBars()
        SetHealthbarRects()
    }
    
    private func SetupFont()
    {
        let P1Label : SKLabelNode = scene.childNode(withName: "//UI_Player1//Player1Label") as! SKLabelNode
        let P2Label : SKLabelNode = scene.childNode(withName: "//UI_Player2//Player2Label") as! SKLabelNode
        let P1Message : SKLabelNode = scene.childNode(withName: "//UI_Player1//Player1Message") as! SKLabelNode
        let P2Message : SKLabelNode = scene.childNode(withName: "//UI_Player1//Player1Message") as! SKLabelNode
        
        let pauseLabel : SKLabelNode = scene.childNode(withName: "//UI_PauseMenu//PausePanel//PauseLabel") as! SKLabelNode
        let restartButton : SKLabelNode = scene.childNode(withName: "//UI_PauseMenu//PausePanel//RestartButton//Label") as! SKLabelNode
        let quitButton : SKLabelNode = scene.childNode(withName: "//UI_PauseMenu//PausePanel//QuitButton//Label") as! SKLabelNode
        
        P1Label.fontName = "kenpixel-blocks"
        P2Label.fontName = "kenpixel-blocks"
        P1Message.fontName = "kenvector-future-thin"
        P2Message.fontName = "kenvector-future-thin"
        
        pauseLabel.fontName = "kenvector-future-thin"
        restartButton.fontName = "kenpixel-blocks"
        quitButton.fontName = "kenpixel-blocks"
        
    }
    
    private func GetGlassPanels()
    {
        glassPanels.append(scene.childNode(withName: "//UI_Player1//PlayerLabelPanel") as! SKSpriteNode)
        glassPanels.append(scene.childNode(withName: "//UI_Player1//StarPanel") as! SKSpriteNode)
        glassPanels.append(scene.childNode(withName: "//UI_Player1//StaminaPanel") as! SKSpriteNode)
        
        glassPanels.append(scene.childNode(withName: "//UI_Player2//PlayerLabelPanel") as! SKSpriteNode)
        glassPanels.append(scene.childNode(withName: "//UI_Player2//StarPanel") as! SKSpriteNode)
        glassPanels.append(scene.childNode(withName: "//UI_Player2//StaminaPanel") as! SKSpriteNode)
        
        pausePanel = scene.childNode(withName: "//UI_PauseMenu//PausePanel") as? SKSpriteNode
    }
    
    private func SetGlassPanelRects()
    {
        for panel in glassPanels
        {
            panel.centerRect = CGRect(x: 25.0/100.0, y: 25.0/100.0, width: 50.0/100.0, height: 50.0/100.0)
        }
        
        pausePanel?.centerRect = CGRect(x: 25.0/100.0, y: 25.0/100.0, width: 50.0/100.0, height: 50.0/100.0)
    }
    
    private func GetHealthBars()
    {
        healthBars.append(scene.childNode(withName: "//UI_Player1//StaminaFill") as! SKSpriteNode)
        healthBars.append(scene.childNode(withName: "//UI_Player1//StaminaBG") as! SKSpriteNode)
        
        healthBars.append(scene.childNode(withName: "//UI_Player2//StaminaFill") as! SKSpriteNode)
        healthBars.append(scene.childNode(withName: "//UI_Player2//StaminaBG") as! SKSpriteNode)
    }
    
    private func SetHealthbarRects()
    {
        for bar in healthBars
        {
            bar.centerRect = CGRect(x: 25.0/190.0, y: 7.0/49.0, width: 140.0/190.0, height: 35.0/49.0)
        }
    }

}
