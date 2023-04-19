//
//  ContentView.swift
//  Gluten Free Scanner
//
//  Created by Andrew Blad on 4/8/23.
//
import CodeScanner
import SwiftUI

struct ContentView: View {
    
    @State var isGlutenFree = false
    @State var isLactoseFree = false
    @State var isShowingScanner = false
    @State var barCodeNumber = ""
    @State var backgroundColor = Color("cream")
    @State var mainImage = "containsN"

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()
                
            VStack {
                Text("Lactose Scanner")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .bold)) 
                    .padding(.top, 20)
                
                VStack{
                    MainImageView(image: mainImage)
                    FoodInfoView(isGlutenFree: $isGlutenFree, isLactoseFree: $isLactoseFree, barCodeNumber: $barCodeNumber, mainImage: $mainImage)
                }

                Spacer()
                BarCodeScannerView(isShowingScanner: $isShowingScanner, barCodeNumber: $barCodeNumber)
                    .background(
                        Image("topBottomYellow").resizable().padding(.top, 25.0).frame(width: 600.0, height: 200.0))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


