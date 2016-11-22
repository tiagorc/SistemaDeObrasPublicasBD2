//
//  AddressModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 14/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class AddressModel: NSObject, NSCoding {
    var id: Int!
    var addressDescription: String!
    var CEP: String!
    var federativeUnit: String!
    var district: DistrictModel!
    var state: StateModel!
    var city: CityModel!
    
    
    init(id: Int, endereco: String, cep: String, uf: String, bairro: DistrictModel, estado: StateModel, cidade: CityModel) {
        self.id = id
        self.addressDescription = endereco
        self.CEP = cep
        self.federativeUnit = uf
        self.district = bairro
        self.state = estado
        self.city = cidade
        
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "idendereco") as! Int
        let endereco = aDecoder.decodeObject(forKey: "endereco") as! String
        let cep = aDecoder.decodeObject(forKey: "cep") as! String
        let uf = aDecoder.decodeObject(forKey: "uf") as! String
        let bairro = aDecoder.decodeObject(forKey: "bairro") as! DistrictModel
        let estado = aDecoder.decodeObject(forKey: "estado") as! StateModel
        let cidade = aDecoder.decodeObject(forKey: "cidade") as! CityModel
        
        self.init(id: id, endereco: endereco, cep: cep, uf: uf, bairro: bairro, estado: estado, cidade: cidade)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "idendereco")
        aCoder.encode(addressDescription, forKey: "endereco")
        aCoder.encode(CEP, forKey: "cep")
        aCoder.encode(federativeUnit, forKey: "uf")
        aCoder.encode(district, forKey: "bairro")
        aCoder.encode(state, forKey: "estado")
        aCoder.encode(city, forKey: "cidade")
    }
    
}
