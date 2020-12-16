//
//  SelectedHoleDataViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 11/16/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class SelectedHoleDataViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var holeLbl: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var parLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var puttsLbl: UILabel!
    @IBOutlet weak var questionOneLbl: UILabel!
    @IBOutlet weak var questionThreeLbl: UILabel!
    @IBOutlet weak var questionOneX: UIButton!
    @IBOutlet weak var questionTwoX: UIButton!
    @IBOutlet weak var questionFiveCheck: UIButton!
    @IBOutlet weak var questionFiveX: UIButton!
    @IBOutlet weak var questionFourX: UIButton!
    @IBOutlet weak var questionFourCheck: UIButton!
    @IBOutlet weak var questionThreeX: UIButton!
    @IBOutlet weak var questionThreeCheck: UIButton!
    @IBOutlet weak var questionTwoCheck: UIButton!
    @IBOutlet weak var questionOneCheck: UIButton!
    @IBOutlet weak var questionFiveLbl: UILabel!
    @IBOutlet weak var questionFourLbl: UILabel!
    @IBOutlet weak var questionTwoLbl: UILabel!
    var selectedRound: Int = 0
    var selectedHole: Int = 0
    var userID: String = ""
    var questionLblArray: [UILabel] = []
    var checkArray: [UIButton] = []
    var xArray: [UIButton] = []
    var docData: [String:Any] = [:]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-2790005755690511/1894362020"
        bannerView.rootViewController = self
        let bannerRequest = GADRequest()
        bannerView.load(bannerRequest)
        bannerView.delegate = self
        
        selectedRound = UserDefaults.standard.integer(forKey: "previousRoundNumberSelected")
        selectedHole = UserDefaults.standard.integer(forKey: "selectedHole")
        
        holeLbl.text = "Hole \(selectedHole)"
        
        userID = Auth.auth().currentUser?.uid ?? ""
        questionLblArray = [questionOneLbl, questionTwoLbl, questionThreeLbl, questionFourLbl, questionFiveLbl]
        checkArray = [questionOneCheck, questionTwoCheck, questionThreeCheck, questionFourCheck, questionFiveCheck]
        xArray = [questionOneX, questionTwoX, questionThreeX, questionFourX, questionFiveX]
        
        Firestore.firestore().collection("Users").document(userID).collection("Rounds").document("\(selectedRound)").collection("Holes").document("\(selectedHole)").getDocument(completion: { (snap, error) in
                
            self.docData = snap?.data() as! [String:Any]
            let score = self.docData["score"] as! Int
            let par = self.docData["par"] as! String
            let putts = self.docData["putts"] as! Int
            
            self.scoreLbl.text = "\(score)"
            self.puttsLbl.text = "\(putts)"
            self.parLbl.text = "Par : " + par
            
            
            self.docData.removeValue(forKey: "score")
            self.docData.removeValue(forKey: "par")
            self.docData.removeValue(forKey: "putts")
            
            
            for i in 0...self.docData.count-1 {
                    self.questionLblArray[i].isHidden = false
                    self.checkArray[i].isHidden = false
                    self.xArray[i].isHidden = false
                }
            
            var origIndex = 0
            
            for (key, value) in self.docData {
                
                    self.questionLblArray[origIndex].text = key
                    if value as! Bool == true {
                        self.xArray[origIndex].alpha = 0.25
                    } else {
                        self.checkArray[origIndex].alpha = 0.25
                    }
                    origIndex += 1
                    
                }
            
            self.docData["score"] = score
            self.docData["putts"] = putts
            self.docData["par"] = par
            
            
            })
        
    }
    

}
