//
//  Camera.swift
//  CuriosityRover
//
//  Created by Sofia Perez on 7/8/24.
//

import Foundation

class Camera {
    let id: Int
    let name: String
    var imagePath: String
    let date: String
    
    enum Keys: String{
        case id
        case name = "full_name"
        case imagePath = "img_src"
        case date = "earth_date"
        case camera
    }
    
    init(id: Int, name: String, imagePath: String, date: String) {
        self.id = id
        self.name = name
        self.imagePath = imagePath
        self.date = date
    }
}

extension Camera {
    convenience init?(dict: [String: Any]){
        let id = dict[Keys.id.rawValue] as? Int ?? 0
        let date = dict[Keys.date.rawValue] as? String ?? ""
        let cameraDict = dict[Keys.camera.rawValue] as? [String: Any] ?? [:]
        let name = cameraDict[Keys.name.rawValue] as? String ?? ""
        let imagePath = dict[Keys.imagePath.rawValue] as? String ?? ""
        
        self.init(id: id, name: name, imagePath: imagePath, date: date)
    }
}
