//
//  CreateOSViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CreateOSViewController: UIViewController {

    @IBOutlet weak var buracoPicker: UIPickerView!
    @IBOutlet weak var teamPicker: UIPickerView!
    
    var buracos: [HoleModel] = []
    var equipes: [MaintenceModel] = []
    
    var buraco: HoleModel!
    var equipe: MaintenceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.buracoPicker.delegate = self
        self.buracoPicker.dataSource = self
        self.teamPicker.delegate = self
        self.teamPicker.dataSource = self
        
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buracos = Database().getAllHoles()
        self.equipes = Database().getAllMaintenceTeams()
        
        self.buracoPicker.reloadAllComponents()
        self.teamPicker.reloadAllComponents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        var oss: [OSModel] = []
        oss = Database().getAllOSs()
        
        let id = oss.count
        
        if self.buraco == nil {
            self.buraco = self.buracos[0]
        }
        if self.equipe == nil {
            self.equipe = self.equipes[0]
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm"
        let abertura: String = formatter.string(from: NSDate() as Date)
        
        let os = OSModel(id: id, dataAbertura: abertura, dataFechamento: "", equipe: self.equipe.id, buraco: self.buraco.id)
        
        oss.append(os)
        
        let defaults = UserDefaults.standard
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: oss)
        
        defaults.set(data, forKey: "oss")
        defaults.synchronize()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelar(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CreateOSViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == self.buracoPicker {
            return 1
        }else if pickerView == self.teamPicker {
            return 1
        }else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.buracoPicker {
            return self.buracos.count
        }else if pickerView == self.teamPicker {
            return self.equipes.count
        }else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.buracoPicker {
            return self.buracos[row].holeLocation
        }else if pickerView == self.teamPicker {
            return self.equipes[row].mtname
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.buracoPicker {
            self.buraco = buracos[row]
        }else if pickerView == self.teamPicker {
            self.equipe = equipes[row]
        }
    }
}

