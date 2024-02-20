//
//  JobTrackerView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import SwiftUI

struct JobTrackerView: View {
    @StateObject private var viewModel = JobTrackerViewModel()

    init(viewModel: JobTrackerViewModel = JobTrackerViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.jobsList.isEmpty {
                    ContentUnavailable()
                } else {

                    // Lista
                    List {

                    }
                    .scrollIndicators(.hidden)
                    .listStyle(PlainListStyle())


                }

                Spacer()

                ZStack {
                    Button(action: {
                        viewModel.isShowingAddJobView.toggle()

                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(50)
                }
                }
            }
            .padding()
            .navigationTitle("\(viewModel.jobsList.count) Applications")
            .sheet(isPresented: $viewModel.isShowingAddJobView) {
                AddJobView(companyName: $viewModel.companyName, jobTitle: $viewModel.jobTitle, remoteJob: $viewModel.remoteJob, applicationDate: $viewModel.applicationDate, applicationStatus: $viewModel.applicationStatus, seniorityLevel: $viewModel.seniorityLevel, viewModel: viewModel)
                      .presentationDetents([.fraction(0.5), .large])
                      .presentationDragIndicator(.visible)
            }
        }
    }
}




#Preview {
        let viewModel = JobTrackerViewModel()
        viewModel.jobsList = [
            Job(companyName: "Company A", jobTitle: "Job A", remoteJob: true, applicationDate: Date(), applicationStatus: .applied, seniorityLevel: .junior),
            Job(companyName: "Company B", jobTitle: "Job B", remoteJob: false, applicationDate: Date(), applicationStatus: .interviewed, seniorityLevel: .junior),
            Job(companyName: "Company C", jobTitle: "Job C", remoteJob: true, applicationDate: Date(), applicationStatus: .hired, seniorityLevel: .junior),
            Job(companyName: "Company D", jobTitle: "Job D", remoteJob: false, applicationDate: Date(), applicationStatus: .rejected, seniorityLevel: .junior),
            Job(companyName: "Company D", jobTitle: "Job D", remoteJob: false, applicationDate: Date(), applicationStatus: .hired, seniorityLevel: .junior),
            Job(companyName: "Company D", jobTitle: "Job D", remoteJob: false, applicationDate: Date(), applicationStatus: .rejected, seniorityLevel: .junior)
        ]

        return JobTrackerView(viewModel: viewModel)
    }


struct ContentUnavailable: View {
    var body: some View {
        ContentUnavailableView {
            Label("No applications yet", systemImage: "pencil.and.list.clipboard")
        } description: {
            Text("New applications you receive will appear here.")
        }
        .foregroundColor(.gray)
    }
}

extension JobTrackerViewModel {
    func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }

    func formattedDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
}

