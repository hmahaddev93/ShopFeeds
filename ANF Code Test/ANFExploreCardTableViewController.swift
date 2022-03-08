//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ExploreContentCell", bundle: nil), forCellReuseIdentifier: "ExploreContentCell")
    }
    private var exploreData: [[AnyHashable: Any]]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
         let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
         let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
            return jsonDictionary
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath) as? ExploreContentCell {
            if let titleText = exploreData?[indexPath.row]["title"] as? String {
                cell.titleLabel.text = titleText
            }
            
            if let name = exploreData?[indexPath.row]["backgroundImage"] as? String,
               let image = UIImage(named: name) {
                cell.thumbImageView.image = image
            }
            return cell
        }

        return UITableViewCell()
    }
}
