//
//  UserTableViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 31/10/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var users: [UserModel] = []
    @IBOutlet var tableUsers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.tabBarController?.tabBar.isHidden == true {
            self.self.tabBarController?.tabBar.isHidden = false
        }
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "users")  {
            self.users = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [UserModel]
            self.tableUsers.reloadData()
            self.emptyTable(self.users as NSArray)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "users", for: indexPath) as! CustomUserTableViewCell
        cell.titleUser.text = self.users[indexPath.row].userName
        cell.imageUser.image = UIImage(named: "placeholder")
        cell.descriptionUser.text = self.users[indexPath.row].userCurrentRole

        return cell
    }

    func emptyTable(_ Array:NSArray){
        self.tableUsers.viewWithTag(1)?.removeFromSuperview()
        if Array.count == 0 {
            self.tableUsers.tableFooterView = UIView(frame: CGRect.zero)
            self.tableUsers.backgroundColor = UIColor.clear
            
            let label = UILabel()
            label.frame.size.height = 42
            label.frame.size.width = self.tableUsers.frame.size.width
            label.center = self.tableUsers.center
            label.center.y = (self.tableUsers.frame.size.height/2)
            label.numberOfLines = 2
            label.textColor = UIColor.gray
            label.text = "Sem Usuários Cadastrados"
            label.textAlignment = .center
            label.tag = 1
            
            self.tableUsers.addSubview(label)
        }
    }

}
