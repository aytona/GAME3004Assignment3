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
                    //print("There is no default")
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
                        Player1Shape.xScale = 3
                        Player1Shape.yScale = 3
                        //p1Touched = true
                        Player1Shape.run(p1ButtonScale)
                    }
                    else if (msg as! ButtonMsgPacket).GetMsgType() == .touchEnded
                    {
                        // Remove visuals
                        self.SetReady(1, false)
                        //p1Touched = false
                        Player1Shape.xScale = 0
                    }
                case "Player2Start":
                    if(msg as! ButtonMsgPacket).GetMsgType() == .touchBegan
                    {
                        // Show visuals
                        Player2Shape.xScale = 3
                        Player2Shape.yScale = 3
                        //p2Touched = true
                        Player2Shape.run(p2ButtonScale)
                    }
                    else if (msg as! ButtonMsgPacket).GetMsgType() == .touchEnded
                    {
                        // Remove visuals
                        self.SetReady(2, false)
                        //p2Touched = false
                        Player2Shape.xScale = 0
                    }
                default:
                    //print("There is no default")
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
    
    private var Player1Button : SKNode?
    private var Player2Button : SKNode?
    private let Player1Shape : SKShapeNode = SKShapeNode(circleOfRadius: 100)
    private let Player2Shape : SKShapeNode = SKShapeNode(circleOfRadius: 100)
    private var p1Touched = false
    private var p2Touched = false
    private let p1ButtonScale = SKAction.scale(to: 1.1, duration: 1)
    private let p2ButtonScale = SKAction.scale(to: 1.1, duration: 1)
    
    private var p1Ready = false;
    private var p2Ready = false;
    private var ReadyLabel1 : SKLabelNode?
    private var ReadyLabel2 : SKLabelNode?
    
    private var scene : SKScene?
    
    public func SetupMainMenu(_ _scene: SKScene)
    {
        scene = _scene
        Instruct1 = _scene.childNode(withName: "//Parent//Inst1")
        Instruct2 = _scene.childNode(withName: "//Parent//Inst2")
        BubbleArray.append(Instruct1!)
        BubbleArray.append(Instruct2!)
        HideBubble(0)
        HideBubble(1)
        
        Player1Button = _scene.childNode(withName: "//Parent//Player1Start")
        Player1Shape.lineWidth = 5
        Player1Shape.glowWidth = 5
        Player1Shape.strokeColor = #colorLiteral(red: 1, green: 0.3525168598, blue: 0.06298581511, alpha: 1)
        Player1Button?.addChild(Player1Shape)
        Player1Shape.xScale = 0
        Player1Shape.position = CGPoint(x: 0, y: 0)
        
        Player2Button = _scene.childNode(withName: "//Parent//Player2Start")
        Player2Shape.lineWidth = 5
        Player2Shape.glowWidth = 5
        Player2Shape.strokeColor = #colorLiteral(red: 0.1322018504, green: 0.6908912063, blue: 0.897411108, alpha: 1)
        Player2Button?.addChild(Player2Shape)
        Player2Shape.xScale = 0
        Player2Shape.position = CGPoint(x: 0, y: 0)
        
        ReadyLabel1 = (_scene.childNode(withName: "//Parent//Player1Start//ReadyLabel") as! SKLabelNode)
        ReadyLabel2 = (_scene.childNode(withName: "//Parent//Player2Start//ReadyLabel") as! SKLabelNode)
        
        SetFont()
        
    }
    
    private func SetFont()
    {
        let _ = (scene?.childNode (withName: "//Parent//Inst1//InstructBubble1//InstLabel1") as! SKLabelNode).fontName = "kenvector-future-thin"
        let _ = (scene?.childNode (withName: "//Parent//Inst1//InstructBubble1//InstLabel2") as! SKLabelNode).fontName = "kenvector-future-thin"
        let _ = (scene?.childNode (withName: "//Parent//Inst1//InstructBubble1//InstTitle") as! SKLabelNode).fontName = "kenvector-future-thin"
        let _ = (scene?.childNode (withName: "//Parent//Inst2//InstructBubble2//InstLabel1") as! SKLabelNode).fontName = "kenvector-future-thin"
        let _ = (scene?.childNode (withName: "//Parent//Inst2//InstructBubble2//InstLabel2") as! SKLabelNode).fontName = "kenvector-future-thin"
        let _ = (scene?.childNode (withName: "//Parent//Inst2//InstructBubble2//InstTitle") as! SKLabelNode).fontName = "kenvector-future-thin"
    }
    
    public func SetReady(_ player: Int, _ state: Bool)
    {
        switch(player)
        {
        case 1:
            p1Ready = state
            if(state == true)
            {
                ReadyLabel1?.text = "READY!"
            }
            else
            {
                ReadyLabel1?.text = "Hold To Start"
            }
            break
        case 2:
            p2Ready = state
            if(state == true)
            {
                ReadyLabel2?.text = "READY!"
            }
            else
            {
                ReadyLabel2?.text = "Hold To Start"
            }
            break
        default:
            break
        }
        
        if(p1Ready && p2Ready)
        {
            StartGame()
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

    }
}
