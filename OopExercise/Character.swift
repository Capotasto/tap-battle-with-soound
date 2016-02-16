//
//  Character.swift
//  OopExercise
//
//  Created by Norio Egi on 2/10/16.
//  Copyright © 2016 Capotasto. All rights reserved.
//

import Foundation

class Character {
    private var _hp: Int = 100
    private var _attackPwr: Int = 10
    private var _name: String = "name"
    
    var hp:Int {
        get {
            return _hp
        }
        
    }
    var attackPwr: Int {
        get{
            return _attackPwr
        }
    }
    
    var isAlive: Bool{
        
        if 0 < hp {
            return true
        }else{
            return false
        }
    }
    
    var name:String {
        get {
            return _name
        }
        
    }
    
    init(hp:Int, attackPwr: Int, name: String){
        self._hp = hp
        self._attackPwr = attackPwr
        self._name = name
    }
    
    func sufferDamage(attackPwr: Int) -> Bool{
        self._hp -= attackPwr
        return true
    }
}
