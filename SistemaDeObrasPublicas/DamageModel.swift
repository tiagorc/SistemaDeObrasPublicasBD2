//
//  DamageModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class DamageModel: NSObject, NSCoding {
    var id: Int!
    var descricao: String!
    var timestamp: String!
    var valorEstimado: String!
    var idBuraco: Int!
    var idUsuario: Int!
    
    init(id: Int, desc: String, horario: String, valor: String, idb: Int, idu: Int ) {
        self.id = id
        self.descricao = desc
        self.timestamp = horario
        self.valorEstimado = valor
        self.idBuraco = idb
        self.idUsuario = idu
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "iddano") as! Int
        let desc = aDecoder.decodeObject(forKey: "descricaodano") as! String
        let horario = aDecoder.decodeObject(forKey: "horariodano") as! String
        let valor = aDecoder.decodeObject(forKey: "valordano") as! String
        let idburaco = aDecoder.decodeObject(forKey: "danoburaco") as! Int
        let idusuario = aDecoder.decodeObject(forKey: "danousuario") as! Int
        
        self.init(id: id, desc: desc, horario: horario, valor: valor, idb: idburaco, idu: idusuario)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "iddano")
        aCoder.encode(descricao, forKey: "descricaodano")
        aCoder.encode(timestamp, forKey: "horariodano")
        aCoder.encode(valorEstimado, forKey: "valordano")
        aCoder.encode(idBuraco, forKey: "danoburaco")
        aCoder.encode(idUsuario, forKey: "danousuario")
    }
    
}
