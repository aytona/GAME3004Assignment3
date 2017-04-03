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

public class Player : SKSpriteNode
{
    var Health : Int
    var PlayerID : Int
    var Wins : Int
    var Losses : Int
    
    init (_ _playerID: Int, _ _texturePrefab : SKTexture)
    {
        Health = 5
        Wins = 0
        Losses = 0
        self.PlayerID = _playerID
        super.init(texture: _texturePrefab)
        if (self.PlayerID == 0) {
            
        } else {
            
        }
    }
    

    
    public func GetHealth() -> Int {
        return self.Health
    }
    
    
}
