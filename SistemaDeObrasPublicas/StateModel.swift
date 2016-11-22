
//  StateModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 14/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class StateModel: NSObject, NSCoding {
    var id: Int!
    var stateDescription: String!
    
    init(id: Int, estado: String) {
        self.id = id
        self.stateDescription = estado
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "idestado") as! Int
        let estado = aDecoder.decodeObject(forKey: "estado") as! String
        
        self.init(id: id, estado: estado)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "idestado")
        aCoder.encode(stateDescription, forKey: "estado")
    }

}
