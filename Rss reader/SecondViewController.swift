//
//  SecondViewController.swift
//  Rss reader
//
//  Created by Даша Волошина on 1.02.23.
//

import UIKit
import SnapKit
import SDWebImage

class SecondViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var topView = UIView()
    var viewImage = UIImageView()
    var labelTitle = UILabel()
    var labelDate = UILabel()
    var lablelDecription = UILabel()
    var contentView = UIView()
    var model = News()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        
        contentView.addSubview(topView)
        topView.addSubview(viewImage)
        
        contentView.addSubview(stackView)
        createStackView()
        createConstraints ()
        create()
        createlabel()
        
    }
    
    func create() {
        viewImage.sd_setImage(with: URL(string: model.image!)!)
        labelTitle.text = model.title
        labelDate.text = String((model.date)!.dropLast(5))
        lablelDecription.text =  model.descriptions
    }
    
    func createStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        
        stackView.addArrangedSubview(labelTitle)
        stackView.addArrangedSubview(labelDate)
        stackView.addArrangedSubview(lablelDecription)
    }
    
    func createlabel() {
        viewImage.contentMode = .scaleAspectFit
        labelTitle.numberOfLines = 0
        labelTitle.sizeToFit()
        labelTitle.lineBreakMode = .byWordWrapping
        
        lablelDecription.numberOfLines = 0
        lablelDecription.sizeToFit()
        lablelDecription.lineBreakMode = .byWordWrapping
        labelTitle.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
        
        lablelDecription.font = UIFont(name: "Noto Sans Kannada Regular", size: 20)
    }
    
    func createConstraints (){
        
        scrollView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { make in
            make.right.equalTo(scrollView.frameLayoutGuide.snp.right)
            make.left.equalTo(scrollView.frameLayoutGuide.snp.left)
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
        
        topView.snp_makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        
        viewImage.snp.makeConstraints { make in
            
            make.top.equalTo(topView.snp.top)
            make.left.equalTo(topView.snp.left)
            make.right.equalTo(topView.snp.right)
            make.bottom.equalTo(topView.snp.bottom)
        }
        
        stackView.snp.makeConstraints { make in
            
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(topView.snp.top).inset(300)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        
        
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.top)
            make.left.equalTo(stackView.snp.left).inset(10)
            make.right.equalTo(stackView.snp.right).inset(10)
            make.height.equalTo(stackView.snp.height).multipliedBy(0.3)
            
        }
        
        labelDate.snp.makeConstraints { make in
            
            make.left.equalTo(stackView.snp.left).inset(10)
            make.right.equalTo(stackView.snp.right).inset(10)
            make.height.equalTo(stackView.snp.height).multipliedBy(0.1)
            
        }
        
        lablelDecription.snp.makeConstraints { make in
            
            make.left.equalTo(stackView.snp.left).inset(10)
            make.right.equalTo(stackView.snp.right).inset(10)
            make.height.equalTo(stackView.snp.height).multipliedBy(0.6)
        }
    }
}
