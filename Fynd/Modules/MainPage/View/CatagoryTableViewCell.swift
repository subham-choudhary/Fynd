//
//  CatagoryTableViewCell.swift
//  Fynd
//
//  Created by user178193 on 7/22/20.
//  Copyright © 2020 user178193. All rights reserved.
//

import UIKit

class CatagoryTableViewCell: UITableViewCell {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    var viewModel: CatagoryTableProtocol? = CatagoryTableViewModel()
    var products: [Product] = [] {
        didSet {
            productsCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGesture()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(catagory: ProductCatagory, filter: FilterType?) {
        let filteredProducts = viewModel?.getFilteredData(with: filter ?? .name, data: catagory.products)
        products = filteredProducts ?? []
    }
    
    func setupGesture() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        productsCollectionView.addGestureRecognizer(longPressGesture)
    }
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        
    case .began:
        guard let selectedIndexPath = productsCollectionView.indexPathForItem(at: gesture.location(in: productsCollectionView)) else {
            break
        }
        productsCollectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
    case .changed:
        productsCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
    case .ended:
        productsCollectionView.endInteractiveMovement()
    default:
        productsCollectionView.cancelInteractiveMovement()
    }
    }
}

extension CatagoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(product: products[indexPath.row])
        return cell
    }
    
}
extension CatagoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfColumns = 3
        let noOfRows = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let width = collectionView.bounds.width / CGFloat(noOfColumns) - (flowLayout.sectionInset.left + flowLayout.minimumInteritemSpacing)
        let height = collectionView.bounds.height / CGFloat(noOfRows) - flowLayout.minimumLineSpacing
        
        return CGSize(width: width, height: height)
    }
}
extension CatagoryTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = products.remove(at: sourceIndexPath.item)
        products.insert(temp, at: destinationIndexPath.item)
        
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}
