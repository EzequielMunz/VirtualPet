//
//  CreditsCell.swift
//  VirtualPet
//
//  Created by Ezequiel on 12/18/14.
//  Copyright (c) 2014 Ezequiel. All rights reserved.
//

import UIKit

class CreditsCell: UITableViewCell {

    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblRole: UILabel!

    var person : CreditPerson
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        person = CreditPerson()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        person = CreditPerson()
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithPerson (person: CreditPerson)
    {
        self.lblName?.text = person.personName
        self.lblRole?.text = person.personRole
    }
    
}
