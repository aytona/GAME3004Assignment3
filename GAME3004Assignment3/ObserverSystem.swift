//
//  ObserverSystem.swift
//  GAME3004Assignment3
//
//  Created by Carlo Albino on 2017-03-14.
//  Copyright © 2017 Christopher Aytona. All rights reserved.
//

import Foundation

protocol Observable
{
    func Attach(_ observer: Observer) -> Int
    func Detach(_ observer: Observer)
    func Notify()
    func Notify(_ msg: ObservableMsg)
    
    func SetName(_ name: String)
    func GetName() -> String
}

protocol Observer
{
    func Call(_ observable: Observable)
        func Call(_ observable: Observable, _ msg: ObservableMsg)
    func SetKey(_ key: Int, _ observable: Observable)
    func GetKey(_ observable: Observable) -> Int
}

public class ObservableMsg
{
    
}
