//
//  MyShopIntegratedTVCell.swift
//  dashboardv2
//
//  CellId: MyShopBannerCellID, MyShopMenuNormalCellID,
//  MyShopProductListingCellID, MyShopLatestLoadingCellID,
//  MyShopLoadMoreCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/02/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Cosmos
import ImageSlideshow

class MyShopIntegratedTVCell: UITableViewCell {

    
    @IBOutlet weak var issMSITVCMainMenuBanner: ImageSlideshow!
    @IBOutlet weak var uilMSITVCMainMenuName: UILabel!
    @IBOutlet weak var uilMSITVCMainMenuPointer: UILabel!
    
    //Loading
    @IBOutlet weak var uilMSITVCListProdLoadingLabel: UILabel!
    @IBOutlet weak var uiaivMSITVCLoadingIndicator: UIActivityIndicatorView!
    
    //LoadMore
    @IBOutlet weak var uilMSITVCLoadMoreLabel: UILabel!
    
    //Product listing
    @IBOutlet weak var uiivMSITVCProdImage: UIImageView!
    @IBOutlet weak var uilMSITVCProdName: UILabel!
    @IBOutlet weak var cvMSITVCProdRating: CosmosView!
    @IBOutlet weak var uilMSITVCProdViewed: UILabel!
    @IBOutlet weak var uilMSITVCProdComment: UILabel!
    @IBOutlet weak var uilMSITVCProdPrice: UILabel!
    
    //Details of Product: ProductName
    @IBOutlet weak var uilMSITVCDetailsProdName: UILabel!
    @IBOutlet weak var uilMSITVCDetailsProdPrice: UILabel!
    @IBOutlet weak var csMSITVCDetailsRating: CosmosView!
    
    //Details of Product: ProductPicture
    @IBOutlet weak var issMSITVCDetailsPicture: ImageSlideshow!
    
    //Details of Product: Lokasi
    @IBOutlet weak var uilMSITVCDetailsLocation: UILabel!
    @IBOutlet weak var uilMSITVCDetailsCategory: UILabel!
    
    //Details of Product: Seller Info
    @IBOutlet weak var uilMSITVCDetailsSellerTitle: UILabel!
    @IBOutlet weak var uilMSITVCDetailsSellerName: UILabel!
    @IBOutlet weak var uilMSITVCDetailsSellerContact: UILabel!
    @IBOutlet weak var uilMSITVCDetailsSellerEmail: UILabel!
    @IBOutlet weak var uilMSITVCDetailsSellerGST: UILabel!
    
    //Details of Product: Product Info
    @IBOutlet weak var uilMSITVCDetailsProdTitle: UILabel!
    @IBOutlet weak var uilMSITVCDetailsProdDesc: UILabel!
    
    //Details of Product: Rating and Review title
    @IBOutlet weak var uilMSITVCDetailsRatingTitle: UILabel!
    
    //Details of Product: Comment
    @IBOutlet weak var cvMSITVCRatingCommentor: CosmosView!
    @IBOutlet weak var uilMSITVCCommentor: UILabel!
    
    //Details of Product: See All Comment
    @IBOutlet weak var uibMSITVCDetailsSeeAllComment: UIButton!
    
    //Details of Product: No Rating found
    @IBOutlet weak var uilMSITVCDetailsNoRating: UILabel!
    
    //Details of Product: ProductLoading
    @IBOutlet weak var uilMSITVCDetailsProdLoading: UILabel!
    
    
    var listingViewController: UIViewController? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpdateBanner(backgroundColor: UIColor)
    {
        issMSITVCMainMenuBanner.backgroundColor = UIColor.clear
        issMSITVCMainMenuBanner.slideshowInterval = 5.0
        issMSITVCMainMenuBanner.pageControlPosition = PageControlPosition.underScrollView
        issMSITVCMainMenuBanner.pageControl.currentPageIndicatorTintColor = UIColor.black
        issMSITVCMainMenuBanner.contentScaleMode = UIViewContentMode.scaleToFill
        
        let imageFromSource: [ImageSource] = [ImageSource(imageString: "ic_bannerMyShopColor")!]
        
        issMSITVCMainMenuBanner.setImageInputs(imageFromSource)
        self.backgroundColor = backgroundColor
    }
    
    func setUpdateMenuLabel(menuString: String, backgroundColor: UIColor, labelTextColor: UIColor) {
        
        uilMSITVCMainMenuName.text = menuString
        uilMSITVCMainMenuName.textColor = labelTextColor
        uilMSITVCMainMenuPointer.textColor = labelTextColor
        self.backgroundColor = backgroundColor
    }
    
    func setUpdateProductListing(data: NSDictionary)
    {
        print("\(data)")
        
        ZImages.getImageFromUrlSession(fromURL: "\(String(describing: data.object(forKey: "MYSHOP_PROD_PHOTO_THUMB")!))", defaultImage: "ic_logodb", imageView: uiivMSITVCProdImage)
        uilMSITVCProdName.text = "\(String(describing: data.object(forKey: "MYSHOP_PROD_TITLE")!))"
        uilMSITVCProdViewed.text = "\(String(describing: data.object(forKey: "MYSHOP_PROD_VIEWER_COUNT")!))"
        uilMSITVCProdComment.text = "\(String(describing: data.object(forKey: "MYSHOP_PROD_COMMENT_COUNT")!))"
        uilMSITVCProdPrice.text = "RM \(String(describing: data.object(forKey: "MYSHOP_PROD_PRICE")!))"
        cvMSITVCProdRating.rating = Double.init(String(describing: data.object(forKey: "MYSHOP_PROD_RATING_COUNT")!))!
    }
    
    func updateReloadCell(isLoading: Bool, forCellID: String) {
        
        if(forCellID == "MyShopLoadMoreCellID" && isLoading == true) {
            
            uilMSITVCLoadMoreLabel.text = "Sila Tunggu..."
            
        }
        else if(forCellID == "MyShopLoadMoreCellID" && isLoading == false) {
            
            uilMSITVCLoadMoreLabel.text = "Tekan untuk muatkan lagi."
            
        }
        
    }

    func updateProductDetailsProductName(data:NSDictionary)
    {
        uilMSITVCDetailsProdName.text = "\(data.object(forKey: "MYSHOP_PROD_TITLE") as! String)"
        uilMSITVCDetailsProdPrice.text = "RM \(data.object(forKey: "MYSHOP_PROD_PRICE") as! String)"
        csMSITVCDetailsRating.rating = Double.init(data.object(forKey: "MYSHOP_PROD_RATING_COUNT") as! String)!
    }
    
    func updateProductDetailsProductPicture(data: NSArray, withViewController: UIViewController) {
        
        listingViewController = withViewController
        
        issMSITVCDetailsPicture.backgroundColor = UIColor.lightGray
        issMSITVCDetailsPicture.slideshowInterval = 5.0
        issMSITVCDetailsPicture.pageControlPosition = PageControlPosition.underScrollView
        issMSITVCDetailsPicture.pageControl.currentPageIndicatorTintColor = UIColor.black
        issMSITVCDetailsPicture.contentScaleMode = UIViewContentMode.scaleAspectFit
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        issMSITVCDetailsPicture.addGestureRecognizer(recognizer)
        
        var arrayPhotos: [KingfisherSource] = []
        
        for i in 0...data.count - 1 {
            
            let unwrappedPhotos: NSDictionary = data.object(at: i) as! NSDictionary
            let extractedPhotos: String = "\(DBSettings.myShopProductImageLargeURL)/\(unwrappedPhotos.value(forKey: "name") as! String)"
            
            arrayPhotos.append(KingfisherSource(urlString: extractedPhotos.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!)
        }
        
        issMSITVCDetailsPicture.setImageInputs(arrayPhotos)
        
    }
    
    func didTap() {
        issMSITVCDetailsPicture.presentFullScreenController(from: listingViewController!)
    }
    
    func updateProductDetailsProductCategory(data: NSDictionary)
    {
        uilMSITVCDetailsLocation.text = "Lokasi: Tiada"
        uilMSITVCDetailsCategory.text = "Kategori: Tiada"
    }
    
    func updateProductDetailsProductSellerInfo(data: NSDictionary) {
        
        let sellerData: NSDictionary = data.value(forKey: "MYSHOP_PROD_SELLER_INFO") as! NSDictionary
        
        //uilMSITVCDetailsSellerTitle.text = (data.value(forKey: "MYSHOP_PROD_TITLE") as? String ?? "Tiada Maklumat")!
        uilMSITVCDetailsSellerName.text = (sellerData.value(forKey: "name") as? String ?? "Tiada Maklumat")!
        uilMSITVCDetailsSellerContact.text = (sellerData.value(forKey: "phone") as? String ?? "Tiada Maklumat")!
        uilMSITVCDetailsSellerEmail.text = (sellerData.value(forKey: "email") as? String ?? "Tiada Maklumat")!
        
        if(sellerData.value(forKey: "gst") as! String == "0") {
            uilMSITVCDetailsSellerGST.text = "Tiada GST"
        }
        else if(sellerData.value(forKey: "gst") as! String == "1") {
            uilMSITVCDetailsSellerGST.text = "Ada GST"
        }
        else {
            uilMSITVCDetailsSellerGST.text = "Tiada Maklumat"
        }
    }
    
    func updateProductDetailsProductDescription(data: NSDictionary) {
        
        let descString: String = data.value(forKey: "MYSHOP_PROD_TERM") as! String
        
        do {
            let attributedString = try NSAttributedString (data: descString.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
                                       options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                                       documentAttributes: nil)
            uilMSITVCDetailsProdDesc.attributedText = attributedString
        }
        catch let error {
            
            print("[MyShopIntegratedTVCell] Parsing description have problem: (\(error))")
            uilMSITVCDetailsProdDesc.text = "Tiada Maklumat"
        }
        
    }
    
    func updateProductDetailsProductReviewTitle(data: NSDictionary) {
        
        //uilMSITVCDetailsRatingTitle.text = ""
        
    }
    
    func updateProductDetailsProductComment(data: NSDictionary) {
        
        cvMSITVCRatingCommentor.rating = Double.init(data.object(forKey: "rating") as! Int)
        uilMSITVCCommentor.text = (data.object(forKey: "comment") as? String ?? "Tiada Maklumat")!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
