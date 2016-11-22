//
//  CreateUserViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 03/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit
import CoreData

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
    
    var federativeUnit: String!
    var idFederativeUnit: String!
    var civilState: String!
    
    var imagePicker: UIImagePickerController!
    
    var keyboardOpened: Bool = false
    
//    var user = UserModel()
    
    var imageUser = UIImage()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registrationIDFUPicker.delegate = self
        self.registrationIDFUPicker.dataSource = self
        
        self.civilStateUserPicker.delegate = self
        self.civilStateUserPicker.dataSource = self
        
        self.FUPicker.delegate = self
        self.FUPicker.dataSource = self

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateUserViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateUserViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takeAPictureUser(_ sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = true
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveUseer(_ sender: Any) {
        var users = self.getUsers()
        
        let id = users.count
        
        let nome = self.nameUser.text!
        let cpf = self.CPFUser.text!
        let rg = self.registrationIDUser.text!
        let ufrg = self.civilState != nil ? self.civilState : Consts().civilState[0]
        let nomemae = self.motherNameUser.text!
        let nomepai = self.fatherNameUser.text!
        let email = self.emailUser.text!
        let naturalidade = self.naturalityUser.text!
        let cargo = self.roleUser.text!
        let estadocivil = self.civilState != nil ? self.civilState : Consts().civilState[0]
        

        let uf = self.federativeUnit != nil ? self.federativeUnit : Consts().uf[0]
        
        
        let bairro = DistrictModel(id: id, bairro: self.districtUser.text!)
        let cidade = CityModel(id: id, cidade: self.cityUser.text!)
        let estado = StateModel(id: id, estado: "Brasil")
        let endereco = AddressModel(id: id, endereco: "Endereço: ", cep: self.cepUser.text!, uf: uf!, bairro: bairro, estado: estado, cidade: cidade)
        let user = UserModel(id: id, name: nome, CPF: cpf, rg: rg, orgaorg: "SSP", ufrg: ufrg!, nomemae: nomemae, nomepai: nomepai, email: email, naturalidade: naturalidade, cargo: cargo, estadocivil: estadocivil!, endereco: endereco)//, image: self.imageUser)
        
        users.append(user)
        
        let defaults = UserDefaults.standard
        let data: Data = NSKeyedArchiver.archivedData(withRootObject: users)
        
        defaults.set(data, forKey: "users")
        defaults.synchronize()
        
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getUsers() -> [UserModel] {
        
        var users: [UserModel] = []
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "users")  {
            let u = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [UserModel]
            users = u
        }
        return users
    }
}

extension CreateUserViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.registrationIDFUPicker || pickerView == self.FUPicker {
            return Consts().uf.count
        }else if pickerView == civilStateUserPicker {
            return Consts().civilState.count
        }else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.registrationIDFUPicker || pickerView == self.FUPicker {
            return Consts().uf[row]
        }else if pickerView == civilStateUserPicker {
            return Consts().civilState[row]
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.registrationIDFUPicker {
            self.idFederativeUnit = Consts().uf[row]
        }else if pickerView == self.FUPicker {
            self.federativeUnit = Consts().uf[row]
        }else if pickerView == civilStateUserPicker {
            self.civilState = Consts().civilState[row]
        }
    }
}

extension CreateUserViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imagePicker.dismiss(animated: true, completion: nil)
        self.imageUser = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
    }
}

extension CreateUserViewController : UITextFieldDelegate {
    
    func keyboardWillShow(_ sender: Notification) {
        if self.motherNameUser.isEditing || self.fatherNameUser.isEditing || self.emailUser.isEditing || self.naturalityUser.isEditing || self.roleUser.isEditing || self.cepUser.isEditing || self.cityUser.isEditing || self.districtUser.isEditing{
            if self.keyboardOpened == false {
                self.view.frame.origin.y -= 150
                self.keyboardOpened = true
            }
        }
        
    }
    func keyboardWillHide(_ sender: Notification) {
        
        if self.motherNameUser.isEditing || self.fatherNameUser.isEditing || self.emailUser.isEditing || self.naturalityUser.isEditing || self.roleUser.isEditing || self.cepUser.isEditing || self.cityUser.isEditing || self.districtUser.isEditing{
            if self.keyboardOpened == true {
                self.view.frame.origin.y = 0
                self.keyboardOpened = false
            }
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.nameUser {
            self.nameUser.resignFirstResponder()
            self.CPFUser.becomeFirstResponder()
        }else if textField == self.CPFUser {
            self.CPFUser.resignFirstResponder()
            self.registrationIDUser.becomeFirstResponder()
        }else if textField == self.registrationIDUser{
            self.registrationIDUser.resignFirstResponder()
            self.registrationIDOrgao.becomeFirstResponder()
        }else if textField == self.registrationIDOrgao{
            self.registrationIDOrgao.resignFirstResponder()
            self.motherNameUser.becomeFirstResponder()
        }else if textField == self.motherNameUser{
            self.motherNameUser.resignFirstResponder()
            self.fatherNameUser.becomeFirstResponder()
        }else if textField == self.fatherNameUser{
            self.fatherNameUser.resignFirstResponder()
            self.emailUser.becomeFirstResponder()
        }else if textField == self.emailUser{
            self.emailUser.resignFirstResponder()
            self.naturalityUser.becomeFirstResponder()
        }else if textField == self.naturalityUser{
            self.naturalityUser.resignFirstResponder()
            self.roleUser.becomeFirstResponder()
        }else if textField == self.roleUser{
            self.roleUser.resignFirstResponder()
            self.cepUser.becomeFirstResponder()
        }else if textField == self.cepUser{
            self.cepUser.resignFirstResponder()
            self.cityUser.becomeFirstResponder()
        }else if textField == self.cityUser{
            self.cityUser.resignFirstResponder()
            self.districtUser.becomeFirstResponder()
        }else if textField == self.districtUser{
            self.districtUser.resignFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.nameUser.resignFirstResponder()
        self.CPFUser.resignFirstResponder()
        self.registrationIDUser.resignFirstResponder()
        self.registrationIDOrgao.resignFirstResponder()
        self.motherNameUser.resignFirstResponder()
        self.fatherNameUser.resignFirstResponder()
        self.emailUser.resignFirstResponder()
        self.naturalityUser.resignFirstResponder()
        self.roleUser.resignFirstResponder()
        self.cepUser.resignFirstResponder()
        self.cityUser.resignFirstResponder()
        self.districtUser.resignFirstResponder()
    }
}
