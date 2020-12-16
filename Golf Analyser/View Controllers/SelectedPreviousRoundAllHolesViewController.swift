//
//  SelectedPreviousRoundAllHolesViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 11/16/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class SelectedPreviousRoundAllHolesViewController: UIViewController, GADBannerViewDelegate {

    var holeCount = 0
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var holeOneBtn: UIButton!
    @IBOutlet weak var holeTwoBtn: UIButton!
    @IBOutlet weak var holeThreeBtn: UIButton!
    @IBOutlet weak var holeFourBtn: UIButton!
    @IBOutlet weak var holeFiveBtn: UIButton!
    @IBOutlet weak var holeSixBtn: UIButton!
    @IBOutlet weak var holeSevenBtn: UIButton!
    @IBOutlet weak var holeEightBtn: UIButton!
    @IBOutlet weak var holeNineBtn: UIButton!
    @IBOutlet weak var holeTenBtn: UIButton!
    @IBOutlet weak var holeElevenBtn: UIButton!
    @IBOutlet weak var holeTwelveBtn: UIButton!
    @IBOutlet weak var holeThirteenBtn: UIButton!
    @IBOutlet weak var holeFourteenBtn: UIButton!
    @IBOutlet weak var holeFifteenBtn: UIButton!
    @IBOutlet weak var holeSixteenBtn: UIButton!
    @IBOutlet weak var holeSeventeenBtn: UIButton!
    @IBOutlet weak var holeEighteenBtn: UIButton!
    var userID = ""
    var scoresArray = [Int]()
    var outletArray:[UIButton ] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-2790005755690511/2578131570"
        bannerView.rootViewController = self
        let bannerRequest = GADRequest()
        bannerView.load(bannerRequest)
        bannerView.delegate = self
        
        userID = Auth.auth().currentUser?.uid ?? ""
        
        outletArray = [holeOneBtn, holeTwoBtn, holeThreeBtn, holeFourBtn, holeFiveBtn, holeSixBtn, holeSevenBtn, holeEightBtn, holeNineBtn, holeTenBtn, holeElevenBtn, holeTwelveBtn, holeThirteenBtn, holeFourteenBtn, holeFifteenBtn, holeSixteenBtn, holeSeventeenBtn, holeEighteenBtn]
        
        fillScoresArray()
        
    }
    
    func showHoleBtns() {
            
        if self.holeCount == 9 {
            for i in 0...8 {
                self.outletArray[i].isHidden = false
                self.outletArray[i].setTitle("Hole \(i+1) : \(self.scoresArray[i])", for: .normal)
            }
            
        } else if self.holeCount == 18 {
            
            for i in 0...17 {
                self.outletArray[i].isHidden = false
                self.outletArray[i].setTitle("Hole \(i+1) : \(self.scoresArray[i])", for: .normal)
            }
        }
    }
    
    func fillScoresArray() {
        
        let roundNumber = UserDefaults.standard.integer(forKey: "previousRoundNumberSelected")
        print(roundNumber)
         Firestore.firestore().collection("Users").document(userID).collection("Rounds").document("\(roundNumber)").collection("Holes").getDocuments { (snap, error) in
            
            self.holeCount = snap?.documents.count ?? 0
            
            for document in snap!.documents {
                let docData = document.data()
                self.scoresArray.append(docData["score"] as! Int)
            }
            
            self.showHoleBtns()
            
        }
        
    }
    
    @IBAction func holeOneTapped(_ sender: Any) {
        
        UserDefaults.standard.set(1, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    
    @IBAction func holeTwoTapped(_ sender: Any) {
        
        UserDefaults.standard.set(2, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    
    @IBAction func holeThreeTapped(_ sender: Any) {
        
        UserDefaults.standard.set(3, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeFourTapped(_ sender: Any) {
        
        UserDefaults.standard.set(4, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeFiveTapped(_ sender: Any) {
        
        UserDefaults.standard.set(5, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeSixTapped(_ sender: Any) {
        
        UserDefaults.standard.set(6, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeSevenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(7, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeEightTapped(_ sender: Any) {
        
        UserDefaults.standard.set(8, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeNineTapped(_ sender: Any) {
        
        UserDefaults.standard.set(9, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeTenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(10, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeElevenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(11, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeTwelveTapped(_ sender: Any) {
        
        UserDefaults.standard.set(12, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeThirteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(13, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holerFourteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(14, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeFifteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(15, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeSixteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(16, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeSeventeenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(17, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }
    @IBAction func holeEighteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(18, forKey: "selectedHole")
        
        performSegue(withIdentifier: "toSelectedHoleSegue", sender: self)
    }

    
    
    @IBAction func unwindToPreviousRoundHoleSelectionVC(_ sender: UIStoryboardSegue) {}

}
