//
//  Repository.swift
//  SquareRepoBrowser
//
//  Created by Sima Lakadia on 29/01/26.
//

struct Repository: Decodable {

    let id: Int
    let name: String
    let description: String?
    let htmlURL: String?
    let isFork: Bool
    let starsCount: Int?
    let language: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case htmlURL = "html_url"
        case isFork = "fork"
        case starsCount = "stargazers_count"
        case language
        case updatedAt = "updated_at"
    }
}
struct Owner: Decodable {
    let login: String
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
