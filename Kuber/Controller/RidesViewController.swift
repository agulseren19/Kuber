//
//  RidesViewController.swift
//  Kuber
//
//  Created by Arda Aliz on 1.12.2022.
//

import UIKit

class RidesViewController: UIViewController {
    
    var from: String = ""
    var fromNeighbourhood: String = ""
    var to: String = ""
    var toNeighbourhood: String = ""
    var date: Date = Date()
    var time: Date = Date()
    var all: Bool = false
    private var ridesDatasource = RidesDataSource()
    private let ridesAfterSearchHelper = RidesAfterSearchHelper()
    @IBOutlet weak var ridesAfterSearchTableView: UITableView!
    
    @IBOutlet weak var warningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ridesDatasource.delegate = self
        ridesAfterSearchHelper.delegate = self
        if(all){
                ridesDatasource.getListOfRidesWithShowAll()
        } else {
            ridesDatasource.getListOfRidesWithoutShowAll(to: to, toNeighbourhood: toNeighbourhood, date: date , time: time )
            }
        print("RİDES VİEW CONTROLLER")
        print(to)
        
        updateTheTableViewDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        warningLabel.isHidden = true
    }
    
    
    func updateTheTableViewDesign() {
        ridesAfterSearchTableView.separatorStyle = .none
        ridesAfterSearchTableView.showsVerticalScrollIndicator = false
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

extension RidesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("view controller rides count \(ridesDatasource.getNumberOfRides())")
        return ridesDatasource.getNumberOfRides()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "rideAfterSearchCell", for: indexPath) as? RidesAfterSearchTableViewCell
        else{
            return UITableViewCell()
        }
        
        if var ride = ridesDatasource.getRide(for: indexPath.row){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            if(ride.ride.hitched) {
                print("Ride Exist \(indexPath.row)")
                cell.sendHitchButton.setTitle("Sent", for: .normal)
                cell.sendHitchButton.setTitleColor(.darkGray, for: .normal)
                cell.sendHitchButton.isEnabled = false
            }else{
                cell.sendHitchButton.isEnabled = true
                cell.sendHitchButton.setTitle("Send Hitch!", for: .normal)
                cell.sendHitchButton.setTitleColor(UIColor(red: 153/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1), for: .normal)
            }
            cell.fromLocationLabel.text = ride.ride.fromNeighbourhoodLocation+", "+ride.ride.fromLocation
            cell.toLocationLabel.text = ride.ride.toNeighbourhoodLocation+", "+ride.ride.toLocation
            cell.dateLabel.text = dateFormatter.string(from: ride.ride.date)
            let rideTime = ride.ride.time
            cell.timeLabel.text = timeFormatter.string(from: rideTime)
            cell.fullNameLabel.text = ride.riderFullName
            cell.majorLabel.text = ride.riderMajor
            cell.moneyLabel.text = "\(ride.ride.fee)"
            cell.hitchARideBtn = {[unowned self] in
                let alert = UIAlertController(title: "Hitch request sended! ", message: "Hitched!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                cell.sendHitchButton.setTitle("Sent", for: .normal)
                cell.sendHitchButton.setTitleColor(.darkGray, for: .normal)
                cell.sendHitchButton.isEnabled = false
                ridesAfterSearchHelper.saveHitchToDatabase(ride: ride.ride)
                
                ridesAfterSearchHelper.sendNotificationWithFirebase(ride: ride.ride)
                
            }
        }else {
            cell.fromLocationLabel.text = "N/A"
            cell.toLocationLabel.text = "N/A"
            cell.dateLabel.text = "N/A"
            cell.timeLabel.text = "N/A"
            cell.fullNameLabel.text = "N/A"
            cell.majorLabel.text = "N/A"
            cell.moneyLabel.text = "N/A"
        }
        cell.ridesAfterSearchView.layer.cornerRadius = cell.ridesAfterSearchView.frame.height / 5
        
        
        
        return cell
    }
   
        

    
}

extension RidesViewController: RidesDataDelegate{
    func noDataInRides() {
        warningLabel.isHidden = false
    }
    
    func ridesListLoaded() {
        print("Rides List Loaded")
        self.ridesAfterSearchTableView.reloadData()
    }
    
    
}

extension RidesViewController: RidesAfterSearchDelegate {
    func hitchIsSavedToFirebase() {
        
        print("Hitch Request Is Saved")
    }
}
