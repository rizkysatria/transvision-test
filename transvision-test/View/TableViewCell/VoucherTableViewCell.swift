//
//  VoucherTableViewCell.swift
//  transvision-test
//
//  Created by rizky satria on 22/06/23.
//

import UIKit

class VoucherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var couponImg: UIImageView!
    @IBOutlet weak var couponName: UILabel!
    @IBOutlet weak var couponValue: UILabel!
    @IBOutlet weak var couponDescriptionLbl: UILabel!
    @IBOutlet weak var applyBtn: UIButton!
    @IBOutlet weak var discountOffLbl: UILabel!
    
    func configureCell(imgUrl: String, name: String, value: String, expiredDate: String) {
        couponImg.loadImgFromUrl(from: imgUrl)
        couponName.text = name
        couponValue.text = value
        couponDescriptionLbl.text = expiredDate
        discountOffLbl.isHidden = !value.contains("%")
        mappingExpiredDate(expiredDate: expiredDate)
    }
    
    private func mappingExpiredDate(expiredDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: expiredDate) else { return  }
        dateFormatter.dateFormat = "dd MMMM YYYY"
        let stringDate = dateFormatter.string(from: date)
        couponDescriptionLbl.text = "Promo sampai \(stringDate)"
        self.layoutIfNeeded()
    }
    
}

extension UIImageView {
    func getImgFromUrl(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func loadImgFromUrl(from link: String) {
        guard let url = URL(string: link) else { return }
        getImgFromUrl(from: url)
    }
}
