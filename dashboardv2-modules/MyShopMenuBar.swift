//
//  MyShopMenuBar.swift
//  dashboardv2
//
//  Created by Hainizam on 28/09/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol MyShopMenuBarDelegate: class {
    func scrollMenuToIndex(_ index: Int)
}

enum SelectedState {
    case selected
    case idle
}

class MyShopMenuBar: UICollectionView {
    
    struct MenuBarIdentifier {
        static let MenuBarTitlesCell = "menuBarTitleCell"
    }
    
    var menuBardelegate: MyShopMenuBarDelegate?
    var menuBarTitles: NSArray!
    var selectedMenu: [SelectedState] = []
    var titleIndex: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCollectionView()
        
        menuBarTitles = setupMenu()
        
        selectedMenu[0] = .selected
    }
    
    func configureCollectionView() {
        
        dataSource = self
        delegate = self
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.rgb(125, green: 60, blue: 152)
    }
    
    func setupMenu() -> NSArray
    {
        let latestProd: NSDictionary = ["MENU_NAME":"Produk Terkini","MENU_BG_COLOR":DBColorSet.myShopMenuOddColor,"MENU_LABEL_COLOR":UIColor.white]
        let popularProd: NSDictionary = ["MENU_NAME":"Produk Popular","MENU_BG_COLOR":DBColorSet.myShopMenuEvenColor,"MENU_LABEL_COLOR":UIColor.white]
        let highRatingProd: NSDictionary = ["MENU_NAME":"Produk Tinggi Penilaian","MENU_BG_COLOR":DBColorSet.myShopMenuOddColor,"MENU_LABEL_COLOR":UIColor.white]
        let localProd: NSDictionary = ["MENU_NAME":"Produk Tempatan","MENU_BG_COLOR":DBColorSet.myShopMenuEvenColor,"MENU_LABEL_COLOR":UIColor.white]
        
        let myShopMenu: NSArray = [latestProd,popularProd,highRatingProd,localProd]
        selectedMenu = Array(repeating: .idle, count: myShopMenu.count)
        
        return myShopMenu
    }
}

extension MyShopMenuBar : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBarTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarIdentifier.MenuBarTitlesCell, for: indexPath) as! MenuBarTitleCell
        
        //let titleColor = indexPath.row == titleIndex ? UIColor.white : UIColor.lightGray
        
        let titleColor = selectedMenu[indexPath.row] == .selected ? UIColor.white : UIColor.lightGray
        
        cell.title = (menuBarTitles.object(at: indexPath.row) as AnyObject).value(forKey: "MENU_NAME") as! String
        cell.titleColor = titleColor
        
        return cell
    }
}

extension MyShopMenuBar : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 8.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8)
        
        let menuString = (menuBarTitles.object(at: indexPath.row) as AnyObject).value(forKey: "MENU_NAME") as! String
        //let menuStringSize = menuString.size(attributes: [NSFontAttributeName : UIFont(name: "Menlo-Bold", size: 16.0)!])
        let menuStringSize = menuString.size(withAttributes: [NSAttributedStringKey.font : UIFont(name: "Menlo-Bold", size: 16.0)!])
        
        return CGSize(width: menuStringSize.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedIndex = indexPath.row
        self.menuBardelegate?.scrollMenuToIndex(selectedIndex)
        
        highlightSelectedMenu(collectionView, selectedIndex: selectedIndex)
    }
    
    func highlightSelectedMenu(_ collectionView: UICollectionView, selectedIndex: Int) {
        
        let indexPath = IndexPath(row: selectedIndex, section: 0)
        
        for (key, _) in selectedMenu.enumerated() {
            selectedMenu[key] = key == selectedIndex ? .selected : .idle
        }
        collectionView.reloadData()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

class MenuBarTitleCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    var titleColor: UIColor! {
        didSet{
            titleLabel.textColor = titleColor
        }
    }
}








