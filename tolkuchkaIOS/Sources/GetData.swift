//
//  GetData.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 07.05.2023.
//

import Foundation
import SwiftUI
//let host = "http://192.168.0.101:80/"
let host = "https://\(getLocal())tolkuchka.bar/"
//let host = "http://\(getLocal())tolkuchkalocal.bar/"

struct MyGlobals {
    static var uniqId: Int = 0
}

func getId() -> Int {
    //    print(MyGlobals.uniqId)
    MyGlobals.uniqId += 1
    return MyGlobals.uniqId
}

func getData<T: Decodable>(_ url: String, completion: @escaping (T) -> ()) -> T? {
    let base: String = "\(host)api/homeapp/"
    guard let url = URL(string: "\(base)\(url)") else {
        fatalError("Invalid URL")
    }
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let err = error {
            print("Network request failed: \(err.localizedDescription)")
            return
        }
        
        guard let validData = data else {
            print("No data received from the server")
            return
        }
#if DEBUG
        // Convert data to string and print it
        if let stringData = String(data: validData, encoding: .utf8) {
            print("url: \(url)")
            print(stringData)
        }
#endif
        
        do {
            let d = try JSONDecoder().decode(T.self, from: validData)
            DispatchQueue.main.async {
                completion(d)
            }
        } catch let jsonError as NSError {
            print("url: \(url)")
            print("JSON decode failed: \(jsonError.localizedDescription)")
        }
    }).resume()
    return nil
}

func getImage(imageFolder: String, id: Int, imageIndex: Int, version: Int) -> URL?{
    let idString = String(format: "%d", id)
    let imageIndexString = String(format: "%d", imageIndex)
    let versionString = String(format: "%d", version)
    let urlString = "\(host)images/\(imageFolder)/\(idString)-\(imageIndexString).webp?v=\(versionString)"
    return URL(string: urlString)
}

func getImageByString(path: String, versionString: Int) -> URL?{
    let urlString = "\(host)\(path)webp?v=\(versionString)"
    return URL(string: urlString)
}
