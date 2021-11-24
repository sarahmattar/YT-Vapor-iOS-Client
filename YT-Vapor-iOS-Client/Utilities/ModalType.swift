//
//  ModalType.swift
//  YT-Vapor-iOS-Client
//
//  Created by Sarah Mattar on 2021-11-22.
//

import Foundation

enum ModalType: Identifiable {
    var id: String {
        switch self {
        case .add: return "add"
        case .update: return "update"
        }
    }
    
    case add
    case update(Song)
}
