//
//  MyQuizMainTVCell.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 17/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyQuizMainTVCell: UITableViewCell {

    @IBOutlet weak var uilMQMTVCQuestionTitle: UILabel!
    @IBOutlet weak var uilMQMTVCQuestion: UILabel!
    @IBOutlet weak var uiivMQMTVCQuestionImage: UIImageView!
    
    @IBOutlet weak var uilMQMTVCAnswer: UILabel!
    @IBOutlet weak var uiivMQMTVCAnswerImage: UIImageView!
    @IBOutlet weak var uilMQMTVCAnswerImageText: UILabel!
    @IBOutlet weak var uitvMQMTVCAnswerSubjective: UITextView!
    @IBOutlet weak var uitfMQMTVCAnswerSingleSubjective: UITextField!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setQuestionTitle(data: String) {
        
        uilMQMTVCQuestionTitle.text = String(describing: "Soalan \(data)")
        self.backgroundColor = DBColorSet.dashboardMainColor
    }
    
    func setQuestion(data: String) {
    
        uilMQMTVCQuestion.text = String(describing: data)
    }
    
    func setQuestionWithImage(data: NSDictionary) {
        
        print("image? : \(String(describing:data.value(forKey: "QUESTION_IMAGE")!))")
        
        ZImages.getImageFromUrlSession(fromURL: String(describing:data.value(forKey: "QUESTION_IMAGE")!), defaultImage: "ic_bannerdbi.png", imageView: uiivMQMTVCQuestionImage)
    }
    
    func setAnswer(data: String) {
        
        uilMQMTVCAnswer.text = String(describing: "\(data)")
        self.bounds = CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: 200)
        self.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 200)
    }

    func setAnswerWithImage(data: NSDictionary) {
        
    }
    
    func setSubjectiveAnswer(answered: String) {
        
        uitvMQMTVCAnswerSubjective.bounds = CGRect.init(x: 0, y: 0, width: uitvMQMTVCAnswerSubjective.bounds.width, height: 10)
        uitvMQMTVCAnswerSubjective.layer.borderWidth = CGFloat(1.0)
        uitvMQMTVCAnswerSubjective.layer.borderColor = UIColor.black.cgColor
        uitvMQMTVCAnswerSubjective.text = answered
        
    }
    
}
