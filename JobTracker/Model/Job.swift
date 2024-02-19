//
//  Job.swift
//  JobTracker
//
//  Created by Horacio Mota on 11/02/24.
//

import Foundation
import SwiftUI

enum ApplicationStatus: String, CaseIterable {
    case applied = "Applied"
    case interviewed = "Interviewed"
    case rejected = "Rejected"
    case hired = "Hired"

}

struct Job: Identifiable {
    let id = UUID()
    var companyName: String
    var jobTitle: String
    var remoteJob: Bool
    var applicationDate: Date
    var applicationStatus: ApplicationStatus

    var backgroundColor: Color {
          switch applicationStatus {
          case .applied:
              return Color.black
          case .interviewed:
              return Color.yellow
          case .rejected:
              return Color.purple
          case .hired:
              return Color.green // Adicionamos a cor verde para o status "hired"
          }
      }

    var textColor: Color {
        switch applicationStatus {
        case .applied:
            return Color.white
        default:
            return Color.black
        }
    }


}

