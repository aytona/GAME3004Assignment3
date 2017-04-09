//
//  ParticleEmitter.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-04-09.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class ParticleEmitter: SKNode
{
    var attackEmitter : SKEmitterNode?
    var dodgeEmitter : SKEmitterNode?
    var hitEmitter : SKEmitterNode?
    var dizzyEmitter : SKEmitterNode?
    
    var attackSpawnDistance : CGFloat
    
    init(_ spriteHeight : CGFloat)
    {
        attackSpawnDistance = spriteHeight/2
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        attackSpawnDistance = 100
        
        super.init()
    }
    
    public func AttackParticles()
    {
        print("Particles: Attack")
        attackEmitter = SKEmitterNode(fileNamed: "BattleAttack.sks")
        attackEmitter?.position = CGPoint(x: 0, y: 0)
        attackEmitter?.targetNode = self
        self.addChild(attackEmitter!)
        attackEmitter?.position.y = (attackEmitter?.position.y)! + attackSpawnDistance
        
        let wait = SKAction.wait(forDuration: 1.2)
        self.run(wait)
        {
            self.attackEmitter?.removeFromParent()
            print("Removing particles")
        }
    }
    
    public func DodgeParticles(_ direction : CGFloat)
    {
        print("Particles: Dodge")
        dodgeEmitter = SKEmitterNode(fileNamed: "BattleDodge.sks")
        dodgeEmitter?.position = CGPoint(x: 0, y: 0)
        dodgeEmitter?.targetNode = self
        self.addChild(dodgeEmitter!)
        
        if(direction < 0)
        {
            dodgeEmitter?.zRotation = 180
        }
        
        let wait = SKAction.wait(forDuration: 0.5)
        self.run(wait)
        {
            self.dodgeEmitter?.removeFromParent()
        }
    }
    
    public func HitParticles()
    {
        print("Particles: Hit")
        hitEmitter = SKEmitterNode(fileNamed: "BattleHit.sks")
        hitEmitter?.position = CGPoint(x: 0, y: 0)
        hitEmitter?.targetNode = self
        self.addChild(hitEmitter!)
        
        let wait = SKAction.wait(forDuration: 0.7)
        self.run(wait)
        {
            self.hitEmitter?.removeFromParent()
        }
    }
    
    public func DizzyParticles()
    {
        print("Particles: Dizzy")
        dizzyEmitter = SKEmitterNode(fileNamed: "BattleDizzy.sks")
        dizzyEmitter?.position = CGPoint(x: 0, y: 0)
        dizzyEmitter?.targetNode = self
        self.addChild(dizzyEmitter!)
        
        let wait = SKAction.wait(forDuration: 1.7)
        self.run(wait)
        {
            self.dizzyEmitter?.removeFromParent()
        }
    }
}
