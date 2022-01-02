//
//  FirstGroupCollectionViewCell.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 30.12.2021.
//

import UIKit
import SDWebImage

class FirstGroupCollectionViewCell: UICollectionViewCell {

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
