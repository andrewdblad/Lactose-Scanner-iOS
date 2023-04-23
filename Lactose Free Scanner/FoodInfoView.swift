//
//  FoodInfoView.swift
//  Gluten Free Scanner
//
//  Created by Andrew Blad on 4/12/23.
//

import SwiftUI

    struct FoodResponse: Codable {
        //var code: String
        //var status: Int
        var status_verbose: String
        var product: FoodInfo
    }
    
    struct FoodInfo: Codable {
        var product_name: String
        var allergens_from_ingredients: String
    }

struct FoodInfoView: View {
    @Binding var barCodeNumber: String
    @Binding var mainImage: String
    @State var code = ""
    @State var status = 0
    @State var status_verbose = ""
    @State var product_name = ""
    @State var allergens = ""
    @State var textBox = "Scan items to check if they contain lactose"
    @State var textBox1 = ""
    @State var textBox2 = ""
    @State var textBox3 = ""
    @State var isLoading = false
    
    
    
    var body: some View {
        VStack {
            Text(textBox)
                .font(.system(size: 15, weight: .bold, design: .default))
            if barCodeNumber != "" {
                
                
                Text(product_name)
                    .font(.system(size: 20, weight: .bold, design: .default))

                Text(textBox1)
                    .font(.system(size: 15, weight: .bold, design: .default))
                    .padding(.trailing, 20)
                    .padding(.leading, 20)
                Text(textBox2)
                Text("")
                    .task {
                        textBox = ""
                    }
                Text(textBox3)
                    .font(.system(size: 15, weight: .bold, design: .default))
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .scaleEffect(2)
      
                }
                Spacer()
                
                    .task(id: barCodeNumber) {
                        await fetchData()
                              
                        if status_verbose == "product found" {
                            isLoading = false
                            textBox3 = "*Please double check labels*"
                            

                            if (allergens.contains("milk") || allergens.contains("lactose") || allergens.contains("dairy") || allergens.contains("whey") || allergens.contains("dairy products")) {
                                isLoading = false
                                textBox1 = "WARNING!"
                                textBox2 = "Contains Lactose"
                                mainImage = "containsL"

                            }
                            else if allergens == "" {
                                isLoading = false
                                textBox1 = "No Allergy Data Found!"
                                textBox2 = "May Contain Lactose"
                                mainImage = "containsM"
                            }
                            
                            
                            else {
                                isLoading = false
                                textBox2 = "Does not contain lactose"
                                textBox1 = ""
                                mainImage = "containsN"

                                
                            }
                        } else {
                            isLoading = false
                            textBox1 = "Could not find food in database. Please rescan or try again later."
                        }
                    }

                   
                
                
            }
        }.foregroundColor(.black)
    }
    
    
    func fetchData() async {
        guard let url = URL(string: "https://world.openfoodfacts.org/api/v0/product/\(barCodeNumber).json") else {
            print("URL Not Found")
            return
        }
        // fetch data from url
        do {
            print(url)
            isLoading = true
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode data
            if let response = try? JSONDecoder().decode(FoodResponse.self, from: data) {
                isLoading = false
                status_verbose = response.status_verbose
                product_name = response.product.product_name
                allergens = response.product.allergens_from_ingredients
                
            }

        } catch {
            print("Data isnt valid")
        }
    }
}


