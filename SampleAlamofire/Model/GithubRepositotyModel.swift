//
//  ItemModel.swift
//  SampleAlamofire
//
//  Created by 佐藤瑠偉史 on 2021/10/26.
//

import Foundation

struct GithubRepositoryModel: Codable {
    let id: Int
    let name: String
    let fullName: String
    let urlStr: String
    let owner: GithubUserModel
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case urlStr = "html_url"
        case owner
    }
}

