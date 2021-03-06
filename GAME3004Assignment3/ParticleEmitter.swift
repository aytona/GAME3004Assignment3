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
import AVFoundation

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
        do{
            let sounds:[String] = ["Dizzy", "Dodge", "Attack", "Hit"]
            for sound in sounds
            {
                let path:String = Bundle.main.path(forResource: sound, ofType: "wav")!
                let url:URL = URL(fileURLWithPath: path)
                let player:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        }catch{
            
        }
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        attackSpawnDistance = 100
        do{
            let sounds:[String] = ["Dizzy", "Dodge", "Attack", "Hit"]
            for sound in sounds
            {
                let path:String = Bundle.main.path(forResource: sound, ofType: "wav")!
                let url:URL = URL(fileURLWithPath: path)
                let player:AVAudioPlayer = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
            }
        }catch{
            
        }
        
        super.init()
    }
    
    public func AttackParticles()
    {
//        self.attackEmitter?.removeFromParent()
//        self.removeAction(forKey: "attackWait")
//        
//        attackEmitter = SKEmitterNode(fileNamed: "BattleAttack.sks")
//        attackEmitter?.name = "attackEmitter"
//        attackEmitter?.targetNode = self.parent?.parent
//        self.addChild(attackEmitter!)
//        
//        attackEmitter?.position = CGPoint(x: 0, y: 0)
//        attackEmitter?.position.y = (attackEmitter?.position.y)! + attackSpawnDistance
//        attackEmitter?.zRotation = 0
//        attackEmitter?.particleScale = 0.6
//        
        let sfx = SKAction.playSoundFileNamed("Attack.wav", waitForCompletion: false)
//        let wait = SKAction.wait(forDuration: 1.2)
//        let destroy = SKAction.run(SKAction.removeFromParent()
//            , onChildWithName: (attackEmitter?.name)!)
//        let lifeSequence = SKAction.sequence([sfx, wait, destroy])
        let lifeSequence = SKAction.sequence([sfx])
        self.run(lifeSequence, withKey: "attackWait")
    }
    
    public func DodgeParticles(_ direction : CGFloat)
    {
        self.dodgeEmitter?.removeFromParent()
        self.removeAction(forKey: "dodgeWait")
        
        dodgeEmitter = SKEmitterNode(fileNamed: "BattleDodge.sks")
        dodgeEmitter?.name = "dodgeEmitter"
        dodgeEmitter?.targetNode = self.scene?.childNode(withName: "//Parent")
        self.addChild(dodgeEmitter!)
        
        dodgeEmitter?.position = CGPoint(x: 0, y: 0)
        dodgeEmitter?.zRotation = 0
        
        if(direction < 0)
        {
            dodgeEmitter?.xAcceleration = (dodgeEmitter?.xAcceleration)! * -1
        }
        
        let sfx = SKAction.playSoundFileNamed("Dodge.wav", waitForCompletion: false)
        let wait = SKAction.wait(forDuration: 0.5)
        let destroy = SKAction.run(SKAction.removeFromParent()
            , onChildWithName: (dodgeEmitter?.name)!)
        let lifeSequence = SKAction.sequence([sfx, wait, destroy])
        
        self.run(lifeSequence, withKey: "dodgeWait")
    }
    
    public func HitParticles()
    {
        self.hitEmitter?.removeFromParent()
        self.removeAction(forKey: "hitWait")
        
        hitEmitter = SKEmitterNode(fileNamed: "BattleHit.sks")
        hitEmitter?.name = "hitEmitter"
        hitEmitter?.targetNode = self.scene?.childNode(withName: "//Parent")
        self.addChild(hitEmitter!)
        
        hitEmitter?.position = CGPoint(x: 0, y: 0)
        hitEmitter?.position.y = (hitEmitter?.position.y)! + attackSpawnDistance/2
        hitEmitter?.zRotation = 0
        
        let sfx = SKAction.playSoundFileNamed("Hit.wav", waitForCompletion: false)
        let wait = SKAction.wait(forDuration: 0.7)
        let destroy = SKAction.run(SKAction.removeFromParent()
            , onChildWithName: (hitEmitter?.name)!)
        let lifeSequence = SKAction.sequence([sfx, wait, destroy])
        
        self.run(lifeSequence, withKey: "hitWait")
    }
    
    private var isDizzy : Bool = false
    
    public func DizzyParticles()
    {
        if(!isDizzy)
        {
            self.dizzyEmitter?.removeFromParent()
            self.removeAction(forKey: "dizzyWait")

            isDizzy = true
            dizzyEmitter = SKEmitterNode(fileNamed: "BattleDizzy.sks")
            dizzyEmitter?.name = "dizzyEmitter"
            dizzyEmitter?.targetNode = self.scene?.childNode(withName: "//Parent")
            self.addChild(dizzyEmitter!)
            
            dizzyEmitter?.position = CGPoint(x: 0, y: 0)
            dizzyEmitter?.zRotation = 0
            
            let sfx = SKAction.playSoundFileNamed("Dizzy.wav", waitForCompletion: false)
            let wait = SKAction.wait(forDuration: 3)
            let destroy = SKAction.run(SKAction.removeFromParent()
                , onChildWithName: (dizzyEmitter?.name)!)
            let toggleBool = SKAction.run {
                self.isDizzy = false
            }
            let lifeSequence = SKAction.sequence([sfx, wait, toggleBool, destroy])
            
            self.run(lifeSequence, withKey: "dizzyWait")
        }
    }
}
