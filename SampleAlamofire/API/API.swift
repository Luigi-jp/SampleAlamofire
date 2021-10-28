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
    
    func get(searchWord: String) {
        guard searchWord.count > 0 else {
            return
        }
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)&sort=stars&order=desc") else { return }
        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("API通信でエラーが発生しました。\(error)")
                return
            }
            guard let data = data, let response = response else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                let items = try? JSONDecoder().decode(GithubRepositoryModel.self, from: json as! Data)
                print(items)
            } catch {
                print("エラー")
                return
            }
            print(response)
            
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
