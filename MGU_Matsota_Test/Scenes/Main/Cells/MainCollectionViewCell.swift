//
//  MainCollectionViewCell.swift
//  MGU_Matsota_Test
//
//  Created by Andrew Matsota on 28.12.2020.
//

import UIKit
import Alamofire

class MainCollectionViewCell: UICollectionViewCell {

    //MARK: - Implementation
    static let identifier = "MainCollectionViewCell"
    static func nib() -> UINib {
        return UINib(nibName: Self.identifier, bundle: nil)
    }
    
    public func populate(by model: DemoResponse.Item?) {
        guard let model = model  else {return}
        let icon = model.icon
        if let url = URL(string: icon) {
            DispatchQueue.global(qos: .userInteractive).async {
                self.request = AF.request(url, method: .get).response(completionHandler: { (response) in
                    switch response.result {
                    case .success(let data):
                        guard let data = data else {return}
                        DispatchQueue.main.async {
                            self.channelImageView.image = UIImage(data: data)
                            self.channelImageView.contentMode = .center
                        }
                    
                    case .failure(let error):
                        debugPrint(error.localizedDescription)
                        DispatchQueue.main.async {
                            self.channelImageView.image = UIImage(systemName: "camera.metering.unknown")
                        }
                    }
                })
            }
        }
        
        let dateFrom = Date(timeIntervalSince1970: TimeInterval(model.start_ts)).localizeDate().MM_dd_HH_mm()
        let dateTo = Date(timeIntervalSince1970: TimeInterval(model.stop_ts)).localizeDate().MM_dd_HH_mm()
        let dateFromAttr = TextAttributeConfiguration(startedFrom: "Начало: ", endedBy: nil)
        let dateToAttr = TextAttributeConfiguration(startedFrom: "Конец: ", endedBy: nil)
        
        DispatchQueue.main.async {
            self.startsLabel.attributedText(dateFrom.stylizeFrom(attribute: dateFromAttr))
            self.endsLabel.attributedText(dateTo.stylizeFrom(attribute: dateToAttr))
            
            self.showTitleLabel.text(model.name).isLoading(false)
            self.channelNameLabel.text(model.channel_name).isLoading(false)
            self.descriptionLabel.text(model.description == "" ? "-" : model.description).isLoading(false)
        }
        
    }
    
    //MARK: - Override
    override func prepareForReuse() {
        showTitleLabel.isLoading()
        channelNameLabel.isLoading()
        descriptionLabel.isLoading()
        channelImageView.image = nil
        request?.cancel()
        request = nil
    }

    //MARK: - Private Implementation
    private var request: Request?
    
    /// - `Label`
    @IBOutlet private weak var showTitleLabel: LabelDefaults!
    @IBOutlet private weak var channelNameLabel: LabelDefaults!
    @IBOutlet private weak var startsLabel: LabelDefaults!
    @IBOutlet private weak var endsLabel: LabelDefaults!
    @IBOutlet private weak var descriptionLabel: LabelDefaults!
    
    /// - `ImageView`
    @IBOutlet private weak var channelImageView: UIImageView!
}
