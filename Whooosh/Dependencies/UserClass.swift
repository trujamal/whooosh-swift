//
//  UserClass.swift
//  Whooosh
//
//  Created by Jamal Rasool on 2/22/19.
//  Copyright © 2019 Jamal Rasool. All rights reserved.
//
import Foundation
import UIKit

class UserClass: NSObject {
    var first_name: String?
    var last_name: String?
    var phone: Int?
    var email: String?
    var location: Int?
}

class Jobs: NSObject {
    var jobTitle: String?
    var jobDescription: Int?
    var jobApplyLink: String?
    var location: [Float]?
}

class Trip: NSObject  {
    var startingTime: Int?
    var endingTime: Int?
    var desiredStart: Int?
    var desiredEnd: Int?
    var startingAddress: String?
    var endingAddress: String?
    var calanderDate: String?
}

class RideSharing: NSObject {
    var lyftPrice: Double?
    var uberPrice: Double?
    var averageEconomy: Double?
}

class HousingManagement: NSObject {
    var housingPrice: Double?
    var housingBedRooms: Int?
    var housingBathrooms: Int?
    var neighborhoodQuality: Int?
    var address: String?
    var location: [String]?
}


class Users: NSObject {
    var name: String?
    var phone: Int?
    var email: String?
    var location: Int?
    var join_date: String?
    var verified: Bool?
}
