//
//  PreviewScreenShotController.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 2.01.2022.
//

import UIKit

class PreviewScreenShotController: UIViewController {

    var app: Result? {
        didSet{
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ScreenShotCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCell")
        // Do any additional setup after loading the view.
    }

}
extension PreviewScreenShotController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCell", for: indexPath) as! ScreenShotCell
        let urlString = app?.screenshotUrls[indexPath.item]
        cell.imgView.sd_setImage(with:URL(string: urlString!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}
