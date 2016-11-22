//
//  UserModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 31/10/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class UserModel: NSObject, NSCoding {
    var id: Int!
    var userName: String!
    var userCPF: String!
    var userIdNumber: String!
    var userIdOrgan: String!
    var userIdFederativeUnit: String!
    var userMothersName: String!
    var userFathersName: String!
    var email: String!
    var naturalidade: String!
    var userCurrentRole: String!
    var estadoCivil: String!
    var addressUser: AddressModel!
    
    init(id: Int, name: String, CPF: String, rg: String, orgaorg: String, ufrg: String, nomemae: String, nomepai: String, email: String, naturalidade: String, cargo: String, estadocivil: String, endereco: AddressModel) {
        self.id = id
        self.userName = name
        self.userCPF = CPF
        self.userIdNumber = rg
        self.userIdOrgan = orgaorg
        self.userIdFederativeUnit = ufrg
        self.userMothersName = nomemae
        self.userFathersName = nomepai
        self.email = email
        self.naturalidade = naturalidade
        self.userCurrentRole = cargo
        self.estadoCivil = estadocivil
        self.addressUser = endereco
    }
    
    required convenience init(coder aDecoder: NSCoder){
        let id = aDecoder.decodeObject(forKey: "iduser") as! Int
        let nome = aDecoder.decodeObject(forKey: "nome") as! String
        let cpf = aDecoder.decodeObject(forKey: "cpf") as! String
        let rg = aDecoder.decodeObject(forKey: "rg") as! String
        let orgaorg = aDecoder.decodeObject(forKey: "orgaorg") as! String
        let ufrg = aDecoder.decodeObject(forKey: "ufrg") as! String
        let nomemae = aDecoder.decodeObject(forKey: "nomemae") as! String
        let nomepai = aDecoder.decodeObject(forKey: "nomepai") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let naturalidade = aDecoder.decodeObject(forKey: "naturalidade") as! String
        let cargo = aDecoder.decodeObject(forKey: "cargo") as! String
        let estadocivil = aDecoder.decodeObject(forKey: "estadocivil") as! String
        let endereco = aDecoder.decodeObject(forKey: "endereco") as! AddressModel
        
        self.init(id: Int(id), name: nome, CPF: cpf, rg: rg, orgaorg: orgaorg, ufrg: ufrg, nomemae: nomemae, nomepai: nomepai, email: email, naturalidade: naturalidade, cargo: cargo, estadocivil: estadocivil, endereco: endereco)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "iduser")
        aCoder.encode(userName, forKey: "nome")
        aCoder.encode(userCPF, forKey: "cpf")
        aCoder.encode(userIdNumber, forKey: "rg")
        aCoder.encode(userIdOrgan, forKey: "orgaorg")
        aCoder.encode(userIdFederativeUnit, forKey: "ufrg")
        aCoder.encode(userMothersName, forKey: "nomemae")
        aCoder.encode(userFathersName, forKey: "nomepai")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(naturalidade, forKey: "naturalidade")
        aCoder.encode(userCurrentRole, forKey: "cargo")
        aCoder.encode(estadoCivil, forKey: "estadocivil")
        aCoder.encode(addressUser, forKey: "endereco")
    }
}
