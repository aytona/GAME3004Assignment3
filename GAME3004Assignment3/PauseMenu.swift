//
//  PauseMenu.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-15.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation
import SpriteKit

class PauseMenu : Observer
{
    // Observer functionality
    private var m_keys = [String: Int]()
    private var m_observableCount : Int = 0
    
    var name : String = ""
    
    func Call(_ observable: Observable)
    {
        for (n, _) in m_keys
        {
            if(n == observable.GetName())
            {
                // Do stuff when notified, by an observable object, here:
                if(isShowing)
                {
                    HideMenu()
                }
                else
                {
                    ShowMenu()
                }
            }
        }
        
    }
    
    func SetKey(_ key: Int, _ observable: Observable)
    {
        m_keys[observable.GetName()] = key
    }
    
    func GetKey(_ observable: Observable) -> Int
    {
        for (name, key) in m_keys
        {
            if(name == observable.GetName())
            {
                return key
            }
        }
        return -1
    }
    
    // Pause Menu functionality
    private var isShowing = false
    private var pauseMenu : SKNode?
    
    public func SetupPauseMenu(_ scene: SKScene)
    {
        pauseMenu = scene.childNode(withName: "//UI_PauseMenu")
        HideMenu()
    }
    
    public func ShowMenu()
    {
        isShowing = true
        pauseMenu?.position = CGPoint(x: 0, y: 0)
    }
    
    public func HideMenu()
    {
        isShowing = false
        pauseMenu?.position = CGPoint(x: 2000, y: 2000)
    }
}
