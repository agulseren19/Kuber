//
//  myRidesViewController.swift
//  Kuber
//
//  Created by Begum Sen on 24.11.2022.
//

import UIKit

class MyRidesViewController: UIViewController {

   
    @IBOutlet weak var myRidesTableView: UITableView!
    
    
    @IBOutlet weak var addButton: UIButton!
    private var myRidesDatasource = MyRidesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.imageView?.contentMode = .scaleAspectFit
        myRidesDatasource.delegate = self
        myRidesDatasource.getListOfMyRides()
        updateTheTableViewDesign()
        // Do any additional setup after loading the view.
    }
    
    func updateTheTableViewDesign() {
        myRidesTableView.separatorStyle = .none
        myRidesTableView.showsVerticalScrollIndicator = false
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

extension MyRidesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myRidesDatasource.getNumberOfmyRides()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyRideCell") as? RideListTableViewCell
        else  {
            return UITableViewCell()
        }
        
        if let ride = myRidesDatasource.getMyRide(for: indexPath.row) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY/MM/dd"
            cell.fromLocationLabel.text = ride.fromLocation
            cell.toLocationLabel.text = ride.toLocation
            cell.availableSeatLabel.text = "\(ride.seatAvailable)"
            cell.dateLabel.text = dateFormatter.string(from: ride.date)
            cell.feeLabel.text = ride.fee
        } else {
            cell.fromLocationLabel.text = "N/A"
            cell.toLocationLabel.text = "N/A"
            cell.availableSeatLabel.text = "N/A"
            cell.dateLabel.text = "N/A"
            cell.feeLabel.text = "N/A"
        }
        cell.myRideView.layer.cornerRadius = cell.myRideView.frame.height / 5
        
        return cell
    }
}



extension MyRidesViewController: MyRidesDataDelegate {
    func myRidesListLoaded(){
        self.myRidesTableView.reloadData()
    }
}
