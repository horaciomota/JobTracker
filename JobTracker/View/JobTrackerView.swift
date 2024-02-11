//
//  JobTrackerView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import SwiftUI

struct JobTrackerView: View {
    @StateObject var viewModel = JobTrackerViewModel()
    @State private var isAddJobPresented = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.jobs.indices, id: \.self) { index in
                    JobCellView(job: viewModel.jobs[index])
                }
            }
            .navigationTitle("Job Tracker")
            .navigationBarItems(trailing: Button(action: {
                isAddJobPresented.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $isAddJobPresented) {
                addJobView(viewModel: viewModel)
            }
        }
    }
}

struct JobCellView: View {
    var job: Job

    var body: some View {
        VStack(alignment: .leading) {
            Text(job.companyName)
                .font(.headline)
            Text("City: \(job.city)")
            Text("Remote: \(job.isRemote ? "Yes" : "No")")
            Text("Application Date: \(job.applicationDate, formatter: dateFormatter)")
        }
        .padding()
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}


#Preview {
    JobTrackerView()
}
