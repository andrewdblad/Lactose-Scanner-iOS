//
//  SwiftUIView.swift
//  Gluten Free Scanner
//
//  Created by Andrew Blad on 4/11/23.
//
import CodeScanner
import SwiftUI

struct BarCodeScannerView: View {
    
    @Binding var isShowingScanner: Bool
    @Binding var barCodeNumber: String
    
    var body: some View {

        ZStack {
            // camera button
            Button {
                isShowingScanner = true
                
            } label: {
                HStack {
                    Text("Tap To Scan")
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Image("cameraImage")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
                .frame(width: 300, height: 50)
                .background(Color("main"))
                .cornerRadius(10)
            }

            
        }
        .padding(.bottom, 10)
        
        // popup camera view when button is pressed
        .sheet(isPresented: $isShowingScanner) {
            ZStack {
                CodeScannerView(codeTypes: [.codabar, .code128, .code39, .code39Mod43, .code93,.gs1DataBar, .gs1DataBarExpanded, .gs1DataBarLimited, .aztec, .catBody, .dataMatrix,.dogBody, .ean13, .ean8, .face, .humanBody, .interleaved2of5, .itf14, .microPDF417,.upce, .salientObject], completion: handleScan)
                Image("scannerImage")
                    .resizable()
                    .frame(width: 390, height: 125)
                    .opacity(0.6)
            }
        }
    }
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        
        switch result {
        case .success(let result):
            let details = result.string
            barCodeNumber = details

            
        case.failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
            
        }
    }
}
