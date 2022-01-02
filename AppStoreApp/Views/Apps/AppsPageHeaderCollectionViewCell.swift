//
//  AppsPageHeaderCollectionViewCell.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 1.01.2022.
//

import UIKit

class AppsPageHeaderCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadCell(data: FeedResult?) {
        guard let data = data else {return}
        titleLabel.text = data.name
        companyLabel.text = data.artistName
        imgView.sd_setImage(with: URL(string: data.artworkUrl100))
    }
}
