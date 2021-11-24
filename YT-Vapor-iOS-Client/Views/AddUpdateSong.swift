//
//  AddUpdateSong.swift
//  YT-Vapor-iOS-Client
//
//  Created by Sarah Mattar on 2021-11-22.
//

import SwiftUI

struct AddUpdateSong: View {
    
    @ObservedObject var viewModel: AddUpdateSongViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            TextField("Song Title", text: $viewModel.songTitle).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            Button {
                viewModel.addOrUpdateAction {
                    presentationMode.wrappedValue.dismiss()
                }
            } label: {
                Text(viewModel.buttonTitle)
            }
        }
    }
}

struct AddUpdateSong_Previews: PreviewProvider {
    static var previews: some View {
        AddUpdateSong(viewModel: AddUpdateSongViewModel())
    }
}
