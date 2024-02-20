//
//  TabBar.swift
//  JobTracker
//
//  Created by Horacio Mota on 19/02/24.
//

import SwiftUI

struct TabBar: View {
    @StateObject private var viewModel = JobTrackerViewModel()

    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            JobTrackerView()
                .tabItem {
                    Image(systemName: "clipboard")
                    Text("Applications")
                }
                .tag(0)

            JobTrackerView()
            .tabItem {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(Circle())
            }
            .tag(1)

            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Statistics")
                }
                .tag(2)
        }


    }
}


#Preview {
    TabBar()
}
