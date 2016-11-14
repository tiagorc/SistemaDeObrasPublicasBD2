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
        self.holeSize.dataSource = self
        self.holeSize.delegate = self
        
        self.holePriority.delegate = self
        self.holePriority.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if self.tabBarController?.tabBar.isHidden == false {
//            self.self.tabBarController?.tabBar.isHidden = true
//        }
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
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        //do anything
    }
    
    
}
