//
//  HomeViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

var tellUserAboutLastRound = false

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var averagePlusMinusPar: UILabel!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var startRoundBtn: UIButton!
    @IBOutlet weak var puttsPerHoleLbl: UILabel!
    @IBOutlet weak var scramblingPercentageLbl: UILabel!
    @IBOutlet weak var sandSavePercentageLbl: UILabel!
    @IBOutlet weak var parThreeHorOB: UILabel!
    @IBOutlet weak var parThreeGIR: UILabel!
    @IBOutlet weak var parThreeAvgScore: UILabel!
    @IBOutlet weak var parFourGIR: UILabel!
    @IBOutlet weak var parFourHorOB: UILabel!
    @IBOutlet weak var parFourAvgScore: UILabel!
    @IBOutlet weak var parFourHitFairwayPercentage: UILabel!
    @IBOutlet weak var parFiveGIR: UILabel!
    @IBOutlet weak var parFiveHorOB: UILabel!
    @IBOutlet weak var parFiveHitFairwayPercentage: UILabel!
    @IBOutlet weak var parFiveAvgScore: UILabel!
    
    var roundNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var parThrees = 0.0
        var parFours = 0.0
        var parFives = 0.0
        var totalPar = 0.0
        var totalScore = 0.0
        var totalPutts = 0.0
        var scramblingChances = 0.0
        var scramblesCompleted = 0.0
        var sandSaveChances = 0.0
        var sandSavesCompleted = 0.0
        var hitInHorOBParThree = 0.0
        var hitInHorOBParFour = 0.0
        var hitInHorOBParFive = 0.0
        var parThreeGIR = 0.0
        var parFourGIR = 0.0
        var parFiveGIR = 0.0
        var totalParThreeScore = 0.0
        var totalParFourScore = 0.0
        var totalParFiveScore = 0.0
        var parFourFairwaysHit = 0.0
        var parFiveFairwaysHit = 0.0
        
        
        let name = Auth.auth().currentUser!.displayName
        if name != nil {
            welcomeLbl.text = "Welcome \(name!)"
        }
        
        // set up welcomeLbl
        
        let roundRef: CollectionReference = Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds")
        
        // establish how many round to query
        
        var roundCount = 10.0
        roundRef.getDocuments { (collectionSnapshot, error) in
            
            if collectionSnapshot?.count == 0 {
                roundCount = 0
                return
            }
            
            roundRef.document("\(collectionSnapshot!.count)").getDocument(completion: { (document, error) in
                
                guard error == nil else {
                    return
                }
                
                let data = document?.data()
                
                let doesCount = data!["doesCount"] as! Bool
                
                if roundCount >= 11 && doesCount == false {
                    roundCount = 11
                } else if roundCount >= 11 && doesCount == true {
                    roundCount = 10
                } else if doesCount == false {
                    roundCount = Double(collectionSnapshot!.documents.count - 1)
                } else {
                    roundCount = Double(collectionSnapshot!.documents.count)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                
                
                let totalPlusMinusPar = totalScore - totalPar
                
                let totalHoles = parFives + parFours + parThrees
                
                if totalPlusMinusPar != 0 {
                    let avgPlusMinusPar = totalPlusMinusPar / roundCount
                    let str = String(format: "%.2f", avgPlusMinusPar)
                    if avgPlusMinusPar > 0 {
                        self.averagePlusMinusPar.text = "+" + str
                    } else {
                        self.averagePlusMinusPar.text = str
                    }
                } else {
                    self.averagePlusMinusPar.text = "N/A"
                }
                
                
                if totalPutts != 0 {
                    let puttsPerHole = totalPutts / totalHoles
                    let str = String(format: "%.2f", puttsPerHole)
                    self.puttsPerHoleLbl.text = str
                } else {
                    self.puttsPerHoleLbl.text = "N/A"
                }
                
                if scramblingChances != 0 {
                    let scramblingPercentage = (scramblesCompleted / scramblingChances) * 100
                    let str = String(format: "%.2f", scramblingPercentage)
                    self.scramblingPercentageLbl.text = str + "%"
                } else {
                    self.scramblingPercentageLbl.text = "N/A"
                }
                
                
                if sandSaveChances != 0 {
                    let sandSavePercentage = (sandSavesCompleted / sandSaveChances) * 100
                    let str = String(format: "%.2f", sandSavePercentage)
                    self.sandSavePercentageLbl.text = str + "%"
                } else {
                    self.sandSavePercentageLbl.text = "N/A"
                }
                
                if parThrees != 0 {
                    let parThreeHorOBPercentage = hitInHorOBParThree / parThrees * 100
                    let str = String(format: "%.2f", parThreeHorOBPercentage)
                    self.parThreeHorOB.text = str + "%"
                } else {
                    self.parThreeHorOB.text = "N/A"
                }
                
                if parFours != 0 {
                    let parFourHorOBPercentage = hitInHorOBParFour / parFours * 100
                    let str = String(format: "%.2f", parFourHorOBPercentage)
                    self.parFourHorOB.text = str + "%"
                } else {
                    self.parFourHorOB.text = "N/A"
                }
                
                if parFives != 0 {
                    let parFiveHorOBPercentage = hitInHorOBParFive / parFives * 100
                    let str = String(format: "%.2f", parFiveHorOBPercentage)
                    self.parFiveHorOB.text = str + "%"
                } else {
                    self.parFiveHorOB.text = "N/A"
                }
                
                if parThrees != 0 {
                    let gIRPercentage = parThreeGIR / parThrees * 100
                    let str = String(format: "%.2f", gIRPercentage)
                    self.parThreeGIR.text = str + "%"
                } else {
                    self.parThreeGIR.text = "N/A"
                }
                
                if parFours != 0 {
                    let gIRPercentage = parFourGIR / parFours * 100
                    let str = String(format: "%.2f", gIRPercentage)
                    self.parFourGIR.text = str + "%"
                } else {
                    self.parFourGIR.text = "N/A"
                }
                
                if parFives != 0 {
                    let gIRPercentage = parFiveGIR / parFives * 100
                    let str = String(format: "%.2f", gIRPercentage)
                    self.parFiveGIR.text = str + "%"
                } else {
                    self.parFiveGIR.text = "N/A"
                }
                
                if parThrees != 0 {
                    let avgScore = totalParThreeScore / parThrees
                    let str = String(format: "%.2f", avgScore)
                    self.parThreeAvgScore.text = str
                } else {
                    self.parThreeAvgScore.text = "N/A"
                }
                
                if parFours != 0 {
                    let avgScore = totalParFourScore / parFours
                    let str = String(format: "%.2f", avgScore)
                    self.parFourAvgScore.text = str
                } else {
                    self.parFourAvgScore.text = "N/A"
                }
                
                if parFives != 0 {
                    let avgScore = totalParFiveScore / parFives
                    let str = String(format: "%.2f", avgScore)
                    self.parFiveAvgScore.text = str
                } else {
                    self.parFiveAvgScore.text = "N/A"
                }
                
                if parFours != 0 {
                    let hitFairwayPercentage = parFourFairwaysHit / parFours * 100
                    let str = String(format: "%.2f", hitFairwayPercentage)
                    self.parFourHitFairwayPercentage.text = str + "%"
                } else {
                    self.parFourHitFairwayPercentage.text = "N/A"
                }
                
                if parFives != 0 {
                    let hitFairwayPercentage = parFiveFairwaysHit / parFives * 100
                    let str = String(format: "%.2f", hitFairwayPercentage)
                    self.parFiveHitFairwayPercentage.text = str + "%"
                } else {
                    self.parFiveHitFairwayPercentage.text = "N/A"
                }
                    
                })
                
            })
            
        }
        
            // query last 20 actual rounds
        
            roundRef.limit(to: Int(roundCount)).getDocuments { (querySnapshot, error) in
            
            // take data from each document
            
            for document in querySnapshot!.documents {
                
                
                roundRef.document(document.documentID).collection("Holes").getDocuments(completion: { (snapshot, error) in
                    
                    // find out if round is 9 holes or not
                    
                    var is9Holes = false
                    
                    if snapshot!.documents.count == 9 {
                        is9Holes = true
                    }
                    
                    
                    for document in snapshot!.documents {
                        
                        if snapshot?.documents.count != 18 && snapshot?.documents.count != 9 {
                            continue
                        }
                        
                        // allocate into variables
                        
                        let data = document.data()
                        
                        let par: String = data["par"] as! String
                        let score: Double = data["score"] as! Double
                        let putts: Double = data["putts"] as! Double
                        
                        
                        
                        totalPutts += putts
                        
                        // if 9 holes, double certain variables to equate to an 18 hole round
                        
                        if is9Holes == false {
                            
                            totalScore += score*2
                            
                            if par == "3" {
                                totalPar += 6
                                parThrees += 1
                                totalParThreeScore += score
                            }
                            if par == "4" {
                                totalPar += 8
                                parFours += 1
                                totalParFourScore += score
                            }
                            if par == "5" {
                                totalPar += 10
                                parFives += 1
                                totalParFiveScore += score
                            }
                            
                            
                        } else {
                            
                            totalScore += score
                            
                            if par == "3" {
                                totalPar += 3
                                parThrees += 1
                                totalParThreeScore += score
                            }
                            if par == "4" {
                                totalPar += 4
                                parFours += 1
                                totalParFourScore += score
                            }
                            if par == "5" {
                                totalPar += 5
                                parFives += 1
                                totalParFiveScore += score
                            }
                            
                        }
                        
                            
                        for (key, value) in data {
                            
                            
                            
                            if key == "Was your tee shot on the green?" {
                                if value as! Bool == true {
                                    parThreeGIR += 1
                                }
                                
                                if value as! Bool == false {
                                    scramblingChances += 1
                                    if score <= 3 {
                                        scramblesCompleted += 1
                                    }
                                }
                            }
                            
                            if key == "Was your drive in the fairway?" {
                                
                                if value as! Bool == true && par == "4" {
                                    parFourFairwaysHit += 1
                                } else if value as! Bool == true && par == "5" {
                                    parFiveFairwaysHit += 1
                                }
                                
                            }
                            
                            if key == "Was your second or third shot on the green?" {
                                if value as! Bool == true {
                                    parFiveGIR += 1
                                }
                                
                                if value as! Bool == false {
                                    scramblingChances += 1
                                    if score <= 5 {
                                        scramblesCompleted += 1
                                    }
                                }
                            }
                            
                            if key == "Were you on the green in two shots" {
                                if value as! Bool == true {
                                    parFourGIR += 1
                                }
                                
                                if value as! Bool == false {
                                    scramblingChances += 1
                                    if score <= 4 {
                                        scramblesCompleted += 1
                                    }
                                }
                            }
                            
                            if key == "Were you in a greenside bunker?" {
                                if value as! Bool == true {
                                    sandSaveChances += 1
                                    if putts == 1 {
                                        sandSavesCompleted += 1
                                    }
                                }
                            }
                            
                            if key == "Was your drive in the hazard or out of bounds?" && par == "4" {
                                if value as! Bool == true {
                                    hitInHorOBParFour += 1
                                }
                                
                            }
                            
                            if key == "Was your drive in the hazard or out of bounds?" && par == "5" {
                                if value as! Bool == true {
                                    hitInHorOBParFive += 1
                                }
                            }
                            
                            if key == "Was your tee shot in the hazard or out of bounds?" {
                                if value as! Bool == true {
                                    hitInHorOBParThree += 1
                                }
                            }
                        }
                    }
                })
            }
        }
    }
    
    @IBAction func logOutBtnTapped(_ sender: Any) {
        
        createAlert(title: "Just Checking", message: "Are you sure you want to log out?")
        
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .destructive, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            self.performSegue(withIdentifier: "logOutSegue", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertTwo(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "New Round", style: .default, handler: { (action) in
            
            let roundRef: CollectionReference = Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds")
            roundRef.document("\(self.roundNumber!)").collection("Holes").getDocuments(completion: { (snapshot, error) in
                
                    for i in 1...snapshot!.documents.count {
                    
                    roundRef.document("\(self.roundNumber!)").collection("Holes").document("\(i)").delete()
                    
                }
                
            })
                
                roundRef.document("\(self.roundNumber!)").setData(["doesCount" : false])
            
            
            alert.dismiss(animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "toHoleTypeSegue", sender: self)
        }))
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
            self.performSegue(withIdentifier: "toHoleTypeSegue", sender: self)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func createAlertThree(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField { (textfield) in
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                
                changeRequest?.displayName = textfield.text
                changeRequest?.commitChanges(completion: { (error) in
                    guard error == nil else {
                        AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                        return
                    }
                    
                    self.welcomeLbl.text = "Welcome \(textfield.text!)"
                    
                })
                
                alert.dismiss(animated: true, completion: nil)
            }))
            
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func startRoundBtnTapped(_ sender: Any) {
        
       // get roundNumber
    Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").getDocuments { (querySnapshot, error) in
            
            self.roundNumber = querySnapshot!.documents.count
           
            // check holeNumber
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(self.roundNumber!)").collection("Holes").getDocuments { (querySnapshot, error) in
                    
                let holeNumber = querySnapshot!.documents.count
                
                
                if holeNumber == 18 {
                    self.performSegue(withIdentifier: "toConfirmIfEighteen", sender: self)
                } else if holeNumber == 9 {
                    tellUserAboutLastRound = true
                    self.performSegue(withIdentifier: "toNineOrEighteenIfNine", sender: self)
                } else if holeNumber != 0 {
                    self.createAlertTwo(title: "Just Checking", message: "You have a round in progress, do you want to continue it or start a new one?")
                } else {
                    self.performSegue(withIdentifier: "toHoleTypeSegue", sender: self)
                }
            }
        }
    }
    
    
    @IBAction func changeNameBtnTapped(_ sender: Any) {
        
        createAlertThree(title: "Name Change", message: "What is your new display name?")
        
    }
    
    @IBAction func unwindHome(_ sender: UIStoryboardSegue) {}
    
    
}
