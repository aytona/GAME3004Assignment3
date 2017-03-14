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
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    private var button : Button?
    private var button1 : Button?
    
    private let obs1 = ObserverTestObject()
    private let obs2 = ObserverTestObject()
    private let obs3 = ObserverTestObject()
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        button = Button(150, 50)
        button?.SetTimer(3)
        self.addChild(button!)
        button?.SetName("Spaceship button")
        
        button1 = Button(150, 100)
        button1?.SetTimer(3)
        self.addChild(button1!)
        button1?.SetName("Other button")
        button1?.position.y = (button1?.position.y)! - 200
        
        obs1.name = "one"
        obs2.name = "two"
        obs3.name = "three"
        
        obs1.SetKey((button?.Attach(obs1))!, button!)
        obs2.SetKey((button?.Attach(obs2))!, button!)
        obs3.SetKey((button?.Attach(obs3))!, button!)
        
        obs1.SetKey((button1?.Attach(obs1))!, button1!)
        obs2.SetKey((button1?.Attach(obs2))!, button1!)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
        
        if(button?.InBounds(pos))!
        {
            print("Button 0 pressed")
        }
        
        if(button1?.InBounds(pos))!
        {
            print("Button 1 pressed")
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
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
