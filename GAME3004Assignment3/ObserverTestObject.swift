//
//  ObserverTestObject.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-14.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation

class ObserverTestObject: Observer
{
    private var m_keys = [String: Int]()
    private var m_observableCount : Int = 0
    
    var name : String = ""
    
    func Call(_ observable: Observable)
    {
        for (n, _) in m_keys
        {
            if(n == observable.GetName())
            {
                print(n + " from " + name);
            }
        }
        
    }
    
    func Call(_ observable: Observable, _ msg: ObservableMsg) {
        
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
}
