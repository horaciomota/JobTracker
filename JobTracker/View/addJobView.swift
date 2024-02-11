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
    @State private var country = ""
    @State private var isRemote = false
    @State private var applicationDate = Date()

    // Adicione um valor padrão para o status
    let status = "Em andamento"

    @State private var selectedStatusIndex = 0
    let applicationStatuses = ["Em andamento", "Aceito", "Recusado", "Entrevista agendada", "Outro"]


    var body: some View {
        NavigationView {
            Form {
                TextField("Company Name", text: $companyName)
                TextField("City", text: $city)
                TextField("Country", text: $country)
                Toggle("Remote", isOn: $isRemote)
                DatePicker("Application Date", selection: $applicationDate, displayedComponents: .date)

                Picker("Status", selection: $selectedStatusIndex) {
                    ForEach(0..<applicationStatuses.count) { index in
                        Text(applicationStatuses[index]).tag(index)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 200)
                .clipped()
            }
            .navigationTitle("Add Job")
            .navigationBarItems(trailing: Button("Save", action: saveJob))
        }
    }

    private func saveJob() {
         // Passe o status para o inicializador de Job
         let newJob = Job(companyName: companyName, city: city, country: country, isRemote: isRemote, applicationDate: applicationDate, status: status)
         viewModel.addJob(newJob)
         presentationMode.wrappedValue.dismiss()
     }
 }


#Preview {
    addJobView(viewModel: JobTrackerViewModel())
}
