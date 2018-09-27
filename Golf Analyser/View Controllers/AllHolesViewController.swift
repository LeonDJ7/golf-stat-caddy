//
//  AllHolesViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

class AllHolesViewController: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var confirmRoundBtn: UIButton!
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
    var holeNumber: Int!
    var roundNumber: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmRoundBtn.layer.cornerRadius = 5

        let outletArray:[UIButton ] = [holeOneBtn, holeTwoBtn, holeThreeBtn, holeFourBtn, holeFiveBtn, holeSixBtn, holeSevenBtn, holeEightBtn, holeNineBtn, holeTenBtn, holeElevenBtn, holeTwelveBtn, holeThirteenBtn, holeFourteenBtn, holeFifteenBtn, holeSixteenBtn, holeSeventeenBtn, holeEighteenBtn]
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").getDocuments { (querySnapshot, error) in
            
            self.roundNumber = querySnapshot!.documents.count
            Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(self.roundNumber!)").collection("Holes").getDocuments { (querySnapshot, error) in
                
                self.holeNumber = querySnapshot!.documents.count
                
                if self.holeNumber == 18 || (self.holeNumber == 9 && isOkToConfirm == true) {
                    self.confirmRoundBtn.isHidden = false
                    self.backBtn.isHidden = true
                }
                
                
                if self.holeNumber == 0 {
                    outletArray[0].isHidden = true
                } else {
                    for index in 0...self.holeNumber - 1 {
                        outletArray[index].isHidden = false
                    }
                }
            }
            
        }
        
    }
    
    @IBAction func holeOneTapped(_ sender: Any) {
        
        UserDefaults.standard.set(1, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeTwoTapped(_ sender: Any) {
        
        UserDefaults.standard.set(2, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeThreeTapped(_ sender: Any) {
        
        UserDefaults.standard.set(3, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeFourTapped(_ sender: Any) {
        
        UserDefaults.standard.set(4, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeFiveTapped(_ sender: Any) {
        
        UserDefaults.standard.set(5, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeSixTapped(_ sender: Any) {
        
        UserDefaults.standard.set(6, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeSevenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(7, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeEightTapped(_ sender: Any) {
        
        UserDefaults.standard.set(8, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeNineTapped(_ sender: Any) {
        
        UserDefaults.standard.set(9, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeTenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(10, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeElevenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(11, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeTwelveTapped(_ sender: Any) {
        
        UserDefaults.standard.set(12, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeThirteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(13, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holerFourteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(14, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeFifteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(15, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeSixteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(16, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeSeventeenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(17, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    @IBAction func holeEighteenTapped(_ sender: Any) {
        
        UserDefaults.standard.set(18, forKey: "specificHole")
        
        performSegue(withIdentifier: "toSpecificHoleSegue", sender: self)
    }
    
    @IBAction func confirmRound(_ sender: Any) {
        
        // get number of rounds
        
            
        // set doesCount to true when round is complete
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(roundNumber!)").setData(["doesCount" : true])
        
        // set next round to not count
        Firestore.firestore().collection("Users").document(Auth.auth().currentUser!.uid).collection("Rounds").document("\(roundNumber! + 1)").setData(["doesCount" : false])
            
        
        isOkToConfirm = false
        
    }
    
    @IBAction func unwindToFullList(_ sender: UIStoryboardSegue) {}
    
}
