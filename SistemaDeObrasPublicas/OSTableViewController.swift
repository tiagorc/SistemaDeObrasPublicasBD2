//
//  OSTableViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class OSTableViewController: UITableViewController {
    var oss: [OSModel] = []
    
    @IBOutlet var osTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        oss = Database().getAllOSs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oss.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oss", for: indexPath)

        cell.textLabel?.text = "\(self.oss[indexPath.row].id!)"
        cell.detailTextLabel?.text = "\(self.oss[indexPath.row].abertura!)"

        return cell
    }
}
