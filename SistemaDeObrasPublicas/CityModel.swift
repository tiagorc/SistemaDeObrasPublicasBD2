//
//  CityModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 14/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CityModel: NSObject, NSCoding {
    var id: Int!
    var cityDescription: String!
    
    init(id: Int, cidade: String) {
        self.id = id
        self.cityDescription = cidade
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "idcidade") as! Int
        let cidade = aDecoder.decodeObject(forKey: "cidade") as! String
        
        self.init(id: id, cidade: cidade)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "idcidade")
        aCoder.encode(cityDescription, forKey: "cidade")
    }
}
