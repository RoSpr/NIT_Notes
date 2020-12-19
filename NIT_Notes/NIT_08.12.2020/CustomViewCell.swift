//
//  CustomViewCell.swift
//  NIT_08.12.2020
//
//  Created by Родион Сприкут on 08.12.2020.
//

import UIKit

class CustomViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var cellHeaderLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
