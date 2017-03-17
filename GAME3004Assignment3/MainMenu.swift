//
//  MainMenu.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-17.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenu : Observer
{
    // Observer functionality
    private var m_keys = [String: Int]()
    private var m_observableCount : Int = 0
    
    var name : String = ""
    
    func Call(_ observable: Observable)
    {
        for (n, _) in m_keys
        {
            if(n == observable.GetName())
            {
                switch(n) {
                    case "Instructions1":
                        ToggleButton(0)
                    case "Instructions2":
                        ToggleButton(1)
                    case "Player1Start":
                        StartGame();
                    case "Player2Start":
                        StartGame();
                default:
                    print("There is no default")
                    break
                }
            }
        }
        
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
    private var Instruct1 : SKNode?
    private var Instruct2 : SKNode?
    private var BubbleArray = [SKNode]()
    private var ToggleArray = [false, false]
    private var ButtonName = ["//X", "//Y"]
    
    private var scene : SKScene?
    
    public func SetupMainMenu(_ _scene: SKScene)
    {
        scene = _scene
        Instruct1 = _scene.childNode(withName: "//Parent//Instructions1//InstructBubble1")
        Instruct2 = _scene.childNode(withName: "//Parent//Instructions2//InstructBubble2")
        BubbleArray.append(Instruct1!)
        BubbleArray.append(Instruct2!)
        HideBubble(0)
        HideBubble(1)
        
    }
    
    public func StartGame() {
        if let view = scene?.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                scene.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
    }
    
    public func ShowBubble(_ index: Int)
    {
        BubbleArray[index].xScale = 1
        BubbleArray[index].yScale = 1
        BubbleArray[index].childNode(withName: ButtonName[index])?.zRotation = 0
    }
    
    public func HideBubble(_ index: Int)
    {
        BubbleArray[index].xScale = 0
        BubbleArray[index].yScale = 0
        BubbleArray[index].childNode(withName: ButtonName[index])?.zRotation = 0.785398 // in RADIANS! 
    }
    
    private func ToggleButton(_ index: Int) {
        ToggleArray[index] = !ToggleArray[index]
        if ToggleArray[index] {
            ShowBubble(index)
        } else {
            HideBubble(index)
        }
    }
}
