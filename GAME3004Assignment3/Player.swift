//
//  Player.swift
//  GAME3004Assignment3
//
//  Created by Tech on 2017-04-03.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import Accelerate

enum PlayerState {
    case Attacking
    case Dodging
    case Default
}

class Player : UIObservable
{
    var Health : Int
    var PlayerID : Int
    var Record : (win: Int,loss: Int)
    
    var startPoint : CGPoint
    var endPoint: CGPoint
    
    var currentState: PlayerState
    
    init(_ _texture: SKTexture, _ _playerID: Int) {
        self.Health = 5
        self.PlayerID = _playerID
        self.Record = (0, 0)
        self.startPoint = CGPoint(x: 0,y: 0)
        self.endPoint = CGPoint(x: 0, y: 0)
        self.currentState = PlayerState.Default
        super.init(texture : _texture, color : UIColor.white, size : CGSize(width: 25, height: 25))
        
        if self.PlayerID == 0 {
            self.anchorPoint = CGPoint(x: 0, y: -25)
        } else {
            self.anchorPoint = CGPoint(x: 0, y: 25)
        }
            
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Health = 5
        self.PlayerID = 0
        self.Record = (0, 0)
        self.startPoint = CGPoint(x: 0,y: 0)
        self.endPoint = CGPoint(x: 0, y: 0)
        self.currentState = PlayerState.Default
        
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }

    public func GetHealth() -> Int {
        return self.Health
    }
    
    public func GetRecord() -> (Int, Int) {
        return self.Record
    }
    
    public func GetPlayerState() ->PlayerState {
        return self.currentState
    }
    
    private func ProcessMove() {
        let magPoint = VectorMagnitude(a: self.startPoint, b: self.endPoint)
        if self.startPoint.x / magPoint > 0 {
            self.currentState = PlayerState.Dodging
        } else if self.startPoint.x / magPoint < 0 {
            self.currentState = PlayerState.Dodging
        } else {
            self.currentState = PlayerState.Attacking
        }
    }
    
    private func MoveSprite(direction: CGFloat) {
        
    }
    
    private func VectorMagnitude(a: CGPoint, b: CGPoint) -> CGFloat {
        let aDist = a.x - b.x
        let bDist = a.y - b.y
        return CGFloat(sqrt(aDist * aDist) + (bDist * bDist))
    }
    
    func touchDown(atPoint pos : CGPoint) {
        self.startPoint = pos
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.endPoint = pos
        if self.currentState == PlayerState.Default {
            ProcessMove()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchDown(atPoint: t.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            self.touchUp(atPoint: t.location(in: self))
        }
    }
    
}
