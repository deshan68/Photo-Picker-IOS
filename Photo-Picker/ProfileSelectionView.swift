//
//  ProfileSelectionView.swift
//  Photo-Picker
//
//  Created by arun deshan on 2023-11-02.
//

import SwiftUI
import PhotosUI

struct ProfileSelectionView: View {
    
    @State private var avatarImage : UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        HStack(alignment: .top, spacing: 20){
                PhotosPicker(selection: $photosPickerItem, matching: .images){
                    Image(uiImage: avatarImage ?? UIImage(resource: .defaultAvatar))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:100 , height: 100)
                        .clipShape(.circle)
                        
                }
                
                VStack(alignment: .leading){
                    Text("Arun Deshan")
                        .font(.title.bold())
                    
                    Text("IOS Developer")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }
            Spacer()
        }.padding(.leading, 10)
        .onChange(of: photosPickerItem){ _, _ in
            Task{
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self){
                    if let image = UIImage(data: data){
                        avatarImage = image;
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileSelectionView()
}
