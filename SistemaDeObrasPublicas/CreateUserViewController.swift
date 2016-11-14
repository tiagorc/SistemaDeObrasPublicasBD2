//
//  CreateUserViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 03/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var nameUser: UITextField!
    @IBOutlet weak var CPFUser: UITextField!
    @IBOutlet weak var registrationIDUser: UITextField!
    @IBOutlet weak var registrationIDOrgao: UITextField!
    @IBOutlet weak var registrationIDFUPicker: UIPickerView!
    @IBOutlet weak var motherNameUser: UITextField!
    @IBOutlet weak var fatherNameUser: UITextField!
    @IBOutlet weak var emailUser: UITextField!
    @IBOutlet weak var naturalityUser: UITextField!
    @IBOutlet weak var roleUser: UITextField!
    @IBOutlet weak var civilStateUserPicker: UIPickerView!
    @IBOutlet weak var cepUser: UITextField!
    @IBOutlet weak var cityUser: UITextField!
    @IBOutlet weak var districtUser: UITextField!
    @IBOutlet weak var FUPicker: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registrationIDFUPicker.delegate = self
        self.registrationIDFUPicker.dataSource = self

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.tabBarController?.tabBar.isHidden == false {
            self.self.tabBarController?.tabBar.isHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func takeAPictureUser(_ sender: Any) {
    }
    
    @IBAction func saveUseer(_ sender: Any) {
    }

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CreateUserViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Consts().uf.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Consts().uf[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //do anything
    }
}
