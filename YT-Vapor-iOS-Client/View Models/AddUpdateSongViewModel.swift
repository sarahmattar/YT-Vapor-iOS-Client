//
//  AddUpdateSongViewModel.swift
//  YT-Vapor-iOS-Client
//
//  Created by Sarah Mattar on 2021-11-22.
//

import Foundation
import SwiftUI

final class AddUpdateSongViewModel: ObservableObject {
    @Published var songTitle = ""
    
    var songID: UUID?
    
    var isUpdating: Bool {
        songID != nil
    }
    
    var buttonTitle: String {
        songID != nil ? "Update Song" : "Add Song"
    }
    
    init() { }
    init(currentSong: Song) {
        self.songTitle = currentSong.title
        self.songID = currentSong.id
    }
    
    func addSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.badURL
        }
        
        let song = Song(id: nil, title: songTitle)
        
        try await HTTPClient.shared.sendData(to: url, object: song, httpMethod: HTTPMethods.POST.rawValue)
    }
    
    func updateSong() async throws {
        let urlString = Constants.baseURL + Endpoints.songs
        
        guard let url = URL(string: urlString) else {
            throw HTTPError.badURL
        }
        
        let songToUpdate = Song(id: songID, title: songTitle)
        
        try await HTTPClient.shared.sendData(to: url, object: songToUpdate, httpMethod: HTTPMethods.PUT.rawValue)
    }
    
    func addOrUpdateAction(completion: @escaping () -> Void) {
        Task {
            do {
                if isUpdating {
                    try await updateSong()
                } else {
                    try await addSong()
                }
            } catch {
                print("❌ Error: \(error)")
            }
            // wait for action to complete before updating the view
            completion()
        }
    }
}
