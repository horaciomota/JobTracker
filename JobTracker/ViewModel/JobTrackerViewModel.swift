//
//  JobTrackerViewModel.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation

class JobTrackerViewModel: ObservableObject {
    @Published var jobs: [Job] = [] {
           didSet {
               saveJobs()
           }
       }

       init() {
           loadJobs()
       }

       private let jobsKey = "savedJobs"

       private func saveJobs() {
           do {
               let data = try JSONEncoder().encode(jobs)
               UserDefaults.standard.set(data, forKey: jobsKey)
           } catch {
               print("Error encoding jobs: \(error)")
           }
       }

       private func loadJobs() {
           if let data = UserDefaults.standard.data(forKey: jobsKey) {
               do {
                   jobs = try JSONDecoder().decode([Job].self, from: data)
               } catch {
                   print("Error decoding jobs: \(error)")
               }
           }
       }

    func addJob(_ job: Job) {
        //Putting the new element in first place
        jobs.insert(job, at: 0)
        //Putting the new element in last place
        //jobs.append(job)
        print(jobs.count)
    }

    // Swipe to delete function
    func deleteJobs(at offsets: IndexSet) {
        jobs.remove(atOffsets: offsets)
    }

}
