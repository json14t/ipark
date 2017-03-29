//
//  CustomCell.swift
//  iPark
//
//  Created by Jason Campoverde on 12/2/16.
//  Copyright © 2016 Jason Campoverde. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var location: Location!
    
    @IBOutlet weak var latitudeLbl: UILabel!
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var streetCleaningLbl: UILabel!
    @IBOutlet weak var meterTimeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_location: Location){
        latitudeLbl.text = "\(self.location.latitude)"
        longitudeLbl.text = "\(self.location.longitude)"
        streetCleaningLbl.text = self.location.streetCleaningTime
        meterTimeLbl.text = self.location.meterExpiration
        
    }
    

}
