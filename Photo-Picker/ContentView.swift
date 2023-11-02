
import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var images: [UIImage] = []
    @State private var avatarImage : UIImage?
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var photosPickerItems: [PhotosPickerItem] = []
    
    var body: some View {
        VStack{
            ProfileSelectionView()
            MultipleSelectionView()
            Spacer()
        }
    }
    
}
#Preview { ContentView() }
