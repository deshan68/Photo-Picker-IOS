//
//  MultipleSelectionView.swift
//  Photo-Picker
//
//  Created by arun deshan on 2023-11-02.
//

import SwiftUI
import SwiftUI
import PhotosUI

struct MultipleSelectionView: View {
    
    @State private var images: [UIImage] = []
    @State private var photosPickerItems: [PhotosPickerItem] = []
    
    let columns = [GridItem(.flexible()), 
                   GridItem(.flexible()),
                   GridItem(.flexible()),
    ]

    
    var body: some View {
        VStack(alignment:.leading){
            
            Text("My gallery")
                .font(.title)
                .fontWeight(.semibold)
            
            PhotosPicker("Select Photos", selection: $photosPickerItems, maxSelectionCount: 5, selectionBehavior: .ordered)
            
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(0..<images.count, id: \.self) { i in
                        Image(uiImage: images[i])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width:110 , height: 110)
                            .cornerRadius(5)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        Spacer()
        .onChange(of: photosPickerItems) { _, _ in
            Task{
                for item in photosPickerItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data){
                            images.append(image)
                        }
                    }
                }
                photosPickerItems.removeAll()
            }
        }

    }
}

#Preview {
    MultipleSelectionView()
}
