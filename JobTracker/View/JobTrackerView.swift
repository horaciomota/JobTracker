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
                        ForEach(viewModel.sortedJobsList.indices, id: \.self) { index in
                            // Linha vertical à esquerda (linha do tempo)
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .top) {

                                    VStack(alignment: .center, spacing: 0) {
                                        Text(viewModel.formattedDate(from: viewModel.sortedJobsList[index].applicationDate))
                                            .font(.caption)
                                            .foregroundColor(.gray.opacity(0.7))
                                        Text(viewModel.formattedDay(from: viewModel.sortedJobsList[index].applicationDate))
                                            .font(.title)
                                            .foregroundColor(.gray.opacity(0.7))

                                    }
                                    .padding(.top, 25)
                                    .padding(.trailing, 5)


//                                    ZStack {
//                                        Rectangle()
//                                            .frame(width: 1)
//                                        Circle()
//                                            .fill(Color.gray)
//                                            .frame(width: 22, height: 12)
//                                            .padding(.top, -40)
//                                    }


                                    HStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            HStack {
                                                // Conteúdo do cartão
                                                Text(viewModel.sortedJobsList[index].companyName)
                                                    .font(.headline)
                                                    .foregroundColor(viewModel.sortedJobsList[index].textColor)

                                                Spacer()
                                                Text(viewModel.sortedJobsList[index].remoteJob ? "Remote" : "In-site")
                                                    .font(.footnote)
                                                    .foregroundColor(viewModel.sortedJobsList[index].textColor)
                                            }

                                            Text(viewModel.sortedJobsList[index].jobTitle)
                                                .font(.subheadline)
                                                .foregroundColor(viewModel.sortedJobsList[index].textColor)

                                            HStack {
                                                Image(systemName: "eurosign")
                                                    .font(.footnote)
                                                    .foregroundColor(viewModel.sortedJobsList[index].textColor)

                                                Text("55k - 60k")
                                                    .font(.footnote)
                                                    .foregroundColor(viewModel.sortedJobsList[index].textColor)
                                            }
                                        }
                                        Spacer()

                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(15) // Espaçamento interno do card
                                    .background(viewModel.sortedJobsList[index].backgroundColor.opacity(0.5))         
                                    .cornerRadius(30)
                                }

                            }
                            .padding(.leading, -20) // Espaçamento entre a bolinha e a borda esquerda
                        }
                        .onDelete(perform: viewModel.deleteTask)
                    }
                    .scrollIndicators(.hidden)
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
                AddJobView(companyName: $viewModel.companyName, jobTitle: $viewModel.jobTitle, remoteJob: $viewModel.remoteJob, applicationDate: $viewModel.applicationDate, applicationStatus: $viewModel.applicationStatus, seniorityLevel: $viewModel.seniorityLevel, viewModel: viewModel)
                      .presentationDetents([.fraction(0.5), .large])
                      .presentationDragIndicator(.visible)
            }
        }
    }
}

// Seu código continua abaixo...




#Preview {
        let viewModel = JobTrackerViewModel()
        viewModel.jobsList = [
            Job(companyName: "Company A", jobTitle: "Job A", remoteJob: true, applicationDate: Date(), applicationStatus: .applied, seniorityLevel: .junior),
            Job(companyName: "Company B", jobTitle: "Job B", remoteJob: false, applicationDate: Date(), applicationStatus: .interviewed, seniorityLevel: .junior),
            Job(companyName: "Company C", jobTitle: "Job C", remoteJob: true, applicationDate: Date(), applicationStatus: .hired, seniorityLevel: .junior),
            Job(companyName: "Company D", jobTitle: "Job D", remoteJob: false, applicationDate: Date(), applicationStatus: .rejected, seniorityLevel: .junior)
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

extension JobTrackerViewModel {
    func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }

    func formattedDay(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
}

