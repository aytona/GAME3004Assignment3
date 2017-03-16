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

class Button: UIObservable
{
    var m_timer : Double
    var m_timerAction : SKAction?
    
    init(_ _texture: SKTexture, _ w: Float, _ h: Float)
    {
        m_timer = 0.0
        
        super.init(texture: _texture, color : UIColor.white, size : CGSize(width: CGFloat(w), height: CGFloat(h)))
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        m_timer = 0.0
        
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    public func SetTimer(_ time: Double) {
        self.m_timer = time;
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Touch Began", self.name!)
        m_timerAction = SKAction.wait(forDuration: m_timer)
        self.run(m_timerAction!)
        {
            self.Notify()
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Touch Moved", self.name!)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Touch Ended", self.name!)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Touch Cancelled", self.name!)
    }
}

