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

    var daysSinceApplication: Int { // Computed property para calcular o número de dias desde a aplicação
            let calendar = Calendar.current
            let currentDate = Date()
            let days = calendar.dateComponents([.day], from: applicationDate, to: currentDate).day ?? 0
            return max(days, 0)
        }
}
