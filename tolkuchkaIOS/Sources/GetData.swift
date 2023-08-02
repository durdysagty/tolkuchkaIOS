//
//  GetData.swift
//  tolkuchkaIOS
//
//  Created by MacBook on 07.05.2023.
//

import Foundation
import SwiftUI
let host = "http://192.168.0.101:80/"
//let host = "https://tolkuchka.bar/"

struct MyGlobals {
    static var uniqId: Int = 0
}

func getId() -> Int {
    print(MyGlobals.uniqId)
    MyGlobals.uniqId += 1
    return MyGlobals.uniqId
}

func getData<T: Decodable>(_ url: String,/* _ sizeClass: UserInterfaceSizeClass?,*/ completion: @escaping (T) -> ()) -> T? {
    let base: String = "\(host)api/homeapp/"
    guard let url = URL(string: "\(base)\(url)") else {
        fatalError("Invalid URL")
    }
    //    @Environment(\.horizontalSizeClass) var sizeClass
    //    let cookies = HTTPCookie.cookies(withResponseHeaderFields: ["Set-Cookie": "w=\(sizeClass ?? .compact)"], for: url)
    //    HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: url)
    URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        do {
            let d = try JSONDecoder().decode(T.self, from: data!)
            DispatchQueue.main.async {
                completion(d)
            }
        } catch let jsonError as NSError {
            print("JSON decode failed: \(jsonError.localizedDescription)")
        }
        
        
        
        
        //        guard let d = try? JSONDecoder().decode(T.self, from: data!)
        //        else {
        //            print(error ?? "Some error")
        ////            Text(error.self!.localizedDescription)
        //            fatalError("Somthing went wrong!")
        //        //        }
        //        DispatchQueue.main.async {
        //            completion(d)
        //        }
    }).resume()
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
