//
//  MyShopMainMenuVC.swift
//  dashboardv2
//
//  Created by Hainizam on 28/09/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit


struct MyShopMenuIdentifier {
    
    static let ProdukTerkini = "produkTerkiniHolderCell"
    static let ProdukPopular = "produkPopularHolderCell"
    static let ProdukTinggiPernilaian = "produkTinggiPernilaianHolderCell"
    static let ProdukTempatan = "produkTempatanHolderCell"
}

class MyShopMainMenuVC: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var menuBar: MyShopMenuBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureCollectionView()
    }
    
    func configureNavigationBar() {
        
        let navBar = navigationController?.navigationBar
        
        navBar?.barTintColor = UIColor.rgb(125, green: 60, blue: 152)
        navBar?.isTranslucent = false
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        tabBarController?.tabBar.tintColor = UIColor.rgb(125, green: 60, blue: 152)
    }
    
    func configureCollectionView() {
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        mainCollectionView.showsHorizontalScrollIndicator = false
        mainCollectionView.isPagingEnabled = true
        
        menuBar.menuBardelegate = self
        
        mainCollectionView.register(ProdukTerkiniHolderCell.self, forCellWithReuseIdentifier: MyShopMenuIdentifier.ProdukTerkini)
    }
}

extension MyShopMainMenuVC : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyShopMenuIdentifier.ProdukTerkini, for: indexPath) as! ProdukTerkiniHolderCell
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .black
        } else {
            cell.backgroundColor = .lightGray
        }
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
//        let layout = mainCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout
//        let cellWidth = layout?.itemSize.width
//        print("CellWidth:\(cellWidth!) View Width\(view.bounds.width)")
        
        let offset = targetContentOffset.pointee
        let index = (offset.x + mainCollectionView.contentInset.left) / view.bounds.width
        let roundedIndex = round(index)
        print(Int(roundedIndex))
        menuBar.highlightSelectedMenu(menuBar, selectedIndex: Int(roundedIndex))
    }
}

extension MyShopMainMenuVC : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = mainCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        
        return CGSize(width: view.bounds.width, height: collectionView.bounds.height)
    }
}

extension MyShopMainMenuVC : MyShopMenuBarDelegate {
    
    func scrollMenuToIndex(_ index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        mainCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}












