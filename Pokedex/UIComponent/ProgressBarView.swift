//
//  ProgressBarView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct ProgressBarView: View {
    var progress: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: 20)
                    .opacity(0.2)
                    .background(Color.gray.opacity(0.2))
                    .frame(height: 60)
                
                Rectangle()
                    .frame(width: geometry.size.width * progress, height: 20)
                    .background(Color.black)
                    .frame(height: 60)
                
                Text("\(String(format: "%.2f", progress))")
                    .foregroundColor(.white)
                    .font(.system(size: 16))
                    .padding()
            }
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: 0.65)
    }
}
