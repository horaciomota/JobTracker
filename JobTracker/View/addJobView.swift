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
    @Binding var applicationDate: Date
    @Binding var applicationStatus: ApplicationStatus
    @Binding var seniorityLevel: SeniorityLevel
    @ObservedObject var viewModel: JobTrackerViewModel

    var body: some View {
        VStack {
            Picker("Application status", selection: $applicationStatus) {
                ForEach(ApplicationStatus.allCases, id: \.self) { level in
                    Text(level.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            TextField("Company Name", text: $companyName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

            HStack {
                TextField("Job Title", text: $jobTitle)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                Picker("Junior", selection: $seniorityLevel) {
                    ForEach(SeniorityLevel.allCases, id: \.self) { level in
                        Text(level.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }


            DatePicker("Application Date", selection: $applicationDate, displayedComponents: .date)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)

                .pickerStyle(MenuPickerStyle())
                         Toggle("Remote Job", isOn: $remoteJob)

            Button(action: {
                viewModel.addJob()
                viewModel.isShowingAddJobView.toggle()
            }) {
                Text("Add Application")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 40)
    }
}

struct AddJobView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = JobTrackerViewModel()
        AddJobView(companyName: .constant("Company Name"), jobTitle: .constant("Job Title"), remoteJob: .constant(false), applicationDate: .constant(Date()), applicationStatus: .constant(.applied), seniorityLevel: .constant(.junior), viewModel: viewModel)
    }
}




