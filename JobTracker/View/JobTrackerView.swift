//
//  JobTrackerView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import SwiftUI

struct JobTrackerView: View {
    @StateObject private var viewModel = JobTrackerViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.jobsList.isEmpty {
                    ContentUnavailable()
                } else {
                    List {
                        ForEach(viewModel.jobsList) { job in
                            VStack(alignment: .leading) {
                                Text(job.companyName)
                                    .font(.headline)
                                Text(job.jobTitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
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
            AddJobView(companyName: $viewModel.companyName, jobTitle: $viewModel.jobTitle, viewModel: viewModel)
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

// Sheet que abre o form
struct AddJobView: View {
    @Binding var companyName: String
    @Binding var jobTitle: String

    @ObservedObject var viewModel: JobTrackerViewModel

    var body: some View {
        VStack {
            TextField("Título", text: $companyName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            TextField("Descrição", text: $jobTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            Button(action: {
                    viewModel.addJob()
                if !companyName.isEmpty && !jobTitle.isEmpty {
                    Text("Preencha os campos")
                }else {
                    viewModel.addJob()
                    viewModel.isShowingAddJobView.toggle()
                }

            }) {
                Text("Add Application")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.yellow.opacity(0.5))
                    .cornerRadius(10)
            }

        }
        .padding()
        .navigationTitle("Adicionar Tarefa")
    }
}


#Preview {
    JobTrackerView()
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
