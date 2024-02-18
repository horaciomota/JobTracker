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
                                // Linha vertical à esquerda (linha do tempo)
                                VStack(alignment: .leading, spacing: 0) {
                                    HStack(alignment: .top) {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 1)
                                                   Circle()
                                                       .fill(Color.gray)
                                                       .frame(width: 22, height: 12)
                                                       .padding(.top, -40)
                                        }


                                        HStack {
                                            VStack(alignment: .leading) {
                                                       // Conteúdo do cartão
                                                Text(viewModel.jobsList[index].companyName)
                                                           .font(.headline)
                                                           .foregroundColor(.white)

                                                Text(viewModel.jobsList[index].jobTitle)
                                                           .font(.subheadline)
                                                           .foregroundColor(.white)

                                                HStack {
                                                    Image(systemName: "globe")
                                                        .foregroundStyle(Color.white)
                                                        .font(.footnote)

                                                    Text("Ireland")
                                                                .font(.subheadline)
                                                            .foregroundColor(.white)


                                                        Text("55k - 60k")
                                                            .font(.subheadline)
                                                            .foregroundColor(.white)
                                                }
                                                   }
                                            Spacer()

                                        }
                                        .padding(23) // Espaçamento interno do card
                                        .background(Color.black.opacity(0.8))
                                        .cornerRadius(10)
                                        }

                                }
                                .padding(.leading, 0) // Espaçamento entre a bolinha e a borda esquerda
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
            .navigationTitle("Applications")
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
