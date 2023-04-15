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
    @Binding var isGlutenFree: Bool
    @Binding var isLactoseFree: Bool
    @Binding var barCodeNumber: String
    @Binding var mainImage: String
    @State var code = ""
    @State var status = 0
    @State var status_verbose = ""
    @State var product_name = ""
    @State var allergens = ""
    @State var textBox1 = ""
    @State var textBox2 = ""
    @State var textBox3 = ""
    
    
    
    var body: some View {
        VStack {
            if barCodeNumber != "" {
                Spacer()
                Text(product_name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text(textBox1)
                    .font(.system(size: 15, weight: .bold, design: .default))
                Text(textBox2)
                Text("")
                Text(textBox3)
                    .font(.system(size: 15, weight: .bold, design: .default))
                Spacer()
                Spacer()
                    .task(id: barCodeNumber) {
                        await fetchData()
                        if status_verbose == "product found" {
                            
                            textBox3 = "Please double check labels. Some food data is incomplete and may return incorrect results."
                            
                            if  (allergens.contains("grain") || allergens.contains("wheat") || allergens.contains("glutens") || allergens.contains("grains") || allergens.contains("gluten")) && (allergens.contains("milk") || allergens.contains("lactose") || allergens.contains("dairy")) {
                            textBox1 = "WARNING!"
                            textBox2 = "Contains gluten and lactose"
                            mainImage = "containsGL"
                                
                            }
                            else if (allergens.contains("wheat") || allergens.contains("gluten") || allergens.contains("glutens") || allergens.contains("grains")) {
                                textBox1 = "WARNING!"
                                textBox2 = "Contains Gluten"
                                mainImage = "containsG"
                            }
                            else if (allergens.contains("milk") || allergens.contains("lactose") || allergens.contains("dairy")) {
                                textBox1 = "WARNING!"
                                textBox2 = "Contains Lactose"
                                mainImage = "containsL"
                            }
                            
                            else {
                                textBox2 = "Does not contain gluten or lactose"
                                textBox1 = ""
                                mainImage = "containsN"
                                
                            }
                        } else {
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
            print("Function Ran")
            print(url)
            let (data, _) = try await URLSession.shared.data(from: url)
            // decode data
            if let response = try? JSONDecoder().decode(FoodResponse.self, from: data) {
                //code = decodedResponse.code
                //status = decodedResponse.status
                status_verbose = response.status_verbose
                product_name = response.product.product_name
                allergens = response.product.allergens_from_ingredients
                
            }

        } catch {
            print("Data isnt valid")
        }
    }
}


