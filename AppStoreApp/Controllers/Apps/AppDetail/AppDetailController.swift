//
//  AppDetailController.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 1.01.2022.
//

import UIKit

class AppDetailController: UIViewController {

    var labelHeight: CGFloat = 0
    @IBOutlet weak var collectionView: UICollectionView!
    var app: Result?
    var appId: String! {
        didSet {
            let urlString = "http://itunes.apple.com/lookup?id=\(appId!)"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (result: SearchResult?, err) in
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "AppDetailCell", bundle: nil), forCellWithReuseIdentifier: "AppDetailCell")
        collectionView.register(UINib(nibName: "PreviewCell", bundle: nil), forCellWithReuseIdentifier: "PreviewCell")
        
        navigationItem.largeTitleDisplayMode = .never
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension AppDetailController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppDetailCell", for: indexPath) as! AppDetailCell
            cell.loadData(data: app)
            labelHeight = cell.releaseNoteLabel.frame.height
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreviewCell", for: indexPath) as! PreviewCell
            cell.horizantalController.app = self.app
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Cell icine aldigi text kadar uzasin diye asagidaki kodu yazdik. Genel bir trick bu.
        if indexPath.item == 0 {
            let text = (app?.releaseNotes)!
            let size = CGSize(width: view.frame.width, height: 1000)
            var attributes = [NSAttributedString.Key : Any]()
            attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
            
            let estimatedFrame = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return .init(width: view.frame.width, height: (220 + estimatedFrame.height))
        }else {
            return .init(width: view.frame.width, height: 500)
        }

    }
}
