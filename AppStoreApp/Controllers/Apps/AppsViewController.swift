//
//  AppViewController.swift
//  AppStoreApp
//
//  Created by Ramazan Ocak on 29.12.2021.
//

import UIKit

class AppsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var allAppGroups = [AppGroupModel]()
    var freePodcasts: AppGroupModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupUI()
        fetchData()
        
    }
    
    fileprivate func setupUI() {
        collectionView.register(UINib(nibName: "AppGroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppGroupCollectionViewCell")
        collectionView.register(UINib(nibName: "AppsPageCollectionReusableView", bundle: nil),forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "AppsPageCollectionReusableView")
    }
}

extension AppsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AppsPageCollectionReusableView", for: indexPath) as! AppsPageCollectionReusableView
        header.appHeaderHorizantalController.freePodcasts = freePodcasts
        header.appHeaderHorizantalController.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allAppGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppGroupCollectionViewCell", for: indexPath) as! AppGroupCollectionViewCell
        let apps = allAppGroups[indexPath.item]
        
        cell.titleLabel.text = apps.feed.title
        cell.horizantalController.appGroup = apps
        cell.horizantalController.collectionView.reloadData()
        cell.horizantalController.didSelectHandler = { [weak self] feedResult in
            let appDetailController = AppDetailController()
            appDetailController.appId = feedResult.id
            self?.navigationController?.pushViewController(appDetailController, animated: true)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 270)
    }
}
// MARK: Network
extension AppsViewController {
    fileprivate func fetchData() {
        activityIndicator.startAnimating()
        var group1: AppGroupModel?
        var group2: AppGroupModel?
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Service.shared.fetchFreeApps{ freeApps, err in
            dispatchGroup.leave()
            if let err = err {
                print("smth wrong",err)
                return
            }
            group1 = freeApps
            
        }
        dispatchGroup.enter()
        Service.shared.fetchPaidApps{ paidApps, err in
            dispatchGroup.leave()
            if let err = err {
                print("smth wrong",err)
                return
            }
            group2 = paidApps
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPodcasts { freePodcasts, err in
            dispatchGroup.leave()
            if let err = err {
                print("smth wrong", err)
                return
            }
            self.freePodcasts = freePodcasts
        }
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            if let group = group1 {
                self.allAppGroups.append(group)
            }
            if let group = group2 {
                self.allAppGroups.append(group)
            }
            self.collectionView.reloadData()
        }
        
    }
}
