//
//  ChurchAPI.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import Foundation

let baseUrl = "https://anc-backend-7502ef948715.herokuapp.com"

func getVideos(completion: @escaping (Result<[Video], Error>) -> Void) {
    guard let url = URL(string: "\(baseUrl)/videos") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }

        do {
            let decoder = JSONDecoder()
            let videos = try decoder.decode([Video].self, from: data)
            completion(.success(videos))
        } catch {
            completion(.failure(error))
        }
    }
    task.resume()
}
