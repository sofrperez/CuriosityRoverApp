//
//  CameraListView.swift
//  CuriosityRover
//
//  Created by Sofia Perez on 7/8/24.
//

import SwiftUI

struct CameraListView: View {
    @StateObject private var viewModel = CameraListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        HStack{
            TextField("Enter Date YYYY-MM-DD", text: $searchText)
            Button {
                viewModel.fetchCameras(date: searchText)
            } label: {
                Text("Search")
            }
        }
        .padding()
        List{
            ForEach(viewModel.cameras, id: \.id) {camera in
                VStack{
                    Text(camera.name)
                    AsyncImage(url: URL(string: "\(camera.imagePath)")) { image in
                        image
                            .resizable()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
        }
    }
}

#Preview {
    CameraListView()
}
