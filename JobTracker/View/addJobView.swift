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
    @State private var position = ""
    @State private var country = ""
    @State private var isRemote = false
    @State private var applicationDate = Date()
    @State private var selectedSeniorityIndex = 0

    // Adicione um valor padrão para o status
    @State private var selectedStatusIndex = 0
    let applicationStatuses = ["Applied", "Interviewing", "Rejected", "Offer Received", "Hired"]
    let seniorityOptions = ["Inter", "Junior", "Mid", "Senior"]


    let statusIcons: [String: String] = [
            "Applied": "envelope",
            "Interviewing": "mic",
            "Rejected": "hand.thumbsdown",
            "Offer Received": "hand.thumbsup",
            "Hired": "checkmark"
        ]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Info")) {

                    TextField("Company Name", text: $companyName)
                    TextField("Positiom", text: $position)
                    TextField("Country", text: $country)
                    Picker("Seniority", selection: $selectedSeniorityIndex) {
                                       ForEach(seniorityOptions.indices, id: \.self) { index in
                                           Text(seniorityOptions[index])
                                       }
                                   }
                    Toggle("Remote", isOn: $isRemote)
                    DatePicker("Application Date", selection: $applicationDate, displayedComponents: .date)
                }

                Section(header: Text("Status")) {
                Picker("Status", selection: $selectedStatusIndex) {
                                   ForEach(applicationStatuses.indices, id: \.self) { index in
                                       HStack {
                                           Image(systemName: statusIcons[applicationStatuses[index]] ?? "")
                                           Text(applicationStatuses[index])
                                       }
                                       .tag(index)
                                   }
                               }
                               .pickerStyle(WheelPickerStyle())
                               .clipped()
                }

            }
            .navigationTitle("Add application")
            .navigationBarItems(trailing: Button("Save", action: saveJob))
        }
    }

    private func saveJob() {
         // Passe o status para o inicializador de Job
        let newJob = Job(companyName: companyName, position: position, country: country, isRemote: isRemote, applicationDate: applicationDate, status: applicationStatuses[selectedStatusIndex], seniority: seniorityOptions[selectedSeniorityIndex])
         viewModel.addJob(newJob)
         presentationMode.wrappedValue.dismiss()
     }
 }


#Preview {
    addJobView(viewModel: JobTrackerViewModel())
}
