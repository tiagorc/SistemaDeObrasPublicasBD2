//
//  DistrictModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 14/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class DistrictModel: NSObject, NSCoding {
    var id: Int!
    var districtDescription: String!
    
    
    init(id: Int, bairro: String) {
        self.id = id
        self.districtDescription = bairro
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "idbairro") as! Int
        let bairro = aDecoder.decodeObject(forKey: "bairro") as! String
        
        self.init(id: id, bairro: bairro)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "idbairro")
        aCoder.encode(districtDescription, forKey: "bairro")
    }
}
