//
//  ViewController.swift
//  SampleAlamofire
//
//  Created by 佐藤瑠偉史 on 2021/10/26.
//

import UIKit
import Alamofire

class GithubSearchViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UITextField!
    
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let cell = UINib(nibName: "TableViewCell", bundle: nil)
            tableView.register(cell, forCellReuseIdentifier: "TableViewCell")
        }
    }
    
    private var githubSearchItems: [GithubRepositoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.indicator.isHidden = true
        self.tableView.isHidden = false
    }
    
    @objc private func tapSearchButton(_ button: UIButton) {
        guard let searchWord = searchBar.text, searchWord.count > 0 else {
            print("検索文字を入力してください。")
            return
        }
        self.indicator.isHidden = false
        self.tableView.isHidden = true
        API.shared.getWithAF(searchWord: searchWord) { githubSearchItems in
            self.githubSearchItems = githubSearchItems
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.indicator.isHidden = true
        } error: { err in
            print(err)
        }
    }
}

extension GithubSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return githubSearchItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            fatalError("セルの再利用に失敗しました。")
        }
        let item = githubSearchItems[indexPath.row]
        cell.configure(item: item)
        return cell
    }
}

