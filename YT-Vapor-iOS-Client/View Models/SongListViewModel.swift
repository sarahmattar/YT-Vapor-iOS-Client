//
//  SongListViewModel.swift
//  YT-Vapor-iOS-Client
//
//  Created by Sarah Mattar on 2021-11-20.
//

import Foundation
import SwiftUI

class SongListViewModel: ObservableObject {
    @Published var songs = [Song]()
    
    func fetchSongs() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.badURL
        }
        
        let songResponse: [Song] = try await HTTPClient.shared.fetch(url: url)
        
        DispatchQueue.main.async {
            self.songs = songResponse
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { i in
            guard let songID = songs[i].id else {
                return
            }
            
            guard let url = URL(string: Constants.baseURL + Endpoints.songs + "/\(songID)") else {
                return
            }
            
            Task {
                do {
                    try await HTTPClient.shared.deleteData(at: songID, url: url)
                } catch {
                    print("Error deleting song")
                }
            }
        }
        
        //update the array of songs so the deleted song no longer appears
        
        songs.remove(atOffsets: offsets)
        
    }
}
