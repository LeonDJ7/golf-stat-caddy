//
//  HoleTypeSelectionViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

var loadedQuestion = String()

class HoleTypeSelectionViewController: UIViewController, GADBannerViewDelegate, GADInterstitialDelegate {

    @IBOutlet weak var plusOrMinusLbl: UILabel!
    @IBOutlet weak var totalScoreLbl: UILabel!
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var par5Btn: UIButton!
    @IBOutlet weak var par4Btn: UIButton!
    @IBOutlet weak var par3Btn: UIButton!
    @IBOutlet weak var returnToHomescreenBtn: UIButton!
    @IBOutlet weak var fullListOfHolesBtn: UIButton!
    @IBOutlet weak var holeLbl: UILabel!
    var interstitial: GADInterstitial!
    var roundCount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRoundCount()
        setScoreLabels()
        
        par3Btn.layer.cornerRadius = 5
        par4Btn.layer.cornerRadius = 5
        par5Btn.layer.cornerRadius = 5
        
        bannerView.adUnitID = "ca-app-pub-2790005755690511/2380403607"
        bannerView.rootViewController = self
        let bannerRequest = GADRequest()
        bannerView.load(bannerRequest)
        bannerView.delegate = self
        
        par3Btn.layer.cornerRadius = 5
        par4Btn.layer.cornerRadius = 5
        par5Btn.layer.cornerRadius = 5
        returnToHomescreenBtn.layer.cornerRadius = 5
        fullListOfHolesBtn.layer.cornerRadius = 5
        updateHoleLbl()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-2790005755690511/9114376490")
        interstitial.delegate = self
        let interstitialRequest = GADRequest()
        interstitial.load(interstitialRequest)
        interstitial = createAndLoadInterstitial()
        
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-2790005755690511/9114376490")
        interstitial.delegate = self
        let interstitialRequest = GADRequest()
        interstitial.load(interstitialRequest)
        return interstitial
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
        
        performSegue(withIdentifier: "toQuestionsSegue", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateHoleLbl()
        getRoundCount()
        setScoreLabels()
    }
    
    func setScoreLabels() {
        
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(roundCount)").collection("Holes").getDocuments { (snap, error) in
            
            var score: Int = 0
            var totalPar: Int = 0
            
            for document in snap!.documents {
                let docData = document.data()
                
                score += docData["score"] as! Int
                let par = docData["par"] as! String
                if par == "3" {
                    totalPar += 3
                } else if par == "4" {
                    totalPar += 4
                } else {
                    totalPar += 5
                }
            }
            
            let plusMinus = score - totalPar
            if plusMinus > 0 {
                self.plusOrMinusLbl.text = "+\(plusMinus)"
            } else if plusMinus < 0 {
                self.plusOrMinusLbl.text = "\(plusMinus)"
            } else {
                self.plusOrMinusLbl.text = "Even"
            }
            
            self.totalScoreLbl.text = "Score: \(score)"
        }
        
        
        
    }
    
    
    
    func getRoundCount() {
        
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").getDocuments { (snap, error) in
            self.roundCount = (snap?.documents.count)!
            
        }
        
    }
    
    func updateHoleLbl() {
    Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").getDocuments { (querySnapshot, error) in
            
            var roundNumber = querySnapshot!.documents.count
            
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(roundNumber)").collection("Holes").getDocuments { (querySnapshot, error) in
                
                
                var holeNumber = querySnapshot!.documents.count + 1
                
                
                if holeNumber == 19 {
                    holeNumber = 1
                    roundNumber += 1
                }
                self.holeLbl.text = "Hole \(holeNumber)"
            }
        }
    }

    @IBAction func parThreeBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your tee shot on the green?"
        UserDefaults.standard.set("3", forKey: "par")
        
        let randomNumber = arc4random_uniform(6)
        
        if randomNumber == 0 {
            
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
                print("interstitial ready")
            } else {
                performSegue(withIdentifier: "toQuestionsSegue", sender: self)
                print("interstitial not ready")
            }
        } else {
            performSegue(withIdentifier: "toQuestionsSegue", sender: self)
            print("random number not correct")
        }
        
    }
    
    @IBAction func parFourBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your drive in the fairway?"
        UserDefaults.standard.set("4", forKey: "par")
        
        let randomNumber = arc4random_uniform(6)
        
        if randomNumber == 0 {
            
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
                print("interstitial ready")
            } else {
                performSegue(withIdentifier: "toQuestionsSegue", sender: self)
                print("interstitial not ready")
            }
        } else {
            performSegue(withIdentifier: "toQuestionsSegue", sender: self)
            print("random number not correct")
        }
        
        
    }
    
    
    @IBAction func parFiveBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your drive in the fairway?"
        UserDefaults.standard.set("5", forKey: "par")
        
        let randomNumber = arc4random_uniform(6)
        
        if randomNumber == 0 {
            
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
                print("interstitial ready")
            } else {
                performSegue(withIdentifier: "toQuestionsSegue", sender: self)
                print("interstitial not ready")
            }
        } else {
            performSegue(withIdentifier: "toQuestionsSegue", sender: self)
            print("random number not correct")
        }
        
    }
    
    @IBAction func unwindToHoleTypeVC(_ sender: UIStoryboardSegue) {}
    
}
