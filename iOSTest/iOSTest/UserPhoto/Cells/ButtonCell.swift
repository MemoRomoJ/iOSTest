//  ButtonCell.swift
//  iOSTest
//  Created by Guillermo Romo Jiménez on 21/09/22.

import UIKit

class ButtonCell: UITableViewCell {

    let button =  UIButton(frame: CGRect(x: 16, y: 0, width: 300 , height: 40))
    
    override func awakeFromNib() {super.awakeFromNib()}

    
    func configureCell(){
        self.selectionStyle = .none
        button.setTitle("Tomar Foto selfie", for: .normal)
        button.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc func test(sender: UIButton!) {
        print("Tomando Foto")
    }
}
