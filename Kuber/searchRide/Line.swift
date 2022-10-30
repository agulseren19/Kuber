//
//  Line.swift
//  Kuber
//
//  Created by Begum Sen on 30.10.2022.
//

import UIKit

class Line: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func drawLine (){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 10, y: 500 ))
        path.addLine(to: CGPoint(x: self.view.bounds.width/2-20, y: 500))
        path.stroke()
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: self.view.bounds.width/2+40, y: 500 ))
        path2.addLine(to: CGPoint(x: self.view.bounds.width-10, y: 500))
        path2.stroke()
    }
    

}
