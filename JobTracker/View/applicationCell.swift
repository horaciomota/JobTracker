//
//  applicationCell.swift
//  JobTracker
//
//  Created by Horacio Mota on 18/02/24.
//

import SwiftUI

struct applicationCell: View {
    var body: some View {
        

        HStack(alignment: .top) {
                   Circle()
                       .fill(Color.gray)
                       .frame(width: 10, height: 10)
                       .padding(.leading, 5) // Ajusta o espaçamento à esquerda da linha do tempo

                   VStack(alignment: .leading) {
                       // Conteúdo do cartão
                       Text("Nome da Empresa")
                           .font(.headline)
                           .foregroundColor(.white)

                       Text("iOS Developer")
                           .font(.subheadline)
                           .foregroundColor(.white)
                   }
                   .padding(10) // Espaçamento interno do card
                   .background(Color.black)
                   .cornerRadius(10) // Bordas arredondadas do card
               }
               .padding(10) // Espaçamento externo do card




    }
}

#Preview {
    applicationCell()
}
