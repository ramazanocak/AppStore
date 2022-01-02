//
//  AppDetailCell.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 1.01.2022.
//

import UIKit

class AppDetailCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var releaseNoteLabel: UILabel!
    
    
    func loadData(data: Result?) {
        guard let data = data else {return}
        imgView.sd_setImage(with: URL(string: data.artworkUrl100))
        priceButton.setTitle(data.formattedPrice, for: .normal)
        nameLabel.text = data.trackName
        releaseNoteLabel.text = data.releaseNotes
    }
}
