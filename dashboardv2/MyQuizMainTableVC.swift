//
//  MyQuizMainTableVC.swift
//  dashboardv2
//
//  Created by Mohd Zulhilmi Mohd Zain on 17/07/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class MyQuizMainTableVC: UITableViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var selectedIndex: IndexPath = IndexPath.init()
    var questionIndex: Int = 0
    var questionType: Int = 0
    var answers: NSArray? = []
    var answersID: NSArray? = []
    var singleAnswers: String? = ""
    var question: NSDictionary = [:]
    var questionId: Int = 0
    var answered: Bool = false
    var answeredIndex: Int = 0
    var selectedAnswer: NSDictionary = [:]
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func loadView() {
        
        super.loadView()
        
        questionId = Int.init(question.value(forKey: "QUESTION_ID") as! Int)
        questionType = Int.init(question.value(forKey: "QUESTION_TYPE") as! Int)
        print("Question Index: \(questionIndex)")
        print("Question ID: \(questionId)")
        checkIfAnswered(index: questionIndex)
        
        answers = question.value(forKey: "ANSWERS_ARRAY") as? NSArray
        answersID = question.value(forKey: "ANSWERS_ID_ARRAY") as? NSArray
        
        if(answers?.count != 0) {
            
            singleAnswers = question.value(forKey: "ANSWERS_ARRAY") as? String
            
        }
        
    }
    
    func checkIfAnswered(index: Int) {
        
        if(appDelegate.answeredQuestion!.count > 0) {
            
            print("Array available \(appDelegate.answeredQuestion!)")
            
            for i in 0...appDelegate.answeredQuestion!.count - 1 {
                
                let answeredSelected: NSDictionary = appDelegate.answeredQuestion!.object(at: i) as! NSDictionary
                
                if(answeredSelected.value(forKey: "QUESTION_ID") as! Int == questionId) {
                    
                    questionIndex = i
                    print("QuestionIndex: \(questionIndex)")
                    print("\(questionId) already answered")
                    selectedAnswer = answeredSelected
                    print("\(selectedAnswer) selected")
                    
                    if(questionType == 1) {
                        answeredIndex = answeredSelected.value(forKey: "ANSWER_INDEX") as! Int
                        print("\(answeredIndex) answer index")
                    }

                    answered = true
                }
                else {
                    
                    print("\(questionId) not answered / already answered")
                }
            }
            
        }
        else {
            
            print("Array zero")
            
            answered = false
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "Soalan \(String(describing: question.value(forKey: "QUESTION_NUMBER")!))"
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 205.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(answered == true && questionType == 1) {
            
            let answerIndexPath: IndexPath = IndexPath.init(row: answeredIndex, section: 1)
            print("\(answerIndexPath) Indexpath")
            self.tableView.selectRow(at: answerIndexPath, animated: true, scrollPosition: UITableViewScrollPosition.bottom)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        
        if(section == 0) {
            if(question.value(forKey: "QUESTION_IMAGE") as? String != "") { print("have image"); return 2 }
            else { print("have no image"); return 1 }
        }
        else {
            if(question.value(forKey: "QUESTION_TYPE") as! Int == 1) { print("available type \(answers!.count)"); return answers!.count }
            else { print("not available type"); return 1 }
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(question.value(forKey: "QUESTION_TYPE") as! Int == 2 && indexPath.section == 0) {
            
            if(question.value(forKey: "QUESTION_IMAGE") as! String != "" && indexPath.row == 1) {
            
                let cell: MyQuizMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MQMQuestionImageCellID") as! MyQuizMainTVCell
            
                // Configure the cell...
                cell.setQuestionWithImage(data: question)
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                return cell
                
            }
            else {
                
                let cell: MyQuizMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MQMQuestionCellID") as! MyQuizMainTVCell
                
                // Configure the cell...
                cell.setQuestion(data: String(describing: question.value(forKey: "QUESTION")!))
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                
                return cell
                
            }
            
        }
        else if(indexPath.section == 0) {

            let cell: MyQuizMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MQMQuestionCellID") as! MyQuizMainTVCell
            
            // Configure the cell...
            cell.setQuestion(data: String(describing: question.value(forKey: "QUESTION")!))
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
            return cell
            
        }
        else {
            
            if(question.value(forKey: "QUESTION_TYPE") as! Int == 1) {
            
                let cell: MyQuizMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MQMAnswerCellID") as! MyQuizMainTVCell
            
                // Configure the cell...
                cell.setAnswer(data: String(describing: answers!.object(at: indexPath.row)))
            
                let bgColorView: UIView = UIView.init()
                bgColorView.backgroundColor = UIColor.init(red: 63.0/255.0, green: 195.0/255.0, blue: 128.0/255.0, alpha: 1.0)
                cell.selectedBackgroundView = bgColorView
            
                return cell
                
            }
            else {
                
                let cell: MyQuizMainTVCell = tableView.dequeueReusableCell(withIdentifier: "MQMAnswerSubjectiveCellID") as! MyQuizMainTVCell
                
                // Configure the cell...
                cell.uitvMQMTVCAnswerSubjective.delegate = self
                
                if(selectedAnswer.value(forKey: "ANSWER_TEXT") != nil) {
                    let getAnswerIfAvailable: String = String(describing: selectedAnswer.value(forKey: "ANSWER_TEXT")!)
                    cell.setSubjectiveAnswer(answered: String(describing: getAnswerIfAvailable))
                }
                else {
                    cell.setSubjectiveAnswer(answered: "")
                }
                
                
                if(answered == true) {
                    
                    //let getAnswerIndex: NSDictionary = appDelegate.answeredQuestion!.object(at: questionIndex) as! NSDictionary
                    //cell.uitvMQMTVCAnswerSubjective.text = getAnswerIndex.value(forKey: "ANSWER_TEXT") as! String
                    
                }
                
                let bgColorView: UIView = UIView.init()
                bgColorView.backgroundColor = UIColor.init(red: 63.0/255.0, green: 195.0/255.0, blue: 128.0/255.0, alpha: 1.0)
                cell.selectedBackgroundView = bgColorView
                
                return cell
                
            }
            
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        print("Acquired text: \(textView.text!)")
        
        let answeredQuestion: NSDictionary = ["QUESTION_ID":questionId,"QUESTION_TYPE":questionType,"QUESTION_INDEX":questionIndex,"ANSWER_TEXT":textView.text!]
        
        setAnswer(questionType: questionType, questionIndexPath: nil, bundledAnswer: answeredQuestion)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndex = indexPath
        
        let answeredQuestion: NSDictionary = ["QUESTION_ID":questionId, "QUESTION_TYPE":questionType, "QUESTION_INDEX":questionIndex, "ANSWER_INDEX":indexPath.row, "ANSWER_PICKED":answers!.object(at: indexPath.row), "ANSWER_PICKED_ID":answersID!.object(at: indexPath.row)]
        
        setAnswer(questionType: questionType, questionIndexPath: indexPath.row, bundledAnswer: answeredQuestion)
        
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath == self.selectedIndex) {
            cell.setHighlighted(true, animated: true)
        }
        else {
            cell.setHighlighted(false, animated: true)
        }
    }
    
    func setAnswer(questionType: Int, questionIndexPath: Int?, bundledAnswer: NSDictionary) {
        
        print("Question type \(questionType)")
        
        if(answered == false){
            
            print("Answering the question... success")
            appDelegate.answeredQuestion?.add(bundledAnswer)
            answered = true
        }
        else {
            
            print("Removing existing answer ...")
            appDelegate.answeredQuestion?.removeObject(at: questionIndex)
            print("Success with array \(String(describing: appDelegate.answeredQuestion!))")
            print("Replacing the answer of question...")
            appDelegate.answeredQuestion?.insert(bundledAnswer, at: questionIndex)
            print("Success")
        }
        
    }
    
    /*
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.orange
        cell?.backgroundColor = UIColor.orange
        
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        
    }
    */
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
