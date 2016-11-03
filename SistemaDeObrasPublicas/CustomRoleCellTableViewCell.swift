//
//  CustomRoleCellTableViewCell.swift
//  SistemaDeObrasPublicas
//
//  Created by Euler Tiago Rodrigues de Carvalho on 31/10/16.
//  Copyright © 2016 Euler Carvalho. All rights reserved.
//

import UIKit

class CustomRoleCellTableViewCell: UITableViewCell {
    @IBOutlet weak var imageHole: UIImageView!
    @IBOutlet weak var titleRole: UILabel!
    @IBOutlet weak var descriptionHole: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
