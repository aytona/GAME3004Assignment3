//
//  GameManager.swift
//  GAME3004Assignment3
//
//  Created by Tech on 2017-04-10.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import Accelerate

enum GameState {
    case Default
    case GameOver
    case Pause
}

public class GameManager {
    
    var Players : (p1: Player, p2: Player)
    var StaminaBars : (p1: SKSpriteNode, p2: SKSpriteNode)
    var HealthStars : (p1: Array<Any>, p2: Array<Any>)? = nil
    var CurrentGameState : GameState
    
    init(_ _player1: Player, _ _player2: Player, _ _StaminaP1: SKSpriteNode, _ _StaminaP2: SKSpriteNode, _ _HealthBarP1: SKSpriteNode, _ _HealthBarP2: SKSpriteNode) {
        self.Players.p1 = _player1
        self.Players.p2 = _player2
        self.StaminaBars.p1 = _StaminaP1
        self.StaminaBars.p2 = _StaminaP2
        self.CurrentGameState = GameState.Default
        
        for star in 0...2 {
            self.HealthStars?.p1.append(_HealthBarP1.childNode(withName: "Star" + String(star)) as! SKSpriteNode)
        }
        
        for star in 0...2 {
            self.HealthStars?.p2.append(_HealthBarP2.childNode(withName: "Star" + String(star)) as! SKSpriteNode)
        }
    }
    
    public func EndGame() {
        if self.Players.p1.GetHealth() <= 0 {
            CurrentGameState = GameState.GameOver
        } else if self.Players.p2.GetHealth() <= 0 {
            CurrentGameState = GameState.GameOver
        }
    }
    
    public func GameUpdate() {
        if self.CurrentGameState != GameState.GameOver {
            PlayerStates()
            UpdateStamina()
            UpdateHealth()
        }
        if self.CurrentGameState != GameState.Pause {
            EndGame()
        }
    }
    
    private func PlayerStates() {
        if self.Players.p1.GetPlayerState() == PlayerState.Attacking && self.Players.p2.GetPlayerState() != PlayerState.Dodging {
            self.Players.p2.HitPlayer()
        }
        if self.Players.p2.GetPlayerState() == PlayerState.Attacking && self.Players.p1.GetPlayerState() != PlayerState.Dodging {
            self.Players.p1.HitPlayer()
        }
    }
    
    private func UpdateStamina() {
        self.StaminaBars.p1.yScale = CGFloat(self.Players.p1.GetHealth()) / CGFloat(100)
        self.StaminaBars.p2.yScale = CGFloat(self.Players.p2.GetHealth()) / CGFloat(100)
    }
    
    private func UpdateHealth() {
        if self.Players.p1.GetHealth() < (self.HealthStars?.p1.count)! {
            (self.HealthStars?.p1.last as! SKSpriteNode).removeFromParent()
            self.HealthStars?.p1.removeLast()
        }
        if self.Players.p2.GetHealth() < (self.HealthStars?.p2.count)! {
            (self.HealthStars?.p2.last as! SKSpriteNode).removeFromParent()
            self.HealthStars?.p2.removeLast()
        }
    }
}
