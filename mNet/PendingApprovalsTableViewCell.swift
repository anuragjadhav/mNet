//
//  PendingApprovalsTableViewCell.swift
//  mNet
//
//  Created by Nachiket Vaidya on 14/01/18.
//  Copyright © 2018 mNet. All rights reserved.
//

import UIKit

class PendingApprovalsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var pendingApprovalsCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pendingApprovalsCollectionView.delegate = self
        pendingApprovalsCollectionView.dataSource = self
        pendingApprovalsCollectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PendingApprovalsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.pendingApprovalsCollectionView, for: indexPath) as! PendingApprovalsCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
