//
//  ReviewRoundGathererViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 9/25/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

class ReviewRoundGathererViewController: UIViewController {
    
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var stringPuttsLbl: UILabel!
    @IBOutlet weak var stringScoreLbl: UILabel!
    @IBOutlet weak var backScoreArrow: UIButton!
    @IBOutlet weak var forwardScoreArrow: UIButton!
    @IBOutlet weak var forwardPuttsArrow: UIButton!
    @IBOutlet weak var backPuttsArrow: UIButton!
    @IBOutlet weak var puttsLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var x: UIButton!
    @IBOutlet weak var check: UIButton!
    @IBOutlet weak var currentQuestionLbl: UILabel!
    var questionDict:[String:Any] = [:]
    var score = 1
    var putts = 2

    var firstQuestion = ""
    var secondQuestion = ""
    var thirdQuestion = ""
    var fourthQuestion = ""
    var fifthQuestion = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmBtn.layer.cornerRadius = 5
        
        currentQuestionLbl.text = loadedQuestion
    }
    
    func changeToPuttsAndScore() {
        
        if UserDefaults.standard.string(forKey: "par") == "3" {
            score = 3
            scoreLbl.text = "3"
        } else if UserDefaults.standard.string(forKey: "par") == "4" {
            score = 4
            scoreLbl.text = "4"
        } else if UserDefaults.standard.string(forKey: "par") == "5" {
            score = 5
            scoreLbl.text = "5"
            
        }
        
        currentQuestionLbl.isHidden = true
        check.isHidden = true
        x.isHidden = true
        scoreLbl.isHidden = false
        puttsLbl.isHidden = false
        stringPuttsLbl.isHidden = false
        stringScoreLbl.isHidden = false
        backPuttsArrow.isHidden = false
        backScoreArrow.isHidden = false
        forwardPuttsArrow.isHidden = false
        forwardScoreArrow.isHidden = false
        confirmBtn.isHidden = false
    }
    
    func changeFromPutsAndScore() {
        currentQuestionLbl.isHidden = false
        check.isHidden = false
        x.isHidden = false
        scoreLbl.isHidden = true
        puttsLbl.isHidden = true
        stringPuttsLbl.isHidden = true
        stringScoreLbl.isHidden = true
        backPuttsArrow.isHidden = true
        backScoreArrow.isHidden = true
        forwardPuttsArrow.isHidden = true
        forwardScoreArrow.isHidden = true
        confirmBtn.isHidden = true
    }
    
    @IBAction func checkBtnTapped(_ sender: Any) {
        
        if firstQuestion == "" {
            firstQuestion = currentQuestionLbl.text!
        } else if secondQuestion == "" {
            secondQuestion = currentQuestionLbl.text!
        } else if thirdQuestion == "" {
            thirdQuestion = currentQuestionLbl.text!
        } else if fourthQuestion == "" {
            fourthQuestion = currentQuestionLbl.text!
        }
        
        if currentQuestionLbl.text == loadedQuestion && UserDefaults.standard.string(forKey: "par") == "3" {
            questionDict[loadedQuestion] = true
            changeToPuttsAndScore()
        } else if currentQuestionLbl.text == loadedQuestion && UserDefaults.standard.string(forKey: "par") == "4" {
            questionDict[loadedQuestion] = true
            currentQuestionLbl.text = "Were you on the green in two shots"
        } else if currentQuestionLbl.text == loadedQuestion && UserDefaults.standard.string(forKey: "par") == "5" {
            questionDict[loadedQuestion] = true
            currentQuestionLbl.text = "Was your second or third shot on the green?"
        } else if currentQuestionLbl.text == "Were you on the green in two shots" {
            questionDict["Were you on the green in two shots"] = true
            changeToPuttsAndScore()
        } else if currentQuestionLbl.text == "Was your second or third shot on the green?" {
            questionDict["Was your second or third shot on the green?"] = true
            changeToPuttsAndScore()
        } else if currentQuestionLbl.text == "Was your drive in the hazard or out of bounds?" && UserDefaults.standard.string(forKey: "par") == "4" {
            questionDict["Was your drive in the hazard or out of bounds?"] = true
            questionDict["Were you on the green in two shots"] = false
            currentQuestionLbl.text = "Were you in a greenside bunker?"
        } else if currentQuestionLbl.text == "Were you in a greenside bunker?" {
            questionDict["Were you in a greenside bunker?"] = true
            changeToPuttsAndScore()
        } else if currentQuestionLbl.text == "Was your tee shot in the hazard or out of bounds?" {
            questionDict["Was your tee shot in the hazard or out of bounds?"] = true
            currentQuestionLbl.text = "Were you in a greenside bunker?"
        } else if currentQuestionLbl.text == "Was your drive in the hazard or out of bounds?" && UserDefaults.standard.string(forKey: "par") == "5" {
            questionDict["Was your drive in the hazard or out of bounds?"] = true
            questionDict["Was your second or third shot on the green?"] = false
            currentQuestionLbl.text = "Were you in a greenside bunker?"
        }
        
        
    }
    
    @IBAction func xBtnTapped(_ sender: Any) {
        
        if firstQuestion == "" {
            firstQuestion = currentQuestionLbl.text!
        } else if secondQuestion == "" {
            secondQuestion = currentQuestionLbl.text!
        } else if thirdQuestion == "" {
            thirdQuestion = currentQuestionLbl.text!
        } else if fourthQuestion == "" {
            fourthQuestion = currentQuestionLbl.text!
        }
        
        if currentQuestionLbl.text == loadedQuestion && UserDefaults.standard.string(forKey: "par") == "3" {
            questionDict[loadedQuestion] = false
            currentQuestionLbl.text = "Was your tee shot in the hazard or out of bounds?"
        } else if currentQuestionLbl.text == loadedQuestion && UserDefaults.standard.string(forKey: "par") == "4" {
            questionDict[loadedQuestion] = false
            currentQuestionLbl.text = "Was your drive in the hazard or out of bounds?"
        } else if currentQuestionLbl.text == loadedQuestion && UserDefaults.standard.string(forKey: "par") == "5" {
            questionDict[loadedQuestion] = false
            currentQuestionLbl.text = "Was your drive in the hazard or out of bounds?"
        } else if currentQuestionLbl.text == "Were you on the green in two shots" {
            questionDict["Were you on the green in two shots"] = false
            currentQuestionLbl.text = "Were you in a greenside bunker?"
        } else if currentQuestionLbl.text == "Was your tee shot in the hazard or out of bounds?" {
            questionDict["Was your tee shot in the hazard or out of bounds?"] = false
            currentQuestionLbl.text = "Were you in a greenside bunker?"
        } else if currentQuestionLbl.text == "Were you in a greenside bunker?" {
            questionDict["Were you in a greenside bunker?"] = false
            changeToPuttsAndScore()
        } else if currentQuestionLbl.text == "Was your drive in the hazard or out of bounds?" && UserDefaults.standard.string(forKey: "par") == "4" {
            questionDict["Was your drive in the hazard or out of bounds?"] = false
            currentQuestionLbl.text = "Was your second or third shot on the green?"
        } else if currentQuestionLbl.text == "Were you in a greenside bunker?" {
            questionDict["Were you in a greenside bunker?"] = false
            changeToPuttsAndScore()
        } else if currentQuestionLbl.text == "Was your drive in the hazard or out of bounds?" && UserDefaults.standard.string(forKey: "par") == "5" {
            questionDict["Was your drive in the hazard or out of bounds? "] = false
            currentQuestionLbl.text = "Were you on the green in two shots"
        } else if currentQuestionLbl.text == "Was your second or third shot on the green?" {
            questionDict["Was your second or third shot on the green?"] = false
            currentQuestionLbl.text = "Was your drive in the hazard or out of bounds?"
        }
        
    }
    
    @IBAction func forwardScoreArrowTapped(_ sender: Any) {
        
        scoreLbl.text = "\(score + 1)"
        score += 1
        
    }
    
    @IBAction func forwardPuttsTapped(_ sender: Any) {
        
        puttsLbl.text = "\(putts + 1)"
        putts += 1
        
    }
    
    @IBAction func backScoreArrowTapped(_ sender: Any) {
        if score != 1 {
            scoreLbl.text = "\(score - 1)"
            score -= 1
        }
    }
    @IBAction func backPuttsTapped(_ sender: Any) {
        if putts != 0 {
            puttsLbl.text = "\(putts - 1)"
            putts -= 1
        }
    }
    
    
    @IBAction func confirmBtnTapped(_ sender: Any) {
    Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").getDocuments { (querySnapshot, error) in
            
            let roundNumber = querySnapshot!.documents.count
            let holeNumber = UserDefaults.standard.integer(forKey: "specificHole")
        
            self.questionDict["score"] = self.score
            self.questionDict["putts"] = self.putts
            self.questionDict["par"] = UserDefaults.standard.string(forKey: "par")
        
            // set data from questionDict
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(roundNumber)").collection("Holes").document("\(holeNumber)").setData(self.questionDict)
        
            self.performSegue(withIdentifier: "unwindToFullList", sender: self)
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        if confirmBtn.isHidden == false {
            
            changeFromPutsAndScore()
            
            if secondQuestion == "" {
                currentQuestionLbl.text = firstQuestion
                questionDict.removeValue(forKey: firstQuestion)
                firstQuestion = ""
            } else if thirdQuestion == "" {
                currentQuestionLbl.text = secondQuestion
                questionDict.removeValue(forKey: secondQuestion)
                secondQuestion = ""
            } else if fourthQuestion == "" {
                currentQuestionLbl.text = thirdQuestion
                questionDict.removeValue(forKey: thirdQuestion)
                thirdQuestion = ""
            } else if fifthQuestion == "" {
                currentQuestionLbl.text = fourthQuestion
                questionDict.removeValue(forKey: fourthQuestion)
                fourthQuestion = ""
            } else if fifthQuestion != "" {
                currentQuestionLbl.text = fifthQuestion
                questionDict.removeValue(forKey: fifthQuestion)
                fifthQuestion = ""
            }
            
        } else if firstQuestion == "" {
            performSegue(withIdentifier: "unwindSegueToHoleType", sender: self)
        } else if secondQuestion == "" {
            currentQuestionLbl.text = firstQuestion
            questionDict.removeValue(forKey: firstQuestion)
            firstQuestion = ""
        } else if thirdQuestion == "" {
            currentQuestionLbl.text = secondQuestion
            questionDict.removeValue(forKey: secondQuestion)
            secondQuestion = ""
        } else if fourthQuestion == "" {
            currentQuestionLbl.text = thirdQuestion
            questionDict.removeValue(forKey: thirdQuestion)
            thirdQuestion = ""
        } else if fifthQuestion == "" {
            currentQuestionLbl.text = fourthQuestion
            questionDict.removeValue(forKey: fourthQuestion)
            fourthQuestion = ""
        } else if fifthQuestion != "" {
            currentQuestionLbl.text = fifthQuestion
            questionDict.removeValue(forKey: fifthQuestion)
            fifthQuestion = ""
        }
    }
}
