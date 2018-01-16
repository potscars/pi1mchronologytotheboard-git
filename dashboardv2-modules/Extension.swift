//
//  Extension.swift
//  DBPrototype
//
//  Created by Hainizam on 20/09/2017.
//  Copyright © 2017 com.ingeniworks. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        layer.shadowRadius = 2.5
        layer.shadowOffset = CGSize(width: -1, height: -1)
        layer.shadowOpacity = 0.7
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func roundedCorners(_ roundedValue: CGFloat) {
        
        layer.cornerRadius = roundedValue
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func rgb(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension String {
    func getDateInCleanFormat() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.date(from: self)!
        
        formatter.dateFormat = "dd MMMM yyyy"
        let newDateString = formatter.string(from: date)
        
        return newDateString
    }
}

//MARK: - Myshop punya extension.
extension UINavigationController {
    
    func changeMyShopNavigationBarColor() {
        
        self.navigationBar.barTintColor = DBColorSet.myShopColor
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    func myShopHomeButton() {
        
        let homeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_home_white"), style: .done, target: self, action: #selector(homeButtonTapped(_:)))
        
        navigationBar.topItem?.leftBarButtonItem = homeButton
    }
    
    @objc func homeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func changeKospenNavigationBarColor() {

        self.navigationBar.barTintColor = DBColorSet.myHealthColor
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

extension UICollectionView {
    //Func ni guna untuk collectionview myshop sahaja.
    func registerMyShopNibNameToCollectionView() {
        
        let errorNib = UINib(nibName: "ErrorCollectionCell", bundle: nil)
        self.register(errorNib, forCellWithReuseIdentifier: "errorCollectionCell")
        
        let nibName = UINib(nibName: MyShopIdentifier.MyShopProductNibName, bundle: nil)
        self.register(nibName, forCellWithReuseIdentifier: MyShopIdentifier.ProductCell)
    }
}
