//
//  JobTrackerViewModel.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation

class JobTrackerViewModel: ObservableObject {
    @Published var jobs: [Job] = []

    func addJob(_ job: Job) {
        jobs.append(job)
        print(jobs.count)
    }

    // Swipe to delete function
    func deleteJobs(at offsets: IndexSet) {
        jobs.remove(atOffsets: offsets)
    }

}
