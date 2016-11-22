//
//  HoleModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 31/10/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class HoleModel: NSObject, NSCoding {
    var id: Int!
    var holeLenght: String!
    var holeLocation: String!
    var holePriority: String!
    var holeLongitude: String!
    var holeLatitude: String!
    
    
    init(id: Int, tamanho: String, localizacao: String, prioridade: String, long: String, lat: String){
        self.id = id
        self.holeLenght = tamanho
        self.holeLocation = localizacao
        self.holePriority = prioridade
        self.holeLongitude = long
        self.holeLatitude = lat
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "idburaco") as! Int
        let tamanho = aDecoder.decodeObject(forKey: "tamanho") as! String
        let localizacao = aDecoder.decodeObject(forKey: "localizacao") as! String
        let prioridade = aDecoder.decodeObject(forKey: "prioridade") as! String
        let long = aDecoder.decodeObject(forKey: "long") as! String
        let latitude = aDecoder.decodeObject(forKey: "lat") as! String
        
        self.init(id: id, tamanho: tamanho, localizacao: localizacao, prioridade: prioridade, long: long, lat: latitude)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "idburaco")
        aCoder.encode(holeLenght, forKey: "tamanho")
        aCoder.encode(holeLocation, forKey: "localizacao")
        aCoder.encode(holePriority, forKey: "prioridade")
        aCoder.encode(holeLongitude, forKey: "long")
        aCoder.encode(holeLatitude, forKey: "lat")
    }
}
