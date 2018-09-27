//
//  HoleTypeSelectionViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 8/29/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase

var loadedQuestion = String()

class HoleTypeSelectionViewController: UIViewController {

    @IBOutlet weak var par5Btn: UIButton!
    @IBOutlet weak var par4Btn: UIButton!
    @IBOutlet weak var par3Btn: UIButton!
    @IBOutlet weak var returnToHomescreenBtn: UIButton!
    @IBOutlet weak var fullListOfHolesBtn: UIButton!
    @IBOutlet weak var holeLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        par3Btn.layer.cornerRadius = 5
        par4Btn.layer.cornerRadius = 5
        par5Btn.layer.cornerRadius = 5
        returnToHomescreenBtn.layer.cornerRadius = 5
        fullListOfHolesBtn.layer.cornerRadius = 5
        updateHoleLbl()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateHoleLbl()
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
        
        performSegue(withIdentifier: "toQuestionsSegue", sender: self)
        
    }
    
    @IBAction func parFourBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your drive in the fairway?"
        UserDefaults.standard.set("4", forKey: "par")
        
        performSegue(withIdentifier: "toQuestionsSegue", sender: self)
    }
    @IBAction func parFiveBtnTapped(_ sender: Any) {
        
        loadedQuestion = "Was your drive in the fairway?"
        UserDefaults.standard.set("5", forKey: "par")
        
        performSegue(withIdentifier: "toQuestionsSegue", sender: self)
        
    }
    
    @IBAction func unwindToHoleTypeVC(_ sender: UIStoryboardSegue) {}
    
}
