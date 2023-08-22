//
//  CategoryCollectionCell.swift
//  Neostore
//
//  Created by Neosoft on 21/08/23.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    private func setUpUI() {
        categoryLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            // Other label setup code
        }
    func setContraints(lblname: String,lblPosition:positions,imgName: String,imgPosition:positions){
        categoryLabel.text = lblname
        categoryImage.image = UIImage(named: imgName)
        applyConstraints(view: categoryLabel, position: lblPosition)
        applyConstraints(view: categoryImage, position: imgPosition)
    }
    func applyConstraints(view: UIView,position:positions){
        view.translatesAutoresizingMaskIntoConstraints = false
        if view == categoryImage {
            let widthConstraint = NSLayoutConstraint(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
            let heightConstraint = NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
            view.addConstraints([widthConstraint, heightConstraint])
        }
        switch position {
        case .topLeft:
            let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 15.0)
            let leftConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 15.0)
            containerView.addConstraints([topConstraint, leftConstraint])
        case .bottomLeft:
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -15.0)
            let leftConstraint = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 15.0)
            containerView.addConstraints([bottomConstraint, leftConstraint])
        case .topRight:
            let topConstraint = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 15.0)
            let rightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -15.0)
            containerView.addConstraints([topConstraint, rightConstraint])
        case .bottomRight:
            let bottomConstraint = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: -15.0)
            let rightConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: -15.0)
            containerView.addConstraints([bottomConstraint, rightConstraint])
        }
    }

}
