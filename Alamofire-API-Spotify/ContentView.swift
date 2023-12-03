//
//  ContentView.swift
//  Alamofire-API-Spotify
//
//  Created by Lucas Pontes on 03/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var spotifyAPI = SpotifyAPI()

    
    var body: some View {
        VStack {
            Button("Fazer Requisição") {
                spotifyAPI.fazerRequisicao()
                
            }
           
            
        }
        .onAppear {
            spotifyAPI.fazerRequisicaoPost()
        }
    }
}



#Preview {
    ContentView()
}
