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
                                    
                                    VStack(alignment: .center, spacing: 0) {
                                        Text("Dez")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text("7")
                                            .font(.title)
                                    }
                                    .padding(.top, 15)

                                    ZStack {
                                        Rectangle()
                                            .frame(width: 1)
                                        Circle()
                                            .fill(Color.gray)
                                            .frame(width: 22, height: 12)
                                            .padding(.top, -40)
                                    }
                                    
                                    
                                    HStack {
                                        VStack(alignment: .leading, spacing: 10) {
                                            HStack {
                                                // Conteúdo do cartão
                                                Text(viewModel.jobsList[index].companyName)
                                                    .font(.headline)
                                                    .foregroundColor(viewModel.jobsList[index].textColor)

                                                Spacer()
                                                Text(viewModel.jobsList[index].remoteJob ? "Remote" : "In-site")
                                                    .font(.footnote)
                                                    .foregroundColor(viewModel.jobsList[index].textColor)
                                            }

                                            Text(viewModel.jobsList[index].jobTitle)
                                                .font(.subheadline)
                                                .foregroundColor(viewModel.jobsList[index].textColor)

                                            HStack {
                                                Image(systemName: "eurosign")
                                                    .font(.footnote)
                                                    .foregroundColor(viewModel.jobsList[index].textColor)

                                                Text("55k - 60k")
                                                    .font(.footnote)
                                                    .foregroundColor(viewModel.jobsList[index].textColor)
                                            }
                                        }
                                        Spacer()
                                        
                                    }
                                    .frame(width: viewModel.jobsList[index].cardWidth)
                                    .padding(15) // Espaçamento interno do card
                                    .background(viewModel.jobsList[index].backgroundColor.opacity(0.5))         .cornerRadius(30)
                                }
                                
                            }
                            .padding(.leading, -20) // Espaçamento entre a bolinha e a borda esquerda
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
            .sheet(isPresented: $viewModel.isShowingAddJobView) {
                AddJobView(companyName: $viewModel.companyName, jobTitle: $viewModel.jobTitle, remoteJob: $viewModel.remoteJob, applicationStatus: $viewModel.applicationStatus, viewModel: viewModel)
            }
        }
    }
}




#Preview {
        let viewModel = JobTrackerViewModel()
        viewModel.jobsList = [
            Job(companyName: "Company A", jobTitle: "Job A", remoteJob: true, applicationDate: Date(), applicationStatus: .applied),
            Job(companyName: "Company B", jobTitle: "Job B", remoteJob: false, applicationDate: Date(), applicationStatus: .interviewed),
            Job(companyName: "Company C", jobTitle: "Job C", remoteJob: true, applicationDate: Date(), applicationStatus: .hired),
            Job(companyName: "Company D", jobTitle: "Job D", remoteJob: false, applicationDate: Date(), applicationStatus: .rejected)
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
