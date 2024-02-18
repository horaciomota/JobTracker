//
//  Job.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation

enum ExperienceLevel: String, CaseIterable {
    case junior = "Junior"
    case mid = "Mid"
    case senior = "Senior"
}

struct Job: Identifiable {
    let id = UUID()
    var companyName: String
    var jobTitle: String
    var remoteJob: Bool
    var applicationDate: Date
    var experienceLevel: ExperienceLevel // Adicionando a propriedade de nível de experiência
}
