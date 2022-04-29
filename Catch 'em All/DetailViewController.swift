//
//  DetailViewController.swift
//  Catch 'em All
//
//  Created by Chris Bond on 4/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var creature: Creature!
    var creatureDetail = CreatureDetail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if creature != nil {
            creature = Creature(name: "", url: "")
        }
        nameLabel.text = creature.name
        
        heightLabel.text = ""
        weightLabel.text = ""
        
        creatureDetail.urlString = creature.url
        creatureDetail.getData {
            DispatchQueue.main.async {
                self.weightLabel.text = "\(self.creatureDetail.weight)"
                self.heightLabel.text = "\(self.creatureDetail.height)"
                
                guard let url = URL(string: self.creatureDetail.imageURL) else
                {return}
                do {
                    let data = try Data(contentsOf: url)
                    self.imageView.image = UIImage(data: data)
                } catch {
                    print("ERROR: COuld not get image from URL \(self.creatureDetail.imageURL) \(error.localizedDescription)")
                }
            }
        }
    }
}
