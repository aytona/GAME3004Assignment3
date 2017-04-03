//
//  MainMenu.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-17.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameKit

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
                        SetReady(1, true)
                    case "Player2Start":
                        SetReady(2, true)
                default:
                    print("There is no default")
                    break
                }
            }
        }
        
    }
    
    func Call(_ observable: Observable, _ msg: ObservableMsg)
    {
        for (n, _) in m_keys
        {
            if(n == observable.GetName())
            {
                switch(n) {
                case "Player1Start":
                    if(msg as! ButtonMsgPacket).GetMsgType() == .touchBegan
                    {
                        // Show visuals
                    }
                    else if (msg as! ButtonMsgPacket).GetMsgType() == .touchEnded
                    {
                        // Show visuals
                        self.SetReady(1, false)
                    }
                case "Player2Start":
                    if(msg as! ButtonMsgPacket).GetMsgType() == .touchBegan
                    {
                        // Show visuals
                    }
                    else if (msg as! ButtonMsgPacket).GetMsgType() == .touchEnded
                    {
                        // Show visuals
                        self.SetReady(2, false)
                    }
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
    
    private var p1Ready = false;
    private var p2Ready = false;
    
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
    
    public func SetReady(_ player: Int, _ state: Bool)
    {
        switch(player)
        {
        case 1:
            p1Ready = state
            break
        case 2:
            p2Ready = state
            break
        default:
            break
        }
    }
    
    public func StartGame() {
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
    
    public func Update()
    {
        if(p1Ready && p2Ready)
        {
            StartGame()
        }
    }
}
