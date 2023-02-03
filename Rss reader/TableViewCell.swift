//
//  TableViewCell.swift
//  Rss reader
//
//  Created by Даша Волошина on 1.02.23.
//

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCell"
    var viewImage = UIImageView()
    var labelTitle = UILabel()
    var labelDate = UILabel()
    var viewed = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(viewImage)
        contentView.addSubview(labelDate)
        contentView.addSubview(labelTitle)
        contentView.addSubview(viewed)

        createConstraints()
        createSyle()
    }
    
    func createSyle() {
        
        viewImage.contentMode = .scaleAspectFill
        viewImage.layer.cornerRadius = 10
        viewImage.layer.masksToBounds = true
        
        labelTitle.numberOfLines = 0
        labelTitle.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        
        labelDate.font = UIFont(name: "Noto Sans Kannada Regular", size: 14)
        viewed.font = UIFont(name: "Noto Sans Kannada Regular", size: 12)
        viewed.textColor = .lightGray
    }
    
   func createConstraints() {
        viewImage.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(10)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        labelTitle.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(70)
            make.top.equalTo(contentView.snp.top).inset(5)
            make.width.equalTo(300)
            make.height.equalTo(60)
        }
        
        labelDate.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(70)
            make.top.equalTo(contentView.snp.top).inset(70)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        viewed.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).inset(2)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    } 
}
