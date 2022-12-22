//
//  HistoryOfRidesViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 14.12.2022.
//

import UIKit

class HistoryOfRidesViewController: UIViewController {

    @IBOutlet weak var historyOfRidesTableView: UITableView!
    
    private var myRidesDatasource = MyRidesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        myRidesDatasource.delegate = self
        updateTheTableViewDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myRidesDatasource.getListOfMyPreviousRides()
    }
    
    func updateTheTableViewDesign() {
        historyOfRidesTableView.separatorStyle = .none
        historyOfRidesTableView.showsVerticalScrollIndicator = false
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

extension HistoryOfRidesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRidesDatasource.getNumberOfmyRides()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryOfRidesCell") as? HistoryOfRidesTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if let ride = myRidesDatasource.getMyRide(for: indexPath.row) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            cell.fromLocationLabel.text = ride.fromNeighbourhoodLocation+", "+ride.fromLocation
            cell.toLocationLabel.text = ride.toNeighbourhoodLocation+", "+ride.toLocation
            cell.availableSeatLabel.text = "\(ride.seatAvailable)"
            cell.dateLabel.text = dateFormatter.string(from: ride.date)
            cell.feeLabel.text = "\(ride.fee)"
            let rideTime = ride.time
            cell.timeLabel.text = timeFormatter.string(from: rideTime)
        } else {
            cell.fromLocationLabel.text = "N/A"
            cell.toLocationLabel.text = "N/A"
            cell.availableSeatLabel.text = "N/A"
            cell.dateLabel.text = "N/A"
            cell.feeLabel.text = "N/A"
        }
        cell.historyRideView.layer.cornerRadius = cell.historyRideView.frame.height / 5
        
        return cell
    }
}

extension HistoryOfRidesViewController: MyRidesDataDelegate {
    func noDataInMyRides() {
        
    }
    func myRidesListLoaded(){
        self.historyOfRidesTableView.reloadData()
    }
}
