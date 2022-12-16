//
//  Ride.swift
//  Kuber
//
//  Created by Begum Sen on 24.11.2022.
//

import Foundation

struct Ride: Hashable {
    let rideId: String
    let fromLocation: String
    let fromNeighbourhoodLocation: String
    let toLocation: String
    let toNeighbourhoodLocation: String 
    let date: Date
    let time: Date
    let seatAvailable: Int
    let fee: Int
    let mail: String
    var hitched: Bool
}
