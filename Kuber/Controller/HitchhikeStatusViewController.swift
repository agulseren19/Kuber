//
//  HitchhikeStatusViewController.swift
//  Kuber
//
//  Created by Aslıhan Gülseren on 3.11.2022.
//

import UIKit

class HitchhikeStatusViewController: UIViewController {
    
    @IBOutlet weak var warningLabel: UILabel!
    
    @IBOutlet weak var searchButton: UIButton!
    private var hitchhikeDatasource = MyHitchesDataSource()
    
    @IBOutlet weak var hitchListTableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.imageView?.contentMode = .scaleAspectFit
        hitchhikeDatasource.delegate = self
        //hitchhikeDatasource.getListOfHitches()
        updateTheTableViewDesign()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.isHidden = false
        warningLabel.isHidden = true
        hitchListTableView.isHidden = true
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
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            cell.fromLocationLabel.text = hitch.hitch.ride.fromNeighbourhoodLocation+", "+hitch.hitch.ride.fromLocation
            cell.toLocationLabel.text = hitch.hitch.ride.toNeighbourhoodLocation+", "+hitch.hitch.ride.toLocation
            cell.dateLabel.text = dateFormatter.string(from: hitch.hitch.ride.date)
            let rideTime = hitch.hitch.ride.time
            cell.timeLabel.text = timeFormatter.string(from: rideTime)
            cell.moneyLabel.text = "\(hitch.hitch.ride.fee) TL"
            cell.majorLabel.text = hitch.riderMajor
            cell.fullNameLabel.text = hitch.riderFullName
            
            cell.profilePictureImageView.image = UIImage(data: hitch.riderProfileImageData)
            cell.profilePictureImageView.layer.borderWidth = 1.0
            cell.profilePictureImageView.layer.masksToBounds = false
            cell.profilePictureImageView.layer.borderColor = UIColor.white.cgColor
            cell.profilePictureImageView.layer.cornerRadius = cell.profilePictureImageView.frame.height / 2
            cell.profilePictureImageView.clipsToBounds = true
            
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
    func noDataInMyHitches() {
        warningLabel.isHidden = false
        activityIndicatorView.isHidden = true
    }
    
    func hitchListLoaded() {
        
        self.hitchListTableView.reloadData()
        hitchListTableView.isHidden = false
        activityIndicatorView.isHidden = true
    }
}
