//
//  CameraService.swift
//  CuriosityRover
//
//  Created by Sofia Perez on 7/8/24.
//

import Foundation

struct CameraService {
    static private let baseURL = URL(string: "https://api.nasa.gov/mars-photos/api/v1")
    
    static func fetchCameras(date: String, completion: @escaping ([Camera]?) -> Void){
        guard let baseURL else{
            completion(nil)
            return
        }
        
        let roverPathURL = baseURL.appendingPathComponent("rovers")
        let curiosityPathURL = roverPathURL.appendingPathComponent("curiosity")
        let photosPathURL = curiosityPathURL.appendingPathComponent("photos")
        var components = URLComponents(url: photosPathURL, resolvingAgainstBaseURL: true)
        let dateQueryItem = URLQueryItem(name: "earth_date", value: date)
        let apiQueryItem = URLQueryItem(name: "api_key", value: "kIlSEeK28HvUW4JCilfB3dSn6cgnPxTHTGmuRC7H")
        components?.queryItems = [dateQueryItem, apiQueryItem]
        
        guard let finalURL = components?.url else{
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error {
                completion(nil)
            }
            
            guard let data else{
                completion(nil)
                return
            }
            
            do{
                let dict = try JSONSerialization.jsonObject(with: data) as? [String: Any]
                guard let cameraDictArray = dict?["photos"] as? [[String: Any]] else{
                    completion(nil)
                    return
                }
                let fetchedCameras = cameraDictArray.compactMap({Camera(dict: $0)})
                completion(fetchedCameras)
            }catch{
                completion(nil)
                return
            }
        }.resume()
    }
    
    static func createSecureImageURL(camera: Camera) -> Camera{
        var updatedCamera = camera
        guard let imageURL = URL(string: camera.imagePath) else{
            return camera
        }
        var components = URLComponents(url: imageURL, resolvingAgainstBaseURL: true)
        if components?.scheme != "https" {
            components?.scheme = "https"
        }
        if let finalImageURL = components?.url {
            updatedCamera.imagePath = finalImageURL.absoluteString
        }
        return updatedCamera
    }
}
