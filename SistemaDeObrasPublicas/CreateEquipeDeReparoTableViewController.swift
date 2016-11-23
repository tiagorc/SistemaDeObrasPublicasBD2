//
//  CreateEquipeDeReparoTableViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 22/11/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CreateEquipeDeReparoTableViewController: UITableViewController {
    @IBOutlet var usersTable: UITableView!
    var users: [UserModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.usersTable.delegate = self
//        self.usersTable.dataSource = self
        self.usersTable.allowsMultipleSelection = true
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "users")  {
            self.users = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [UserModel]
            self.usersTable.reloadData()
            self.emptyTable(self.users as NSArray)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        func save(name: String) {
            var teams: [MaintenceModel] = []
            teams = Database().getAllMaintenceTeams()
            
            let id = teams.count
            
            let rows = tableView.indexPathsForSelectedRows.map{$0.map{$0.row}}
            
            var team : [UserModel] = []
            for i in rows! {
                team.append(self.users[i])
            }
            
            let mt = MaintenceModel(id: id, mtname: name, t: team)
            
            teams.append(mt)
            
            let defaults = UserDefaults.standard
            let data: Data = NSKeyedArchiver.archivedData(withRootObject: teams)
            
            defaults.set(data, forKey: "maintences")
            defaults.synchronize()
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        var name: String!
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Quase lá..", message: "Digite um nome para a equipe de reparo", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField(configurationHandler: { (textField) -> Void in
            textField.placeholder = "Nome da equipe de reparo"
        })
        
        //3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = (alert?.textFields![0])! as UITextField
            name  = textField.text
            
            save(name: name)
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "users", for: indexPath) as! CustomUserTableViewCell
        cell.titleUser.text = self.users[indexPath.row].userName
        //        if let image = self.users[indexPath.row].image {
        //            cell.imageUser.image = image
        //        }else {
        cell.imageUser.image = UIImage(named: "placeholder")
        //        }
        cell.descriptionUser.text = self.users[indexPath.row].userCurrentRole
        
        return cell
    }
    
    func emptyTable(_ Array:NSArray){
        self.usersTable.viewWithTag(1)?.removeFromSuperview()
        if Array.count == 0 {
            self.usersTable.tableFooterView = UIView(frame: CGRect.zero)
            self.usersTable.backgroundColor = UIColor.clear
            
            let label = UILabel()
            label.frame.size.height = 42
            label.frame.size.width = self.usersTable.frame.size.width
            label.center = self.usersTable.center
            label.center.y = (self.usersTable.frame.size.height/2)
            label.numberOfLines = 2
            label.textColor = UIColor.gray
            label.text = "Sem Usuários Cadastrados"
            label.textAlignment = .center
            label.tag = 1
            
            self.usersTable.addSubview(label)
        }
    }

}
