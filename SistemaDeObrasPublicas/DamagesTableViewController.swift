//
//  DamagesTableViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class DamagesTableViewController: UITableViewController {

    var danos: [DamageModel] = []
    var usuarios: [UserModel] = []
    var buracos: [HoleModel] = []
    
    @IBOutlet var damagesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.usuarios = Database().getAllUsers()
        self.buracos = Database().getAllHoles()
        
        self.danos = Database().getAllDamages()
        self.damagesTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.danos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "danos", for: indexPath)

        let u = self.danos[indexPath.row].idUsuario
        let b = self.danos[indexPath.row].idBuraco
        
        let t1 = "\(self.usuarios[u!].userName!) \n\(self.buracos[b!].holeLocation!)"
        
        cell.textLabel?.text = t1
        cell.detailTextLabel?.text = self.danos[indexPath.row].valorEstimado

        return cell
    }
}
