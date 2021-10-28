//
//  NoLibraryViewController.swift
//  SampleAlamofire
//
//  Created by 佐藤瑠偉史 on 2021/10/27.
//

import UIKit

class NoLibraryViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var noLibraryTableView: UITableView! {
        didSet {
            let cell = UINib(nibName: "TableViewCell", bundle: nil)
            noLibraryTableView.register(cell, forCellReuseIdentifier: "TableViewCell")
        }
    }
    
    private var githubSearchItems: [GithubRepositoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = true
        self.noLibraryTableView.isHidden = false
    }
    
    @objc func tapSearchButton(_ button: UIButton) {
        guard let searchWord = searchBar.text, searchWord.count > 0 else {
            print("検索文字を入力してください。")
            return
        }
        self.indicator.isHidden = false
        self.noLibraryTableView.isHidden = true
        API.shared.get(searchWord: searchWord) { githubSearchItems in
            self.githubSearchItems = githubSearchItems
            DispatchQueue.main.async {
                self.noLibraryTableView.reloadData()
                self.noLibraryTableView.isHidden = false
                self.indicator.isHidden = true
            }
        } error: { err in
            print(err)
        }

    }
}

extension NoLibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubSearchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("セルの再利用でエラーが発生しました。")
        }
        let item = githubSearchItems[indexPath.row]
        cell.configure(item: item)
        return cell
    }
}
