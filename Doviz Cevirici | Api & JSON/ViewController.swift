//
//  ViewController.swift
//  Doviz Cevirici | Api & JSON
//
//  Created by Serhat  Şimşek  on 5.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var rsdLabel: UILabel!
    @IBOutlet weak var gelLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getirButton(_ sender: Any) {
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=941f063c507537b23a244012930d9481&format=1")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil{
                let alert = UIAlertController(title: "ERROR!", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "ok.", style: .default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                if data != nil{
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String: Any]{
                                let usd = rates["USD"] as? Double
                                
                                if var turkLiras = rates["TRY"] as? Double{
                                    
                                    turkLiras = turkLiras / usd!
                                    let formatNumber = String(format: "%.2f", turkLiras)
                                    
                                    self.tryLabel.text = "TRY: \(formatNumber)"
                                }
                                
                                if var eur = rates["EUR"] as? Double{
                                    
                                    eur = eur / usd!
                                    let formatNumber = String(format: "%.2f", eur)
                                    
                                    self.eurLabel.text = "EUR: \(formatNumber)"
                                }
                                
                                if var rsd = rates["RSD"] as? Double{
                                    
                                    rsd = rsd / usd!
                                    let formatNumber = String(format: "%.2f", rsd)
                                    
                                    self.rsdLabel.text = "RSD: \(formatNumber)"
                                }
                                
                                if var gel = rates["GEL"] as? Double{
                                    
                                    gel = gel / usd!
                                    let formatNumber = String(format: "%.2f", gel)
                                    
                                    self.gelLabel.text = "GEL: \(formatNumber)"
                                }
                                
                               
                                
                                
                            }
                        }
                        
                    } catch{
                        print("error13412")
                    }
                    
                }
            }
        }
        task.resume()
    }
    

    
}

