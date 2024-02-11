//
//  Job.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation

// Struct needs to be codable because i need to parse data to default
struct Job: Codable {
    var companyName: String
    var city: String
    var isRemote: Bool
    var applicationDate: Date
}
