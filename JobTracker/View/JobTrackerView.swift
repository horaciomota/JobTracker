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
                Text("Número de trabalhos: \(viewModel.jobs.count)")
                ForEach(viewModel.jobs.indices, id: \.self) { index in
                    JobCellView(job: viewModel.jobs[index])
                }
                .onDelete(perform: viewModel.deleteJobs(at:))
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
//            VStack{
//                Text("\(job.daysSinceApplication) days ago")
//            }
            HStack {
                Text(job.position)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text(job.status)
                    .font(.subheadline)
            }
            HStack {
                Text("\(job.companyName) > \(job.seniority)")
                    .font(.subheadline)
//                Text(job.isRemote ? "Remote" : "In-site")
//                    .foregroundColor(Color.gray)
            }
//            Text("Application Date: \(job.applicationDate, formatter: dateFormatter)")
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
