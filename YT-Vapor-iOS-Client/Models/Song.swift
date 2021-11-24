//
//  Song.swift
//  YT-Vapor-iOS-Client
//
//  Created by Sarah Mattar on 2021-11-20.
//

import Foundation

struct Song: Identifiable, Codable {
    let id: UUID?
    var title: String
}


