//
//  MyShopTerkiniCVC.swift
//  dashboardv2
//
//  Created by Hainizam on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

struct MyShopIdentifier {
    
    static let ProductCell = "productCell"
    static let MyShopProductNibName = "MyShopProductCell"
    static let ProductCommentCell = "productCommentCell"
    static let MyShopDetailsSegue = "goto_myshopDetails"
}

class MyShopTerkiniCVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.changeMyShopNavigationBarColor()
        navigationItem.title = "Produk Terkini"
    }
    
    func configureCollectionView() {
        
        let nibName = UINib(nibName: MyShopIdentifier.MyShopProductNibName, bundle: nil)
        self.collectionView?.register(nibName, forCellWithReuseIdentifier: MyShopIdentifier.ProductCell)
        self.collectionView?.backgroundColor = DBColorSet.myShopBackgroundColor
    }
}

extension MyShopTerkiniCVC {
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyShopIdentifier.ProductCell, for: indexPath) as! MyShopProductCell
        return cell
    }
}

extension MyShopTerkiniCVC: UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectioViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = collectionView.cellForItem(at: indexPath) {
            self.performSegue(withIdentifier: MyShopIdentifier.MyShopDetailsSegue, sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        
        let itemWidth = (view.frame.width - 24) / 2
        
        return CGSize(width: itemWidth, height: 200.0)
    }
}

extension UINavigationController {
    
    func changeMyShopNavigationBarColor() {
        
        self.navigationBar.barTintColor = DBColorSet.myShopColor
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}












