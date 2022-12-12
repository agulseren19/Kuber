//
//  RideRequestsViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit

class RideRequestsViewController: UIViewController {
    
    @IBOutlet weak var rideRequestTableView: UITableView!
    private var rideRequestDatasource = RideRequestDataSource()
    var ride: Ride?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Hitch Requests"
        updateTheTableViewDesign()
        rideRequestDatasource.delegate = self
        if let ride = ride {
            rideRequestDatasource.getListOfRideRequest(ride: ride)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func updateTheTableViewDesign() {
        rideRequestTableView.separatorStyle = .none
        rideRequestTableView.showsVerticalScrollIndicator = false
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

extension RideRequestsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rideRequestDatasource.getNumberOfRideRequest()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RideRequestCell") as? RideRequestTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if let ride = rideRequestDatasource.getRideRequest(for: indexPath.row) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY/MM/dd"
            cell.nameLabel.text = ride.hitchhikerName
            cell.majorLabel.text = ride.hitchhikerMajor
            cell.gradeLevelLabel.text = ride.hitchhikerGradeLevel
        } else {
            cell.nameLabel.text = "N/A"
            cell.majorLabel.text = "N/A"
            cell.gradeLevelLabel.text = "N/A"
        }
        cell.rideRequestView.layer.cornerRadius = cell.rideRequestView.frame.height / 5
        return cell
    }
}

extension RideRequestsViewController: RideRequestDataDelegate {
    func  rideRequestListLoaded(){
        self.rideRequestTableView.reloadData()
    }
}
