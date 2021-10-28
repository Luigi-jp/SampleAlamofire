//
//  API.swift
//  SampleAlamofire
//
//  Created by 佐藤瑠偉史 on 2021/10/26.
//

import Foundation
import Alamofire

class API {
    static let shared = API()
    private init() {}
    
    func get(searchWord: String, success: (([GithubRepositoryModel]) -> Void)? = nil, error: ((Error) -> Void)? = nil) {
        guard searchWord.count > 0 else {
            print("検索文字を入力してください。")
            return
        }
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars&order=desc") else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            if let err = err {
                error?(err)
                return
            }
            guard let data = data,
                  let githubModel = try? JSONDecoder().decode(GithubModel.self, from: data) else {
                return
            }
            let githubRepositoryItems = githubModel.items
            success?(githubRepositoryItems)
            return
        }
        task.resume()
    }
    
    func getWithAF(searchWord: String, success: (([GithubRepositoryModel]) -> Void)? = nil, error: ((AFError) -> Void)? = nil) {
        guard searchWord.count > 0 else { return }
        AF.request("https://api.github.com/search/repositories?q=\(searchWord)&sort=stars&order=desc").response { response in
            switch response.result {
            case .success:
                guard let data = response.data,
                let githubModel = try? JSONDecoder().decode(GithubModel.self, from: data) else {
                    return
                }
                let githubRepositoryItems = githubModel.items
                success?(githubRepositoryItems)
                return
            case let .failure(err):
                error?(err)
                return
            }
        }
    }
}
