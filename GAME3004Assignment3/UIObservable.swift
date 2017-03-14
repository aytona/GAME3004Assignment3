//
//  UIObservable.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-14.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class UIObservable: SKSpriteNode, Observable
{
    private var m_observers = [Int: Observer]()
    private var m_keyGen : Int = 0
    private var m_name : String = ""
    
    func Attach(_ observer: Observer) -> Int
    {
        let key = m_keyGen + 1
        m_keyGen = key
        
        m_observers[key] = observer
        
        return key
    }
    
    func Detach(_ observer: Observer)
    {
        m_observers.removeValue(forKey: observer.GetKey(self))
    }
    
    func Notify()
    {
        for (key, _) in m_observers
        {
            m_observers[key]?.Call(self)
        }
    }
    
    func SetName(_ name: String)
    {
        m_name = name
    }
    
    func GetName() -> String
    {
        return m_name
    }
    
}
