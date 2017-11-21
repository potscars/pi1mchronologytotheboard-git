//
//  ProductImagePageVC.swift
//  dashboardv2
//
//  Created by Hainizam on 15/11/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

protocol ProductImagePageVCDelegate: class {
    
    func setupPageController(_ numberOfPages: Int)
    func turnToPages(_ index: Int)
}

class ProductImagePageVC: UIPageViewController {
    
    struct Storyboard {
        static let productImageVC = "ProductImageVC"
    }
    
    var imageURLStrings: [String]? {
        didSet {
            self.setupPageViewController()
        }
    }
    
    weak var productImagePageVCDelegate: ProductImagePageVCDelegate?
    lazy var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupPageViewController() {
        
        dataSource = self
        delegate = self
        
        let storyboard = UIStoryboard(name: "MyShop", bundle: nil)
        
        if let imageURLs = self.imageURLStrings {

            for _ in imageURLs {
                let productImageVC = storyboard.instantiateViewController(withIdentifier: Storyboard.productImageVC)
                controllers.append(productImageVC)
            }
        }
        
        self.productImagePageVCDelegate?.setupPageController(controllers.count)
        turnToPage(0)
    }
    
    func turnToPage(_ index: Int) {
        
        let controller = controllers[index]
        var direction = UIPageViewControllerNavigationDirection.forward
        
        if let currentVC = viewControllers?.first {
            if let currentIndex = controllers.index(of: currentVC) {
                if currentIndex > index {
                    direction = .reverse
                }
            }
        }
        
        self.configureDisplaying(controller)
        
        setViewControllers([controller], direction: direction, animated: true, completion: nil)
    }
    
    func configureDisplaying(_ viewController: UIViewController) {
        
        guard let count = imageURLStrings?.count, count > 0 else { return }
        
        for (index, vc) in controllers.enumerated() {
            
            if viewController === vc {
                if let productImageVC = viewController as? ProductImageVC {
                    productImageVC.imageString = imageURLStrings?[index]
                    self.productImagePageVCDelegate?.turnToPages(index)
                }
            }
        }
    }
}

extension ProductImagePageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard controllers.count > 1 else {
            return nil
        }
        
        if let index = controllers.index(of: viewController) {
            
            if index > 0 {
                return controllers[index - 1]
            }
        }
        
        return controllers.last
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard controllers.count > 1 else {
            return nil
        }
        
        if let index = controllers.index(of: viewController) {
            
            if index < controllers.count - 1 {
                return controllers[index + 1]
            }
        }
        
        return controllers.first
    }
}

extension ProductImagePageVC: UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {

        self.configureDisplaying(pendingViewControllers.first as! ProductImageVC)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {

        if !completed {
            self.configureDisplaying(previousViewControllers.first as! ProductImageVC)
        }
    }
}













