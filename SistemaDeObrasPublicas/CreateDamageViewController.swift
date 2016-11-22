//
//  CreateDamageViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CreateDamageViewController: UIViewController {

    @IBOutlet weak var descricaoTextField: UITextField!
    @IBOutlet weak var timestamp: UIDatePicker!
    @IBOutlet weak var vamorEstimadoTextField: UITextField!
    @IBOutlet weak var idBuraco: UIPickerView!
    @IBOutlet weak var idUsuario: UIPickerView!
    
    var buraco: HoleModel!
    var usuario: UserModel!
    
    var buracos: [HoleModel] = []
    var usuarios: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.idBuraco.delegate = self
        self.idBuraco.dataSource = self
        self.idUsuario.delegate = self
        self.idUsuario.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadPickerData()
    }

    func loadPickerData() {
        self.buracos = Database().getAllHoles()
        self.usuarios = Database().getAllUsers()
        
        self.idUsuario.reloadAllComponents()
        self.idBuraco.reloadAllComponents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        var damages: [DamageModel] = []
        damages = Database().getAllDamages()
        let id = damages.count
        
        let desc = self.descricaoTextField.text
        
        if self.usuario == nil {
            self.usuario = self.usuarios[0]
        }
        
        if self.buraco == nil {
            self.buraco = self.buracos[0]
        }
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm"
        let ts: String = dateFormatter.string(from: self.timestamp.date)
        
        let valor = self.vamorEstimadoTextField.text
        
        let damage = DamageModel(id: id, desc: desc!, horario: ts, valor: valor!, idb: self.buraco.id, idu: self.usuario.id)
        
        damages.append(damage)
        
        let defaults = UserDefaults.standard
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: damages)
        
        defaults.set(data, forKey: "danos")
        defaults.synchronize()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension CreateDamageViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == self.idBuraco {
            return 1
        }else if pickerView == self.idUsuario {
            return 1
        }else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.idBuraco {
            return self.buracos.count
        }else if pickerView == self.idUsuario {
            return self.usuarios.count
        }else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.idBuraco {
            return self.buracos[row].holeLocation
        }else if pickerView == self.idUsuario {
            return self.usuarios[row].userName
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.idBuraco {
            self.buraco = buracos[row]
        }else if pickerView == self.idUsuario {
            self.usuario = usuarios[row]
        }
    }
}

extension CreateDamageViewController : UITextFieldDelegate {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.descricaoTextField.resignFirstResponder()
        self.vamorEstimadoTextField.resignFirstResponder()
    }
}
