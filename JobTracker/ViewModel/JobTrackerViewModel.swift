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
    @Published var remoteJob = false
    @Published var applicationDate = Date()
    @Published var applicationStatus: ApplicationStatus = .applied

    init(jobs: [Job] = []) {
           self.jobsList = jobs
       }

    func addJob() {
        if !companyName.isEmpty && !jobTitle.isEmpty {
            jobsList.append(Job(companyName: companyName, jobTitle: jobTitle, remoteJob: remoteJob, applicationDate: applicationDate, applicationStatus: applicationStatus))
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

