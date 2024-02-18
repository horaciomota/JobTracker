//
//  addJobView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//
import SwiftUI

// Definindo o tipo ApplicationStatus
enum ApplicationStatus: String, CaseIterable {
    case applied = "Applied"
    case interview = "Interview"
    case rejected = "Rejected"
}

// Função para obter a cor associada a cada status
func color(for status: ApplicationStatus) -> Color {
    switch status {
    case .applied:
        return .yellow
    case .interview:
        return .green
    case .rejected:
        return .red
    }
}

struct AddJobView: View {
    @Binding var companyName: String
    @Binding var jobTitle: String
    @Binding var remoteJob: Bool
    @Binding var applicationStatus: ApplicationStatus?
    @ObservedObject var viewModel: JobTrackerViewModel

    @State private var selectedStatus: ApplicationStatus?

    var body: some View {
        Form {
            Section(header: Text("Detalhes do Trabalho")) {
                TextField("Empresa", text: $companyName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                TextField("Cargo", text: $jobTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Toggle("Trabalho Remoto", isOn: $remoteJob)
            }

            Section(header: Text("Application Status")) {
                Picker("Status", selection: $selectedStatus) {
                    ForEach(ApplicationStatus.allCases, id: \.self) { status in
                        Text(status.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Button(action: {
                print("Tentei fechar")
                viewModel.addJob()
                viewModel.isShowingAddJobView.toggle()
            }) {
                Text("Adicionar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .navigationBarTitle("Adicionar Tarefa", displayMode: .inline)
    }
}




#Preview {
    AddJobView(companyName: .constant(""), jobTitle: .constant(""), remoteJob: .constant(false), applicationStatus: .constant(nil), viewModel: JobTrackerViewModel())
}
