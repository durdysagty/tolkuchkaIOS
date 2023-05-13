//
//  GetData.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 07.05.2023.
//

import Foundation
let host = "http://192.168.3.130:80/"
//let host = "https://tolkuchka.bar/"

func getData<T: Decodable>(_ url: String, completion: @escaping ([T]) -> ()) -> T? {
    let base: String = "\(host)api/homeapp/"
    guard let url = URL(string: "\(base)\(url)") else {
        fatalError("Invalid URL")
    }
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        guard let d = try? JSONDecoder().decode([T].self, from: data!)
        else {
            fatalError("Somthing went wrong!")
        }
        DispatchQueue.main.async {
            completion(d)
        }
    }.resume()
    return nil
}

//func getData(_ url: String) async -> [Brand]? {
//    //    var data: Data
//    let base: String = "\(host)api/homeapp/"
//    guard let url = URL(string: "\(base)\(url)")
//    else {
//        fatalError("Invalid URL")
//    }
//    do {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        print(String(data: data, encoding: .utf8) ?? "nil")
//        print("got data")
//        let decoder = JSONDecoder()
//        let decodedData = try decoder.decode([Brand].self, from: data)
//        print(decodedData)
//        return decodedData
//    } catch {
//        print("Something went wrong!")
//    }
//    return nil
//    //    do {
//    //        let decoder = JSONDecoder()
//    //        return try decoder.decode(T.self, from: data)
//    //    } catch {
//    //        fatalError("Couldn't parse data as \(T.self):\n\(error)")
//    //    }
//}
