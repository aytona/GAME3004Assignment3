//
//  PauseMenu.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-15.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

class PauseMenu : Observer
{
    // Observer functionality
    private var m_keys = [String: Int]()
    private var m_observableCount : Int = 0
    
    var name : String = ""
    
    func Call(_ observable: Observable)
    {
        for (n, _) in m_keys
        {
            // Do stuff when notified, by an observable object, here:
            if(n == observable.GetName())
            {
                switch(n)
                {
                case "Pause":
                    if(isShowing)
                    {
                        HideMenu()
                    }
                    else
                    {
                        ShowMenu()
                    }
                    case "Restart":
                    ResetGame()
                    case "Quit":
                    GoToMenu()
                default:
                    break
                }
            }
        }
        
    }
    
    func Call(_ observable: Observable, _ msg: ObservableMsg)
    {
        
    }
    
    func SetKey(_ key: Int, _ observable: Observable)
    {
        m_keys[observable.GetName()] = key
    }
    
    func GetKey(_ observable: Observable) -> Int
    {
        for (name, key) in m_keys
        {
            if(name == observable.GetName())
            {
                return key
            }
        }
        return -1
    }
    
    // Pause Menu functionality
    private var isShowing = false
    private var pauseMenu : SKNode?
    private var scene : SKScene?
    public func SetupPauseMenu(_ _scene: SKScene)
    {
        scene = _scene
        pauseMenu = _scene.childNode(withName: "//UI_PauseMenu")
        HideMenu()
    }
    
    public func ShowMenu()
    {
        isShowing = true
        pauseMenu?.position = CGPoint(x: 0, y: 0)
    }
    
    public func HideMenu()
    {
        isShowing = false
        pauseMenu?.position = CGPoint(x: 2000, y: 2000)
    }
    
    public func GoToMenu()
    {
        // Load the SKScene from 'GameScene.sks'
        if let scene = GKScene(fileNamed: "StartScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! Scene? {
                
                /// Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.scene?.view {
                    view.presentScene(sceneNode, transition: SKTransition.doorway(withDuration: 1))
                    view.ignoresSiblingOrder = true
                }
            }
        }
    }
    
    public func ResetGame()
    {
        // Load the SKScene from 'GameScene.sks'
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! Scene? {
                
                /// Copy gameplay related content over to the scene
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                
                sceneNode.scaleMode = .aspectFill
                
                // Present the scene
                if let view = self.scene?.view {
                    view.presentScene(sceneNode, transition: SKTransition.doorsCloseVertical(withDuration: 1))
                    view.ignoresSiblingOrder = true
                }
            }
        }
    }
}
