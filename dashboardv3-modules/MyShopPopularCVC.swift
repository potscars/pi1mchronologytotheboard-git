//
//  MyShopPopularCVC.swift
//  dashboardv2
//
//  Created by Hainizam on 07/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MyShopPopularCVC: UICollectionViewController {
    
    var currentPage = 1
    var isCanLoadMore = true
    var products = [Product]()
    var isError = false
    var errorMessage = "Sorry. There is no data."
    var refreshControl: UIRefreshControl!
    var spinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        
        navigationController?.myShopHomeButton()
        configureCollectionView()
        setupRefreshControl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if products.count <= 0 {
            spinner.setLoadingScreen()
            populateData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.changeMyShopNavigationBarColor()
        navigationItem.title = "Produk Popular"
    }
    
    private func populateData() {
        
        let urlString = DBSettings.myShopPopularProductURL
        let product = Product.init(urlString)
        
        product.fetchProduct(currentPage) { (result, isCanLoadMore, responses) in
            
            guard responses == nil else {
                
                DispatchQueue.main.async {
                    self.isError = true
                    self.errorMessage = responses!
                    self.collectionView?.reloadData()
                    self.spinner.removeLoadingScreen()
                }
                
                return
            }
            
            guard let productsResult = result else {
                
                DispatchQueue.main.async {
                    self.isError = true
                    self.errorMessage = "Nope. No data available."
                    self.collectionView?.reloadData()
                    self.spinner.removeLoadingScreen()
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.isError = false
                self.isCanLoadMore = isCanLoadMore
                self.products.append(contentsOf: productsResult)
                self.collectionView?.reloadData()
                self.spinner.removeLoadingScreen()
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    func configureCollectionView() {
        
        self.collectionView?.registerMyShopNibNameToCollectionView()
        self.collectionView?.backgroundColor = DBColorSet.myShopBackgroundColor
    }
    
    func setupRefreshControl() {
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshPopulatedData), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
    }
    
    @objc func refreshPopulatedData() {
        currentPage = 1
        products.removeAll()
        isCanLoadMore = true
        populateData()
    }
    
    var detailsID = 0
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MyShopIdentifier.MyShopDetailsSegue {
            
            if let destination = segue.destination as? MyShopDetailsVC {
                
                destination.myShopDetailsID = detailsID
            }
        }
    }
}

extension MyShopPopularCVC {
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = !isError ? products.count : 1
        return count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !isError {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyShopIdentifier.ProductCell, for: indexPath) as! MyShopProductCell
            
            cell.product = products[indexPath.row]
            
            return cell
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "errorCollectionCell", for: indexPath) as! ErrorCollectionCell
            
            cell.message = errorMessage
            
            return cell
        }
    }
}

extension MyShopPopularCVC: UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectioViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = collectionView.cellForItem(at: indexPath) {
            detailsID = products[indexPath.row].productId
            self.performSegue(withIdentifier: MyShopIdentifier.MyShopDetailsSegue, sender: self)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == products.count - 1 {
            if isCanLoadMore {
                currentPage += 1
                populateData()
            }
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










