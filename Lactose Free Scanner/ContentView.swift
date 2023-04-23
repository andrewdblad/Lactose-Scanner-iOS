//
//  ContentView.swift
//  Gluten Free Scanner
//
//  Created by Andrew Blad on 4/8/23.
//
import CodeScanner
import SwiftUI

struct ContentView: View {
    
    @State var isShowingScanner = false
    @State var barCodeNumber = ""
    @State var backgroundColor = Color("cream")
    @State var mainImage = "main"

    var body: some View {

        ZStack {

            backgroundColor
                .ignoresSafeArea()
                
            VStack {
                Text("Lactose Scanner")
                    .foregroundColor(.black)
                    .font(.system(size: 25, weight: .bold)) 
                    .padding(.top, 10)
                    .padding(.bottom, 25)

                
              
               
                VStack{
                    
            
                    MainImageView(image: mainImage)
                        .padding(.top, -20)
                    
                    //View Contains API Call and appropriate text boxes
                    FoodInfoView(barCodeNumber: $barCodeNumber, mainImage: $mainImage)
                    Spacer()
                  
                    
                }
                
               
          
         
                
                //barcode button and scanner proccessing
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



