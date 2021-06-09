//
//  ListTableviewCell.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import UIKit

class ListTableviewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func displayContent(item : data?) {
        titleLbl.text = item?.name ?? ""
        descLbl.text = item?.description ?? ""
        methodForLoadImage(imageUrl: item?.thumbnail ?? "")
    }
    
    func methodForLoadImage(imageUrl : String){
        let urlString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self!.imgView.image = image
                            }
                        }
                    }
                }
    }
}
