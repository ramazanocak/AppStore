//
//  AppsFirstCollectionViewCell.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 29.12.2021.
//

import UIKit

class AppGroupCollectionViewCell: UICollectionViewCell {

    let horizantalController = AppsHorizantalController()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.addSubview(horizantalController.view)
        horizantalController.view.fillSuperview()
    }

}

