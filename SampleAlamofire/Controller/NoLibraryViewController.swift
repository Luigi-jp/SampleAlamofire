//
//  NoLibraryViewController.swift
//  SampleAlamofire
//
//  Created by 佐藤瑠偉史 on 2021/10/27.
//

import UIKit

class NoLibraryViewController: UIViewController {
    
    private let cellId = "NoLibraryTableViewCell"
    private let reuseId = "NoLibraryTableViewCell"
    
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var noLibraryTableView: UITableView! {
        didSet {
            let cell = UINib(nibName: cellId, bundle: nil)
            noLibraryTableView.register(cell, forCellReuseIdentifier: reuseId)
        }
    }
    
    private var githubSearchItems: [GithubRepositoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func tapSearchButton(_ button: UIButton) {
        guard let searchWord = searchBar.text, searchWord.count > 0 else {
            print("検索文字を入力してください。")
            return
        }
        API.shared.get(searchWord: searchWord)
    }
}

extension NoLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubSearchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? TableViewCell else {
            fatalError("セルの再利用でエラーが発生しました。")
        }
        return cell
    }
}
