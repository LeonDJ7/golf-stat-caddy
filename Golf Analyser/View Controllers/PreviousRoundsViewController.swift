//
//  PreviousRoundsViewController.swift
//  Golf Analyser
//
//  Created by Leon Djusberg on 11/16/18.
//  Copyright © 2018 Leon Djusberg. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

class PreviousRoundsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {
    

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var tableView: UITableView!
    var roundCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView.adUnitID = "ca-app-pub-2790005755690511/1424832008"
        bannerView.rootViewController = self
        let bannerRequest = GADRequest()
        bannerView.load(bannerRequest)
        bannerView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadPreviousNumberOfRounds()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(roundCount)
        return roundCount
    }
    
    func loadPreviousNumberOfRounds() {
        
        let userID = Auth.auth().currentUser?.uid
        
        Firestore.firestore().collection("Users").document(userID ?? "").collection("Rounds").getDocuments { (snap, error) in
            
            self.roundCount = snap?.documents.count ?? 0
            self.roundCount -= 1
            
            self.tableView.reloadData()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "previousRoundCell", for: indexPath) as! PreviousRoundsTableViewCell
        
        let userID = Auth.auth().currentUser?.uid
        var score = 0
        var totalPar = 0
        
        Firestore.firestore().collection("Users").document(userID ?? "").collection("Rounds").document("\(indexPath.row+1)").collection("Holes").getDocuments { (snap, error) in
            
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
            
            
            cell.roundLabel.text = "Round \(indexPath.row + 1)"
            cell.scoreLbl.text = "\(score)"
            cell.parLbl.text = "\(totalPar)"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row + 1
        
        UserDefaults.standard.set(row, forKey: "previousRoundNumberSelected")
        
        performSegue(withIdentifier: "toAllHolesPreviousRound", sender: self)
    }
    
    @IBAction func unwindToPreviousRoundSelector(_ sender: UIStoryboardSegue) {}

}
