//
//  AppsPageCollectionReusableView.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 1.01.2022.
//

import UIKit

class AppsPageCollectionReusableView: UICollectionReusableView {

    let appHeaderHorizantalController = AppsPageHeaderController()
    
    
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .green
        addSubview(appHeaderHorizantalController.view)
        appHeaderHorizantalController.view.fillSuperview()
    }
    
}
