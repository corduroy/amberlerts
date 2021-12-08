//
//  ContentView.swift
//  Shared
//
//  Created by Joshua McKinnon on 3/12/21.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var network: Network
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        return formatter
    }()
    
    let lowPriceColor = Color.green
    let midPriceColor = Color.orange
    let highPriceColor = Color.red
    let amberColor = Color(#colorLiteral(red: 0, green: 227/255, blue: 160/255, alpha: 1))

    var body: some View {
        NavigationView {
        ZStack {
                  Color(red: 40/255, green: 49/255, blue: 66/255)

                      .ignoresSafeArea()

        ScrollView{
            VStack(alignment: .leading) {
                let generalPrices = network.prices.filter{$0.channelType == "general"}
                let thisColor: Color = Color(#colorLiteral(red: 0, green: 227/255, blue: 160/255, alpha: 1))
                ForEach(generalPrices) { price in
                    HStack(alignment:.top) {
                        Text(price.startTime, style: .time)
                        VStack(alignment: .leading) {
                            Text(currencyFormatter.string(for: price.perKwh)!)
                                .bold()
                            
                            Text("Renewables: ") + Text(percentFormatter.string(from: NSNumber(value: price.renewables/100))!).bold()
                        }
                    }
                }
                
                .frame(width: 300, alignment: .leading)
                .padding()
                .background(thisColor)
                .cornerRadius(20)
                //                }
            }
        }
        
        .onAppear {
            network.getPrices()
        }
        //        .padding(.vertical)

    .frame(alignment: .center)

    .background(Color(#colorLiteral(red: 40/255, green: 49/255, blue: 66/255, alpha: 1)))
    }
    .navigationTitle("Current Prices")
    .foregroundColor(Color.white)
    .background(Color.white)

        }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}
