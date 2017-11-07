//
//  MyQuizQuestionSelectTableVC.swift
//  dashboardv2
//
//  Question type indicator:
//
//  1 - Objective with selection of answers
//  2 - Subjective with only a true answer
//  3 - Subjective without valid answers (opinion)
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyQuizQuestionSelectTableVC: UITableViewController {

    var exampleSetQuestion: NSArray = []
    var setQuestion: NSMutableArray = []
    var questionNumber: Int = 0
    var answeredQuestion: NSMutableArray = []
    
     let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let quizQuestionRegisteredNotification: String = "MyQuizQuestion"
    let quizSendAnswerRegisteredNotification: String = "MyQuizSendAnswer"
    
    enum GotError: Error {
        case FoundNil(String)
    }

    override func loadView() {
        super.loadView()
        
        //preparing questions
        
        DBWebServices.getMyQuizGetQuestions(token: String(describing:"\(UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!)"), registeredNotification: quizQuestionRegisteredNotification)
        
        let exampleAnswers1: NSArray = ["A. Empat belas melintang jalurmu","B. Kuning Merah Biru Oren","C. Hijau Biru Merah Putih","D. Biru"]
        let exampleAnswers2: NSArray = ["A. 5 Orang","B. 4 Orang","C. Seorang","D. Tiada"]
        let exampleQuestion1: NSDictionary = ["QUESTION_ID":1001,"QUESTION_NUMBER":"1","QUESTION_TYPE":1,"QUESTION":"Apakah warna lambang dashboard yang anda ketahui?","QUESTION_IMAGE":"","ANSWERS_ARRAY":exampleAnswers1]
        let exampleQuestion2: NSDictionary = ["QUESTION_ID":1002,"QUESTION_NUMBER":"2","QUESTION_TYPE":1,"QUESTION":"Berapakah bilangan orang dalam lambang dashboard itu?","QUESTION_IMAGE":"","ANSWERS_ARRAY":exampleAnswers2]
        let exampleQuestion3: NSDictionary = ["QUESTION_ID":1003,"QUESTION_NUMBER":"3","QUESTION_TYPE":2,"QUESTION":"Berapakah bilangan orang dalam lambang dashboard itu?","QUESTION_IMAGE":"aa","ANSWERS_ARRAY":[]]
        let exampleQuestion4: NSDictionary = ["QUESTION_ID":1004,"QUESTION_NUMBER":"4","QUESTION_TYPE":2,"QUESTION":"Masukkan slogan","QUESTION_IMAGE":"","ANSWERS_ARRAY":[]]
        exampleSetQuestion = [exampleQuestion1,exampleQuestion2,exampleQuestion3,exampleQuestion4]

        
    }
    
    override func viewDidLoad() { 
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let submitButton: UIBarButtonItem = UIBarButtonItem.init(title: "Hantar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(sendParticipation))
        self.navigationItem.rightBarButtonItem = submitButton
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(populateData(data:)), name: Notification.Name(quizQuestionRegisteredNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(responseFromSendAnswer(data:)), name: Notification.Name(quizSendAnswerRegisteredNotification), object: nil)
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name(quizQuestionRegisteredNotification), object: nil);
        NotificationCenter.default.removeObserver(self, name: Notification.Name(quizSendAnswerRegisteredNotification), object: nil);
    }
    
    @objc func populateData(data: NSDictionary) {
        
        let getPopulatedData: NSDictionary = data.value(forKey: "object") as! NSDictionary
        
        if(getPopulatedData.value(forKey: "GET_RESPONDED") as? String == "200" || getPopulatedData.value(forKey: "status") as? Int == 1) {
        
            let getData: NSArray = getPopulatedData.value(forKey: "data") as! NSArray
        
            let getUrlImage: String = getPopulatedData.value(forKey: "url_image") as! String
        
            let getResoImage: NSDictionary = getPopulatedData.value(forKey: "reso_image") as! NSDictionary
        
            for i in 0...getData.count - 1 {
            
                var questionID: Int? = 0
                var questionType: Int? = 0
                var question: String? = ""
                var questionImage: String? = ""
            
                var answersID: Int? = 0
                var answersQuestionID: Int? = 0
                var answer: String? = ""
            
                let questionData: NSDictionary? = getData.object(at: i) as? NSDictionary
                print("Question is \(String(describing: questionData!.value(forKey: "question")))")
            
                questionID = Int(String(describing:questionData!.value(forKey: "id")!))
                questionType = Int(String(describing:questionData!.value(forKey: "type")!))
                question = String(describing: questionData!.value(forKey: "question") as! String)
            
                print("Inserting answers...")
            
                let answersDataInArray: NSArray? = questionData?.value(forKey: "answers") as? NSArray
                let answersDataInDict: NSDictionary? = questionData?.value(forKey: "answers") as? NSDictionary
                let setOfAnswers: NSMutableArray = []
                let setOfAnswersId: NSMutableArray = []
            
                if(answersDataInArray != nil) {
                
                    print("NSArray Data")
                    
                    if(answersDataInArray?.count != 0)
                    {
                        for a in 0...answersDataInArray!.count - 1 {
                    
                            print("Inserting data...")
                            let answersData: NSDictionary? = answersDataInArray?.object(at: a) as? NSDictionary
                        
                            answersID = Int(String(describing: answersData!.value(forKey: "id")!))
                            answersQuestionID = Int(String(describing: answersData!.value(forKey: "question_id")!))
                            answer = String(describing: answersData!.value(forKey: "answer")!)
                            answersID = Int.init(String(describing: answersData!.value(forKey: "id")!))
                        
                            //\(getUrlImage)\(String(describing:getResoImage.value(forKey: "large")!))
                            setOfAnswers.add(answer!)
                            setOfAnswersId.add(answersID!)
                    
                            print("Answers: \(answersData?.value(forKey: "answer") as! String)")
                    
                        }
                        
                        print("Set of answers: \(setOfAnswers) and answers id: \(setOfAnswersId)")
                    }
                }
                else {
                
                    print("NSDict Data")
                
                }
            
                if((questionData!.value(forKey: "image") as? NSNull) == nil) {
                    print("Not nulled")
                    questionImage = "\(getUrlImage)\(String(describing:getResoImage.value(forKey: "large")!))\(String(describing:(questionData!.value(forKey: "image")!)))"
                }
                else {
                    print("nulled")
                    questionImage = ""
                }
            
                let definedQuestion: NSDictionary = ["QUESTION_ID":questionID!,"QUESTION_NUMBER":i+1,"QUESTION_TYPE":questionType!,"QUESTION":question!,"QUESTION_IMAGE":questionImage!,"ANSWERS_ARRAY":setOfAnswers, "ANSWERS_ID_ARRAY":setOfAnswersId]
            
                print("QuestionSettled: \(definedQuestion)")
            
                setQuestion.add(definedQuestion)
            
            }
        
            DispatchQueue.main.async {
            
                self.tableView.reloadData()
            
            }
        
        }
        else {
            print("No dataaa")
        }
    }

    @objc func responseFromSendAnswer(data: NSDictionary) {
        
        print("Answer sent with response \(data.value(forKey: "object") as! NSDictionary)")
        
        let unwrapAnswer: NSDictionary = data.value(forKey: "object") as! NSDictionary
        let answerRemainingData: NSArray = unwrapAnswer.value(forKey: "data") as! NSArray
        //let answerRemaining: NSDictionary = answerRemainingData.value(forKey: "answers") as! NSDictionary
        
        if(self.setQuestion.count != answerRemainingData.count) { print("Have remaining questions") }
        self.appDelegate.quizSubmitted = true
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sendParticipation(sender: UIBarButtonItem) {
        
        let sendConfirmAlertController: UIAlertController = UIAlertController.init(title: "Confirm", message: "Confirm to send?", preferredStyle: UIAlertControllerStyle.alert)
        
        let sendNoAction: UIAlertAction = UIAlertAction.init(title: "Tidak", style: UIAlertActionStyle.cancel, handler: { action -> Void in
            
            
        })
        
        sendConfirmAlertController.addAction(sendNoAction)
        
        let sendYesAction: UIAlertAction = UIAlertAction.init(title: "Ya", style: UIAlertActionStyle.default, handler: { action -> Void in
            
            print("Answer to submit: \(self.appDelegate.answeredQuestion!)")
            
            print("Preparing answer...")
            
            if(self.appDelegate.answeredQuestion!.count != 0) {
                
                let answerUserInArray: NSMutableArray = []
                
                for i in 0...self.appDelegate.answeredQuestion!.count - 1 {
                    
                    let breakingUpArray: NSDictionary = self.appDelegate.answeredQuestion!.object(at: i) as! NSDictionary
                    var answerFull: String = ""
                    
                    if(breakingUpArray.value(forKey: "ANSWER_PICKED_ID") != nil) {
                        
                        answerFull = String(describing:breakingUpArray.value(forKey: "ANSWER_PICKED_ID")!)
                        
                    }
                    else {
                        
                        answerFull = String(describing:breakingUpArray.value(forKey: "ANSWER_TEXT")!)
                        
                    }
                    
                    let answerUser: NSDictionary = ["type":String(describing:breakingUpArray.value(forKey: "QUESTION_TYPE")!),"answer":answerFull,"id":String(describing:breakingUpArray.value(forKey: "QUESTION_ID")!)]
                    
                    answerUserInArray.add(answerUser)
                    
                }
                
                print("Answer prepared: \(answerUserInArray)")
                print("Wrapping up...")
                
                let answerWrappedUp: NSDictionary = ["answer_id":answerUserInArray]
                
                print("Answer wrapped up: \(answerWrappedUp)")
                
                DBWebServices.getMyQuizSendAnswers(token: String(describing:"\(UserDefaults.standard.object(forKey: "SuccessLoggerDashboardToken")!)"), data: answerWrappedUp, registeredNotification: self.quizSendAnswerRegisteredNotification)
                
            }
            
        })
        
        sendConfirmAlertController.addAction(sendYesAction)
        sendConfirmAlertController.preferredAction = sendYesAction
        
        self.present(sendConfirmAlertController, animated: true, completion: nil)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0) { return 1 }
        else if(section == 1 && setQuestion.count == 0) { return 1 }
        else { return setQuestion.count }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { //MQQuestionCellID
        
        if(indexPath.section == 0) {
            
            let cell: MyQuizQuestionSelectTVCell = tableView.dequeueReusableCell(withIdentifier: "MQQTitleCellID", for: indexPath) as! MyQuizQuestionSelectTVCell

            // Configure the cell...
            cell.selectionStyle = UITableViewCellSelectionStyle.none

            return cell
            
        }
        else if(indexPath.section == 1 && setQuestion.count == 0) {
            //MQMLoadingCellID
            let cell: MyQuizQuestionSelectTVCell = tableView.dequeueReusableCell(withIdentifier: "MQQLoadingCellID", for: indexPath) as! MyQuizQuestionSelectTVCell
            
            // Configure the cell...
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
        }
        else {
            
            let cell: MyQuizQuestionSelectTVCell = tableView.dequeueReusableCell(withIdentifier: "MQQQuestionNumberCellID", for: indexPath) as! MyQuizQuestionSelectTVCell
            
            // Configure the cell...
            let getQuestionData: NSDictionary = setQuestion.object(at: indexPath.row) as! NSDictionary
            cell.setQuestionNumber(data: String(describing: getQuestionData.value(forKey: "QUESTION_NUMBER")!))
            
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if(indexPath.section == 1) {
            questionNumber = indexPath.row
            self.performSegue(withIdentifier: "DB_GOTO_QUIZ_QUESTION", sender: self)
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(setQuestion.count == 0 && indexPath.section == 1) { return 100.0 }
        else { return 80.0 }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let passDataToSegue: MyQuizMainTableVC = segue.destination as! MyQuizMainTableVC
        
        passDataToSegue.question = setQuestion.object(at: questionNumber) as! NSDictionary
        passDataToSegue.questionIndex = questionNumber
    }
    

}
