//
//  CameraListViewModel.swift
//  CuriosityRover
//
//  Created by Sofia Perez on 7/8/24.
//

import Foundation

class CameraListViewModel: ObservableObject {
    @Published var cameras: [Camera] = []
    
    func fetchCameras(date:String){
        CameraService.fetchCameras(date: date) { camera in
            if let camera {
                DispatchQueue.main.async{
                    self.cameras = camera
                }
            }
        }
    }
}
