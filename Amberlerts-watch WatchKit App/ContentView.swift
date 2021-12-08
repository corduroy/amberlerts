//
//  ContentView.swift
//  Amberlerts
//
//  Created by Joshua McKinnon on 8/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Button(action: {
                // todo
            }, label: {
                Text("Dring Dring")
                    .italic()
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .frame(width: 130, height: 130)
                    .foregroundColor(Color("foreground"))
            })
            .buttonStyle(PlainButtonStyle())
            .background(Color("background"))
            .clipShape(Circle())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
