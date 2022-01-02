//
//  SearchResulttCell.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 25.12.2021.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingLabel.text = "Rating \(NSString(format: "%.1f", appResult.averageUserRating ?? 0)) "
            
            let url = URL(string: appResult.artworkUrl100)
            appIconImageView.sd_setImage(with: url)
            
            screenShot1ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[0]))
            
            if appResult.screenshotUrls.count > 1 {
                screenShot2ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[1]))
            }
            if appResult.screenshotUrls.count > 2 {
                screenShot3ImageView.sd_setImage(with: URL(string: appResult.screenshotUrls[2]))
            }
        }
    }
    let appIconImageView: UIImageView = {
        let im = UIImageView()
        im.backgroundColor = .red
        im.widthAnchor.constraint(equalToConstant: 64).isActive = true
        im.heightAnchor.constraint(equalToConstant: 64).isActive = true
        im.layer.cornerRadius = 12
        im.clipsToBounds = true
        return im
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos and Video"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.2M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenShot1ImageView = createScreenShotImageView()
    lazy var screenShot2ImageView = createScreenShotImageView()
    lazy var screenShot3ImageView = createScreenShotImageView()
    
    func createScreenShotImageView() -> UIImageView {
        let img = UIImageView()
        img.backgroundColor = .blue
        img.layer.cornerRadius = 8
        img.clipsToBounds = true
        return img
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStackView = VerticalStackView(arrangedSubviews: [nameLabel,
                                                                 categoryLabel,
                                                                 ratingLabel])
        

        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.translatesAutoresizingMaskIntoConstraints = false
        infoTopStackView.alignment = .center
      
        let screenShotStackView = UIStackView(arrangedSubviews: [screenShot1ImageView, screenShot2ImageView, screenShot3ImageView])
        screenShotStackView.spacing = 12
        screenShotStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenShotStackView],spacing: 16)
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
