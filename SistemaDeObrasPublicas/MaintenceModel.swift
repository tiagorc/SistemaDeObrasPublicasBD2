//
//  MaintenceModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class MaintenceModel: NSObject, NSCoding {
    var id: Int!
    var mtname: String!
    var team: [UserModel]!
    
    init(id: Int, mtname: String, t: [UserModel]) {
        self.id = id
        self.mtname = mtname
        self.team = t
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "mtid") as! Int
        let name = aDecoder.decodeObject(forKey: "mtname") as! String
        let team = aDecoder.decodeObject(forKey: "mtteam") as! [UserModel]
        
        self.init(id: id, mtname: name, t: team)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "mtid")
        aCoder.encode(mtname, forKey: "mtname")
        aCoder.encode(team, forKey: "mtteam")
    }

}
