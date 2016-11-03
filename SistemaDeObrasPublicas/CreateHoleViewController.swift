//
//  CreateHoleViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 03/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CreateHoleViewController: UIViewController {
    @IBOutlet weak var holeSize: UIPickerView!
    @IBOutlet weak var estimatedLocation: UITextField!
    @IBOutlet weak var generalDescription: UITextField!
    @IBOutlet weak var holePriority: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeAPictureOfHole(_ sender: Any) {
    }
    
    @IBAction func getHolesLocation(_ sender: Any) {
    }
    
    @IBAction func saveNewButton(_ sender: Any) {
    }
    
    
}
