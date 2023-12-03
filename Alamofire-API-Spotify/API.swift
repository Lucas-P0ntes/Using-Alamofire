//
//  API.swift
//  Alamofire-API-Spotify
//
//  Created by Lucas Pontes on 03/12/23.
//

import Foundation
import Alamofire
 
struct ExternalURLs: Codable {
    let spotify: String?
}

struct Followers: Codable {
    let href: String?
    let total: Int?
}

struct Image: Codable {
    let height: Int?
    let url: String?
    let width: Int?
}

struct Artist: Codable {
    let externalURLs: ExternalURLs?
    let followers: Followers?
    let genres: [String]?
    let href: String?
    let id: String?
    let images: [Image]?
    let name: String?
    let popularity: Int?
    let type: String?
    let uri: String?
}

class SpotifyAPI: ObservableObject {
    
    private let clientID = ""
    private let clientSecret = ""
    private var token = ""
    private var tokenType = ""
    private var expiresIn = 0
    
    @Published var users: [Artist] = []
    
    
    func fazerRequisicaoPost() {
        // Substitua a URL abaixo pela sua API
        let url = "https://accounts.spotify.com/api/token"
        
        let parameters: [String: String] = [
            "grant_type": "client_credentials",
            "client_id": self.clientID,
            "client_secret": self.clientSecret
        ]
        
        
        AF.request(url,
                      method: .post,
                      parameters: parameters,
                      encoding: URLEncoding.httpBody,
                      headers: ["Content-Type": "application/x-www-form-urlencoded"])
               .validate()
               .responseJSON { response in
                   switch response.result {
                   case .success(let value):
                       if let json = value as? [String: Any],
                          let accessToken = json["access_token"] as? String,
                          let tokenType = json["token_type"] as? String,
                          let expiresIn = json["expires_in"] as? Int {
                           
                           self.tokenType = tokenType
                           self.token = accessToken
                           self.expiresIn = expiresIn
                           print("Token: " +  self.token + "-----------------")
                           
                           // Faça o que desejar com as variáveis aqui
                       } else {
                           print("Não foi possível obter os valores do JSON.")
                       }

                   case .failure(let error):
                       print("Error: \(error.localizedDescription)")
                   }
           }
    }
    
    func fazerRequisicao() {
        fazerRequisicaoPost()
            
            // Substitua a URL abaixo pela sua API
        // Substitua a URL abaixo pela sua API
          let url = "https://api.spotify.com/v1/artists/4Z8W4fKeB5YxbusRsdQVPb"
          
          let headers: HTTPHeaders = [
              "Authorization": "Bearer \(token)"
          ]
          
          AF.request(url, method: .get, headers: headers)
              .validate()
              .responseDecodable(of: Artist.self) { response in
                  switch response.result {
                  case .success(let artist):
                      self.users = [artist]
                      print("Dados da resposta: \(artist)")
                      
                  case .failure(let error):
                      print("Erro na requisição: \(error)")
                  }
              }
      
        }
        
        
        
        
    }
