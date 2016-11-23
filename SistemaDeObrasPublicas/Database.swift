//
//  Database.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class Database: NSObject {
    func getAllDamages () -> [DamageModel] {
        var damages: [DamageModel] = []
        
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "danos")  {
            let d = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [DamageModel]
            damages = d
        }
        
        return damages
    }
    
    func getAllHoles() -> [HoleModel]{
        var buracos: [HoleModel] = []
        
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "buracos")  {
            let b = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [HoleModel]
            buracos = b
        }
        
        return buracos
    }
    
    func getAllUsers() -> [UserModel] {
        
        var users: [UserModel] = []
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "users")  {
            let u = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [UserModel]
            users = u
        }
        return users
    }
    
    func getAllMaintenceTeams() -> [MaintenceModel] {
        var mtm: [MaintenceModel] = []
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "maintences")  {
            let mt = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [MaintenceModel]
            mtm = mt
        }
        return mtm
    }
    
    func getAllOSs() -> [OSModel] {
        var oss: [OSModel] = []
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "oss")  {
            let os = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [OSModel]
            oss = os
        }
        return oss
    }
}
