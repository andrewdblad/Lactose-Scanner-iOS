//
//  MainImageView.swift
//  Gluten Free Scanner
//
//  Created by Andrew Blad on 4/11/23.
//

import SwiftUI

struct MainImageView: View {
    
    var image: String
    
    var body: some View {
    
        Image(image)
            .resizable()
            .frame(height: 350)
            .frame(width: 350)
    }
}

