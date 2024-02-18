//
//  Job.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation

struct Job: Identifiable {
    let id = UUID()
    var companyName: String
    var jobTitle: String
    var remoteJob: Bool
    var applicationDate: Date
}
