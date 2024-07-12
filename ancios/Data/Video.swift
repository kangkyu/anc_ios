//
//  Video.swift
//  ancios
//
//  Created by Kang-Kyu Lee on 7/11/24.
//

import Foundation

struct Video: Identifiable, Decodable {
    let id: String
    let title: String
    let thumbnail_url: String
}
