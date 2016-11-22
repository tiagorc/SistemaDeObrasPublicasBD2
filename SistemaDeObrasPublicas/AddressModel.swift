//
//  AddressModel.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 14/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class AddressModel: NSObject {
    var addressDescription: String!
    var CEP: String!
    var federativeUnit: String!
    var district: DistrictModel!
    var state: StateModel!
    var city: CityModel!
}
