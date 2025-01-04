//
//  PubProViewModel.swift
//  PubPro
//
//  Created by Ancel Dev account on 3/1/25.
//

import Foundation
import Observation
import PubProSharedDTO

@Observable
final class PubProViewModel {
    
    var user: User?
    
    let httpClient = HTTPClient()
    
    func signUp(username: String, email: String, password: String) async throws -> SignUpResponseDTO {
        let signUpData = [
            "username": username,
            "email": email,
            "password": password
        ]
        
        let resource = try Resource(
            url: EndpointURL.signUp.url,
            method: .post(JSONEncoder().encode(signUpData)),
            modelType: SignUpResponseDTO.self
        )
        
        let signUpResponseDTO = try await httpClient.load(resource)
        return signUpResponseDTO
    }
    
    func signIn(username: String, password: String) async throws -> SignInResponseDTO {
        let signInData = [
            "username": username,
            "password": password
        ]
        
        let resource = try Resource(
            url: EndpointURL.signIn.url,
            method: .post(JSONEncoder().encode(signInData)),
            modelType: SignInResponseDTO.self
        )
        
        let signInResponseDTO = try await httpClient.load(resource)
        
        if !signInResponseDTO.error && signInResponseDTO.token != nil && signInResponseDTO.userId != nil {
            let defaults = UserDefaults.standard
            defaults.set(signInResponseDTO.token, forKey: "authToken")
            defaults.set(signInResponseDTO.userId?.uuidString, forKey: "userId")
        }
        return signInResponseDTO
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "authToken")
        defaults.removeObject(forKey: "userId")
    }
}
