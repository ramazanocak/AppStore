//
//  AppsHorizantalController.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 30.12.2021.
//

import UIKit

class AppsHorizantalController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var didSelectHandler: ((FeedResult) -> ())?
    
    var appGroup: AppGroupModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "FirstGroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FirstGroupCollectionViewCell")
        collectionView.fillSuperview()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension AppsHorizantalController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item]{
            didSelectHandler?(app)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstGroupCollectionViewCell", for: indexPath) as! FirstGroupCollectionViewCell
        let data = appGroup?.feed.results[indexPath.item]
        cell.loadCell(data: data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: screenWidth - 48, height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 12, left: 16, bottom: 12, right: 16)
    }
}
