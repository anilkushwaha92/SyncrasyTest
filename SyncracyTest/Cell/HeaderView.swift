//
//  HeaderView.swift
//  SyncracyTest
//
//  Created by Anil on 02/04/21.
//

import UIKit

protocol ListHeaderViewDelegate {
    func listToChangeInOtheranguage()
}

class HeaderView: UITableViewHeaderFooterView {
    var delegate: ListHeaderViewDelegate?
    @IBOutlet weak var changeLanBtn: UIButton!
    
    override func layoutSubviews(){
        super.layoutSubviews()
    }
    
    @IBAction func changeLngBtnClickMethod(_ sender: UIButton) {
        delegate?.listToChangeInOtheranguage()
    }

}
