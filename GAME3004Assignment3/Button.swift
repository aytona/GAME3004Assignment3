//
//  Button.swift
//  GAME3004Assignment3
//
//  Created by Tech on 2017-03-13.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Button: SKSpriteNode
{
    var m_width : CGFloat
    var m_height: CGFloat
    var m_timer : Double
    var m_currentTime : Double
    var m_startTimer : Bool
    var m_timerAction : SKAction?
    
    init(_ w: Float, _ h: Float)
    {
        let tempTexture = SKTexture(imageNamed: "Spaceship")
        m_width = CGFloat(w)
        m_height = CGFloat(h)
        m_timer = 0.0
        m_currentTime = m_timer
        m_startTimer = false
        
        super.init(texture: tempTexture, color : UIColor.clear, size : CGSize(width: CGFloat(w), height: CGFloat(h)))
        self.anchorPoint = CGPoint(x: 0, y: 0)

    
    }
    
    public func InBounds(_ point: CGPoint)-> Bool
    {
        if(point.x >= self.position.x && point.x <= self.position.x + m_width
            && point.y >= self.position.y && point.y <= self.position.y + m_height )
        {
            //m_timerAction = SKAction.wait(forDuration: m_timer)
            m_timerAction = SKAction.wait(forDuration: m_timer)
            self.run(m_timerAction!)
            {
                print("Test")
            }
            return true
        }
        else
        {
            return false
        }
    }
    
    public func SetTimer(_ time: Double) {
        self.m_timer = time;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if (self.InBounds(t.location(in: parent!))) {
                //self.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                // change button here
                m_startTimer = true

            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            if (!self.InBounds(t.location(in: parent.self!))) {
                m_startTimer = false
                m_timerAction = SKAction.stop()
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

