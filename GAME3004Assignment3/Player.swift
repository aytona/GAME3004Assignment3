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
    case Exhausted
    case Dead
}

class Player : UIObservable
{
    var Health : Int
    var Stamina : Int
    var PlayerID : Int
    var Record : (win: Int,loss: Int)
    
    var startPoint : CGPoint
    var endPoint: CGPoint
    
    var currentState: PlayerState
    
    var particles : ParticleEmitter?
    
    init(_ _texture: SKTexture, _ _playerID: Int, _ _staminaBar: SKSpriteNode) {
        self.Health = 3
        self.Stamina = 100
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
        
        self.particles = ParticleEmitter(self.size.height)
        self.addChild(particles!)
        self.particles?.position = CGPoint(x: 0, y: 0)
        self.particles?.zRotation = 0
        
        self.PlayerUpdate()
        self.RecoverStamina()
        
        print(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.Health = 3
        self.Stamina = 100
        self.PlayerID = 0
        self.Record = (0, 0)
        self.startPoint = CGPoint(x: 0,y: 0)
        self.endPoint = CGPoint(x: 0, y: 0)
        self.currentState = PlayerState.Default

        super.init(coder: aDecoder)
        
        self.isUserInteractionEnabled = true
        
        self.particles = ParticleEmitter(self.size.height)
        self.addChild(particles!)
        self.particles?.position = CGPoint(x: 0, y: 0)
        self.particles?.zRotation = 0
        
        self.PlayerUpdate()
        self.RecoverStamina()
        
        print(self)
    }
    
    public func GetHealth() -> Int {
        return self.Health
    }
    
    public func GetRecord() -> (Int, Int) {
        return self.Record
    }
    
    public func GetPlayerState() -> PlayerState {
        return self.currentState
    }
    
    public func GetPlayerStamina() -> Int {
        return self.Stamina
    }
    
    public func AddRecord(win: Int, loss: Int) {
        self.Record.win = self.Record.win + win
        self.Record.loss = self.Record.loss + loss
    }
    
    public func HitPlayer() {
        if self.Health - 1 > 0 {
            self.Health = self.Health - 1
            particles?.HitParticles()
        } else {
            self.Health = 0
            self.currentState = PlayerState.Dead
        }
    }
    
    public func SubPlayerStamina(amount: Int) {
        if self.Stamina - amount <= 0 {
            self.Stamina = 0
        } else {
            self.Stamina = self.Stamina - amount
        }
    }
    
    private func ProcessMove() {
        let vectorDistX = self.endPoint.x - self.startPoint.x
        let width = self.size.width / 2
        if vectorDistX - width > 0 {
            self.currentState = PlayerState.Dodging
            DodgeSprite(direction: 1)
        } else if vectorDistX + width < 0 {
            self.currentState = PlayerState.Dodging
            DodgeSprite(direction: -1)
        } else {
            self.currentState = PlayerState.Attacking
            AttackSprite()
        }
    }
    
    private func DodgeSprite(direction: CGFloat) {
        SubPlayerStamina(amount: 20)
        
        var action1 = SKAction()
        action1 = SKAction.move(to: CGPoint(x: self.position.x + direction * 100, y: self.position.y), duration: 0.2)
        var action2 = SKAction()
        action2 = SKAction.move(to: self.position, duration: 0.2)

        let sequence = SKAction.sequence([action1, action2, SKAction.run({ self.BackToDefault() })])

        particles?.DodgeParticles(direction)
        
        self.run(sequence)
    }
    
    private func AttackSprite() {
        SubPlayerStamina(amount: 65)
        
        var action1 = SKAction()
        action1 = SKAction.move(to: CGPoint(x: self.position.x, y: self.position.y + 100), duration: 0.1)
        var action2 = SKAction()
        action2 = SKAction.move(to: self.position, duration: 0.1)
        
        let sequence = SKAction.sequence([action1, action2, SKAction.run({ self.BackToDefault() })])
        
        particles?.AttackParticles()
        
        self.run(sequence, withKey: "attackAnim")
    }
    
    private func ExhaustedSprite() {
        if self.Stamina < 100 {
            let rotate = SKAction.rotate(byAngle: CGFloat(5), duration: 1.0)
            let sequence = SKAction.sequence([rotate, SKAction.run({ self.ExhaustedSprite() })])
            
            self.run(sequence)
            
            particles?.DizzyParticles()
        } else {
            self.run(SKAction.rotate(toAngle: CGFloat(0), duration: 0.1))
        }
    }
    
    private func RecoverStamina() {
        let StaminaHeal = SKAction.run {
            if self.Stamina < 100 {
                if 100 - self.Stamina > 5 {
                    self.Stamina = self.Stamina + 5
                } else {
                    self.Stamina = 100
                }
            }
        }
        
        if self.Stamina > 0 && self.currentState != PlayerState.Exhausted{
            let sequence = SKAction.sequence([StaminaHeal, SKAction.wait(forDuration: 1), SKAction.run({ self.RecoverStamina() })])
            self.run(sequence)
        } else {
            let sequence = SKAction.sequence([StaminaHeal, SKAction.wait(forDuration: 0.1), SKAction.run({ self.RecoverStamina() })])
            self.run(sequence)
        }
    }
    
    private func PlayerUpdate() {
        // Exhausted Check
        //print(self.Stamina)
        var ExhaustedAction = SKAction()
        if self.Stamina <= 0 && self.currentState != PlayerState.Exhausted {
            self.currentState = PlayerState.Exhausted
            ExhaustedAction = SKAction.run {
                self.ExhaustedSprite()
            }
        }
        if self.Stamina == 100 && self.currentState != PlayerState.Dead {
            self.currentState = PlayerState.Default
        }
        
        // Death Check
        //var DeathAction = SKAction()
        if self.Health <= 0 && self.currentState != PlayerState.Dead {
            self.currentState = PlayerState.Dead
        }
        
        let sequence = SKAction.sequence([ExhaustedAction, /*DeathAction,*/ SKAction.wait(forDuration: 0.1), SKAction.run({ self.PlayerUpdate() })])
        
        self.run(sequence)
    }
    
    private func BackToDefault() {
        if self.currentState != PlayerState.Dead || self.Stamina == 100 {
            self.currentState = PlayerState.Default
        }
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
