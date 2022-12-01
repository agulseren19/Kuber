//
//  RidesViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 3.11.2022.
//

import UIKit

class RidesViewController: UIViewController {
    
    private var ridesDatasource = RidesDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ridesDatasource.delegate = self
        ridesDatasource.getListOfRidesWithShowAll()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RidesViewController: RidesDataDelegate{
    func ridesListLoaded() {
        print("Rides List Loaded")
    }
    
    
}
