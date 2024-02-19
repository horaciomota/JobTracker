//
//  JobTrackerViewModel.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation

class JobTrackerViewModel: ObservableObject {
    @Published var jobsList: [Job] = []
    @Published var isShowingAddJobView = false

    @Published var companyName = ""
    @Published var jobTitle = "Ios Developer"
    @Published var remoteJob = true
    @Published var applicationDate = Date()
    @Published var applicationStatus: ApplicationStatus = .applied
    @Published var seniorityLevel: SeniorityLevel = .junior


    init(jobs: [Job] = []) {
           self.jobsList = jobs
       }

    var sortedJobsList: [Job] {
         return jobsList.sorted(by: { $0.applicationDate > $1.applicationDate })
     }

    func addJob() {
        if !companyName.isEmpty && !jobTitle.isEmpty {
            jobsList.append(Job(companyName: companyName, jobTitle: jobTitle, remoteJob: remoteJob, applicationDate: applicationDate, applicationStatus: applicationStatus, seniorityLevel: .junior))
            saveTasks()
            companyName = ""
            jobTitle = ""
            applicationStatus = .applied
        }
    }

    func deleteTask(at offsets: IndexSet) {
        jobsList.remove(atOffsets: offsets)
        saveTasks()
    }

    private func saveTasks() {
        // Simulação de salvamento das tarefas, por exemplo, em UserDefaults ou CoreData
        // Aqui você implementaria a lógica para salvar as tarefas de forma persistente
    }
}

