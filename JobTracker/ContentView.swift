//
//  ContentView.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import SwiftUI
import ContributionChart

struct ContentView: View {
    var data: [Double]
    let rows = 7
    let columns = 14

    init() {
        data = [0.9, 0.4, 0.4, 0.4, 0.1, 0.5, 0.9, 0.1, 0.0, 0.2, 0.2, 0.2, 0.0, 0.2, 0.2, 0.5, 0.4, 0.2, 0.4, 0.5, 0.2, 0.2, 0.4, 0.3, 0.3, 0.2, 0.4, 0.0, 0.0, 0.5, 0.4, 0.3, 0.5, 0.3, 0.0, 0.0, 0.1, 0.0, 0.2, 0.3, 0.0, 0.0, 0.0, 0.5, 0.3, 0.3, 0.0, 0.3, 0.0, 0.5, 0.3, 0.3, 0.4, 0.5, 0.5, 0.3, 0.4, 0.1, 0.4, 0.2, 0.5, 0.1, 0.4, 0.2, 0.5, 0.4, 0.3, 0.5, 0.0, 0.4, 0.3, 0.2, 0.1, 0.5, 0.2, 0.0, 0.2, 0.5, 0.5, 0.3, 0.4, 0.0, 0.3, 0.3, 0.1, 0.2, 0.5, 0.2, 0.1, 0.4, 0.4, 0.0, 0.5, 0.3, 0.3, 0.5, 0.0, 0.2]
    }

    var body: some View {
                ContributionChartView(data: data,
                                      rows: rows,
                                      columns: columns,
                                      targetValue: 0.5,
                                      blockColor: .green)
        }
    }

#Preview {
    ContentView()
}
