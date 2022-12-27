//
//  searchRideUIView.swift
//  Kuber
//
//  Created by Begum Sen on 30.10.2022.
//

import UIKit

class searchRideUIView: UIView {

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func draw(_ rect: CGRect){
        //Define the red Color of Koc University
        let myLabel = viewWithTag(001)
        let yLocationLabel = myLabel?.bounds.minY
        var yLocationLine: Int = 0
        if let yLoc = yLocationLabel {
            
            yLocationLine = Int(yLoc) + 30
        }
        let redColor = UIColor(red: (186/255.0), green: (17/255.0), blue: (17/255.0), alpha: 1.0)
        // draw the lines in the screen
        redColor.setStroke()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: 500 ))
        path.addLine(to: CGPoint(x: bounds.width/2-35, y: 500))
        path.stroke()
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: bounds.width/2+35, y: 500 ))
        path2.addLine(to: CGPoint(x: bounds.width-20, y: 500))
        path2.stroke()
        // add the OR label
        let label = UILabel(frame: CGRect(x: bounds.width/2-20, y: 480, width: 40, height: 40))
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = redColor
        label.text = "OR"
        addSubview(label)
    }
}
