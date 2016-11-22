//
//  CreateHoleViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 03/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class CreateHoleViewController: UIViewController {
    @IBOutlet weak var holeSize: UIPickerView!
    @IBOutlet weak var estimatedLocation: UITextField!
    @IBOutlet weak var generalDescription: UITextField!
    @IBOutlet weak var holePriority: UIPickerView!
    
    var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var imagePicker: UIImagePickerController!
    
    var ctrl = false
    
    var location: CLLocationCoordinate2D!
    var holeImage: UIImage!
    
//    var hole = HoleModel()
    
    var tamanho = String()
    var prioridade = String()
    
    var keyboardOpened: Bool = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.holeSize.dataSource = self
        self.holeSize.delegate = self
        
        self.holePriority.delegate = self
        self.holePriority.dataSource = self

        //location
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateHoleViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateHoleViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
    
    @IBAction func takeAPictureOfHole(_ sender: Any) {
        self.imagePicker = UIImagePickerController()
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = true
        
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func getHolesLocation(_ sender: Any) {
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func saveNewButton(_ sender: Any) {
        if self.holeImage == nil || self.location == nil {
            self.showAlert(title: "Erro, existem campos vazios!", message: "Preencha os dados corretamente e tente novamente.")
        }else {
            var buracos: [HoleModel] = Database().getAllHoles()
            
            let id = buracos.count
            
            if self.prioridade == "" {
                self.prioridade = Consts().holePriority[0]
            }
            if self.tamanho == "" {
                self.tamanho = Consts().holeSize[0]
            }
            //verificar se os campos não estão vazios ..
            let latitude =  String(self.location.latitude)
            let longitude = String(self.location.longitude)
            let localizacao = self.estimatedLocation.text
            
            let buraco: HoleModel = HoleModel(id: id, tamanho: self.tamanho, localizacao: localizacao!, prioridade: self.prioridade, long: longitude, lat: latitude)
            
            
            buracos.append(buraco)
            
            let defaults = UserDefaults.standard
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: buracos)
            
            defaults.set(data, forKey: "buracos")
            defaults.synchronize()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showAlert (title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            alertController.dismiss(animated: true, completion: nil)
        })
        let _ = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            
        }
        alertController.addAction(ok)
//        alertController.addAction(cancel)
//        alertController.addTextField { (textField) -> Void in
//            // Enter the textfiled customization code here.
//            loginTextField = textField
//            loginTextField?.placeholder = "Enter your login ID"
//        }
        present(alertController, animated: true, completion: nil)
    }
    
}

extension CreateHoleViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == self.holeSize {
            return 1
        }else if pickerView == self.holePriority {
            return 1
        }else {
            return 0
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.holeSize {
            return Consts().holeSize.count
        }else if pickerView == self.holePriority {
            return Consts().holePriority.count
        }else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.holeSize {
            return Consts().holeSize[row]
        }else if pickerView == self.holePriority {
            return Consts().holePriority[row]
        }else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.holeSize {
            self.tamanho = Consts().holeSize[row]
        }else if pickerView == self.holePriority {
            self.prioridade = Consts().holePriority[row]
        }
    }
    
}

extension CreateHoleViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.imagePicker.dismiss(animated: true, completion: nil)
        self.holeImage = info[UIImagePickerControllerOriginalImage] as? UIImage //do anything with the image
    }
}

extension CreateHoleViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        if self.ctrl == false {
            self.ctrl = true
            self.addMap(locValue: locValue)
            self.location = locValue
        }
        
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func addMap(locValue: CLLocationCoordinate2D) {
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        mapView = MKMapView(frame: self.view.frame)
        mapView.tag = 0
        let  spanDegree = MKCoordinateSpan(latitudeDelta: 0.001,longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: locValue , span: spanDegree)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: locValue.latitude, longitude: locValue.longitude)
        
        mapView.addAnnotation(annotation)
        
        
        let btn = UIButton()
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        btn.center = self.view.center
        btn.frame.origin.y = btn.frame.origin.y + self.view.frame.size.height/3
        btn.backgroundColor = UIColor.black
        btn.setTitle("Escolher", for: UIControlState.normal)
        btn.addTarget(self, action: #selector(CreateHoleViewController().removeMap), for: UIControlEvents.touchUpInside)
        mapView.addSubview(btn)
        
        self.view.addSubview(mapView)
    }
    
    func removeMap () {
        self.mapView.removeFromSuperview()
        self.ctrl = false
    }
}


extension CreateHoleViewController : UITextFieldDelegate {
    
    func keyboardWillShow(_ sender: Notification) {
        if self.keyboardOpened == false {
//            self.view.frame.origin.y -= 150
            self.keyboardOpened = true
        }
    }
    func keyboardWillHide(_ sender: Notification) {
        if self.keyboardOpened == true {
//            self.view.frame.origin.y = 0
            self.keyboardOpened = false
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.estimatedLocation {
            self.estimatedLocation.resignFirstResponder()
            self.generalDescription.becomeFirstResponder()
        }else if textField == self.generalDescription {
            self.generalDescription.resignFirstResponder()
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.estimatedLocation.resignFirstResponder()
        self.generalDescription.resignFirstResponder()
    }
}
