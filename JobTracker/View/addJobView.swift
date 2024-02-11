//
//  addJobView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import SwiftUI

struct addJobView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: JobTrackerViewModel

    @State private var companyName = ""
    @State private var city = ""
    @State private var isRemote = false
    @State private var applicationDate = Date()

    var body: some View {
        NavigationView {
            Form {
                TextField("Company Name", text: $companyName)
                TextField("City", text: $city)
                Toggle("Remote", isOn: $isRemote)
                DatePicker("Application Date", selection: $applicationDate, displayedComponents: .date)
            }
            .navigationTitle("Add Job")
            .navigationBarItems(trailing: Button("Save", action: saveJob))
        }
    }

    private func saveJob() {
        let newJob = Job(companyName: companyName, city: city, isRemote: isRemote, applicationDate: applicationDate)
        viewModel.addJob(newJob)
        presentationMode.wrappedValue.dismiss()
    }
}


#Preview {
    addJobView(viewModel: JobTrackerViewModel())
}
