//
//  ProgressBarView.swift
//  Pokedex
//
//  Created by Ankit Sharma on 20/10/23.
//

import SwiftUI

struct ProgressBarView: View {
    let progress: Int
    let barHeight: CGFloat
    
    init(progress: Int, barHeight: CGFloat = 20.0) {
        self.progress = progress
        self.barHeight = barHeight
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: barHeight)
                    .opacity(0.2)
                    .background(Color.gray.opacity(0.2))
                    .frame(height: 60)
                
                Rectangle()
                    .frame(width: (geometry.size.width * CGFloat(progress)) / 100, height: barHeight)
                    .background(Color.black)
                    .frame(height: 60)
                
                Text("\(progress)")
                    .foregroundColor(.white)
                    .font(AppFont.caption)
                    .padding()
            }
            .frame(height: barHeight)
        }
    }
}

struct ProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBarView(progress: 65)
    }
}
