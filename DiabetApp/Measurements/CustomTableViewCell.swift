//
//  CustomTableViewCell.swift
//  DiabetApp
//
//  Created by Мырзахан Акерке on 09.04.2021.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var sugarLbl: UILabel!
    @IBOutlet weak var foodLbl: UILabel!
    
    @IBOutlet weak var commentLbl: UILabel!
    @IBOutlet weak var insulinLnLbl: UILabel!
    @IBOutlet weak var insulinShLbl: UILabel!
        lazy var backView: UIView = {

        let view = UIView(frame: CGRect(x: 4, y: 0, width: self.frame.width, height: self.frame.height))
        view.backgroundColor = UIColor.white
        return view
        //120
    }()
    lazy var date: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 4, y: 0, width: backView.frame.width - 116, height: 50))
        lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()

    lazy var sugarImage: UIImageView = {
        let sugarImage = UIImageView(frame: CGRect(x: 4, y: 35, width: 22, height: 22))
        sugarImage.contentMode = .scaleAspectFill
        return sugarImage
    }()

    lazy var sugar: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 28, y: 30, width: backView.frame.width - 101, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()

    lazy var foodImage: UIImageView = {
        let foodImage = UIImageView(frame: CGRect(x: 52, y: 35, width: 22, height: 22))
        foodImage.contentMode = .scaleAspectFill
        return foodImage
    }()
    lazy var food: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 76, y: 30, width: backView.frame.width - 86, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()

    lazy var insulinShImage: UIImageView = {
        let insulinShImage = UIImageView(frame: CGRect(x: 100, y: 35, width: 22, height: 22))
        insulinShImage.contentMode = .scaleAspectFill
        return insulinShImage
    }()
    lazy var insulinSh: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 124, y: 30, width: backView.frame.width - 71, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()
    lazy var insulinLnImage: UIImageView = {
        let insulinLnImage = UIImageView(frame: CGRect(x: 148, y: 35, width: 22, height: 22))
        insulinLnImage.contentMode = .scaleAspectFill
        return insulinLnImage
    }()
    lazy var insulinLn: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 172, y: 30, width: backView.frame.width - 56, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()

    lazy var commentImage: UIImageView = {
        let commentImage = UIImageView(frame: CGRect(x: 4, y: 65, width: 22, height: 22))
        commentImage.contentMode = .scaleAspectFill
        return commentImage
    }()
    lazy var comment: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 28, y: 60, width: backView.frame.width - 41, height: 30))
        lbl.textAlignment = .left
        return lbl
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
//        //userImage.layer.cornerRadius = 52
//        //userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       addSubview(backView)
        backView.addSubview(date)
        backView.addSubview(sugarImage)
        backView.addSubview(sugar)
        backView.addSubview(foodImage)
        backView.addSubview(food)
        backView.addSubview(insulinShImage)
        backView.addSubview(insulinSh)
        backView.addSubview(insulinLnImage)
        backView.addSubview(insulinLn)
        backView.addSubview(commentImage)
        backView.addSubview(comment)
    }
       
    }


