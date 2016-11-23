//
//  OSModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class OSModel: NSObject, NSCoding {
    var id: Int!
    var abertura: String!
    var fechamento: String
    var equipe: Int!
    var buraco: Int!
    
    init(id: Int, dataAbertura: String, dataFechamento: String, equipe: Int, buraco: Int) {
        self.id = id
        self.abertura = dataAbertura
        self.fechamento = dataFechamento
        self.equipe = equipe
        self.buraco = buraco
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "idos") as! Int
        let abertura = aDecoder.decodeObject(forKey: "abertura") as! String
        let fechamento = aDecoder.decodeObject(forKey: "fechamento") as! String
        let eq = aDecoder.decodeObject(forKey: "eqos") as! Int
        let bu = aDecoder.decodeObject(forKey: "eqbu") as! Int
        
        self.init(id: id, dataAbertura: abertura, dataFechamento: fechamento, equipe: eq, buraco: bu)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "idos")
        aCoder.encode(abertura, forKey: "abertura")
        aCoder.encode(fechamento, forKey: "fechamento")
        aCoder.encode(equipe, forKey: "eqos")
        aCoder.encode(buraco, forKey: "eqbu")
    }
}
