//
//  addJobView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//
import SwiftUI

struct AddJobView: View {
    @Binding var companyName: String
    @Binding var jobTitle: String
    @Binding var remoteJob: Bool
    @Binding var applicationStatus: ApplicationStatus
    @ObservedObject var viewModel: JobTrackerViewModel

    var body: some View {
        Form {
            Section(header: Text("Job Details")) {
                TextField("Company Name", text: $companyName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Picker("Seniority", selection: $applicationStatus) {
                    ForEach(ApplicationStatus.allCases, id: \.self) { level in
                        Text(level.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Job Title", text: $jobTitle)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Toggle("Remote Job", isOn: $remoteJob)
                    .padding(.vertical)
            }

            Button(action: {
                viewModel.addJob()
                viewModel.isShowingAddJobView.toggle()
            }) {
                Text("Add Application")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .navigationBarTitle("Add Job", displayMode: .inline)
    }
}

struct AddJobView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = JobTrackerViewModel()
        AddJobView(companyName: .constant("Company Name"), jobTitle: .constant("Job Title"), remoteJob: .constant(false), applicationStatus: .constant(.applied), viewModel: viewModel)
    }
}



