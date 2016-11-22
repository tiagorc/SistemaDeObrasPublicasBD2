//
//  HoleViewControllerTableViewController.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 31/10/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class HoleViewControllerTableViewController: UITableViewController {
    @IBOutlet weak var imageHole: UIImageView!
    @IBOutlet weak var titleHole: UILabel!
    @IBOutlet weak var descriptionHole: UILabel!

    @IBOutlet var tableHoles: UITableView!
    var holes: [HoleModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        if let data  = defaults.object(forKey: "buracos")  {
            self.holes = NSKeyedUnarchiver.unarchiveObject(with: (data as! NSData) as Data) as! [HoleModel]
            self.tableHoles.reloadData()
            self.emptyTable(self.holes as NSArray)
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
        return self.holes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "holes", for: indexPath) as! CustomRoleCellTableViewCell
        
        cell.titleRole.text = self.holes[indexPath.row].holeLocation
//        if let image = self.holes[indexPath.row].image {
//            let i = UIImage(data: image)
//            cell.imageHole.image = i
//        }else {
            cell.imageHole.image = UIImage(named: "damageplaceholder")
//        }
        cell.descriptionHole.text = ("Prioridade: \(self.holes[indexPath.row].holePriority!)")
        
        return cell
    }
    
    func emptyTable(_ Array:NSArray){
        self.tableHoles.viewWithTag(1)?.removeFromSuperview()
        if Array.count == 0 {
            self.tableHoles.tableFooterView = UIView(frame: CGRect.zero)
            self.tableHoles.backgroundColor = UIColor.clear
            
            let label = UILabel()
            label.frame.size.height = 42
            label.frame.size.width = self.tableHoles.frame.size.width
            label.center = self.tableHoles.center
            label.center.y = (self.tableHoles.frame.size.height/2)
            label.numberOfLines = 2
            label.textColor = UIColor.gray
            label.text = "Sem Buracos Cadastrados"
            label.textAlignment = .center
            label.tag = 1
            
            self.tableHoles.addSubview(label)
        }
    }

}
