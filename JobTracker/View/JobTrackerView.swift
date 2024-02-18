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
                        ForEach(viewModel.jobsList.indices, id: \.self) { index in
                                    VStack(alignment: .leading, spacing: 10) {
                                        // Conteúdo do cartão
                                        Text(viewModel.jobsList[index].companyName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(viewModel.jobsList[index].jobTitle)
                                            .font(.subheadline)
                                            .foregroundColor(.white)

                                        Rectangle()
                                            .fill(Color.black)
                                            .cornerRadius(10)
                                            .frame(height: 120) // Altura do cartão
                                            .padding(.horizontal, 10) // Distância do lado esquerdo

                                    }
                            .padding(.vertical, 5) // Espaçamento vertical entre os cartões
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .listStyle(PlainListStyle())


                }

                Spacer()

                Button(action: {
                    viewModel.isShowingAddJobView.toggle()

                }) {
                    Text("Adicionar Tarefa")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            .navigationTitle("Tarefas")
            .sheet(isPresented: $viewModel.isShowingAddJobView, onDismiss: viewModel.addJob) {
                AddJobView(companyName: $viewModel.companyName, jobTitle: $viewModel.jobTitle, remoteJob: $viewModel.remoteJob, applicationStatus: .constant(nil), viewModel: viewModel)
                    .presentationDetents([.large, .medium, .fraction(0.75)])
            }
        }
    }
}

#Preview {
    let viewModel = JobTrackerViewModel(jobs: [
           Job(companyName: "Company A", jobTitle: "Job 1", remoteJob: false, applicationDate: Date()),
           Job(companyName: "Company B", jobTitle: "Job 2", remoteJob: true, applicationDate: Date()),
           Job(companyName: "Company C", jobTitle: "Job 3", remoteJob: true, applicationDate: Date())
       ])
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
