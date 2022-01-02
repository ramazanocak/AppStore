//
//  PreviewCell.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 1.01.2022.
//

import UIKit

class PreviewCell: UICollectionViewCell {

    let horizantalController = PreviewScreenShotController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.addSubview(horizantalController.view)
        horizantalController.view.fillSuperview()
    }

}
