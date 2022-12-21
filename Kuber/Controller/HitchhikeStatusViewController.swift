//
//  HitchhikeStatusViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit

class HitchhikeStatusViewController: UIViewController {

    @IBOutlet weak var searchButton: UIButton!
    private var hitchhikeDatasource = MyHitchesDataSource()

    @IBOutlet weak var hitchListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.imageView?.contentMode = .scaleAspectFit
        hitchhikeDatasource.delegate = self
        //hitchhikeDatasource.getListOfHitches()
        updateTheTableViewDesign()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hitchhikeDatasource.getListOfHitches(areCurrentHitches: true)
    }
    
    func updateTheTableViewDesign() {
        hitchListTableView.separatorStyle = .none
        hitchListTableView.showsVerticalScrollIndicator = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    overhitch func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HitchhikeStatusViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hitchhikeDatasource.getNumberOfHitches()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyHitchCell", for: indexPath) as? HitchListTableViewCell
        else{
            return UITableViewCell()
        }
        
        if let hitch = hitchhikeDatasource.getHitch(for: indexPath.row){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
 
            cell.fromLocationLabel.text = hitch.hitch.ride.fromNeighbourhoodLocation+", "+hitch.hitch.ride.fromLocation
            cell.toLocationLabel.text = hitch.hitch.ride.toNeighbourhoodLocation+", "+hitch.hitch.ride.toLocation
            cell.dateLabel.text = dateFormatter.string(from: hitch.hitch.ride.date)
            let rideTime = hitch.hitch.ride.time
            var calendar = Calendar.current
            let hour = calendar.component(.hour, from: rideTime)
            let minute = calendar.component(.minute, from: rideTime)
            cell.timeLabel.text = "\(hour):\(minute)"
            cell.moneyLabel.text = "\(hitch.hitch.ride.fee) TL"
            cell.majorLabel.text = hitch.riderMajor
            cell.fullNameLabel.text = hitch.riderFullName
            //hitchhikeStatus 0 -> declined 1->approved 2->in request
            if  hitch.hitch.status == 0 {
                cell.statusButton.tintColor=UIColor(red: 153/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1)
                cell.statusButton.setTitle("Declined", for: .normal)
            }
            else if hitch.hitch.status == 1 {
                cell.statusButton.tintColor=UIColor.green
                cell.statusButton.setTitle("Approved", for: .normal)
            }
            else if hitch.hitch.status == 2 {
                cell.statusButton.tintColor=UIColor.orange
                cell.statusButton.setTitle("Pending", for: .normal)

            }
        }else {
            cell.fromLocationLabel.text = "N/A"
            cell.toLocationLabel.text = "N/A"
            cell.dateLabel.text = "N/A"
            cell.timeLabel.text = "N/A"
            cell.fullNameLabel.text = "N/A"
            cell.majorLabel.text = "N/A"
            cell.moneyLabel.text = "N/A"
            cell.statusButton.setTitle("N/A", for: .normal)
        }
        cell.hitchesView.layer.cornerRadius = cell.hitchesView.frame.height / 5
        return cell
    }
    
    
}
extension HitchhikeStatusViewController: MyHitchesDataDelegate{
    func hitchListLoaded() {
        print("Hitch List Loaded")
        self.hitchListTableView.reloadData()
    }
    
    
}
