//
//  keep.swift
//  tomodati
//
//  Created by 海月 on 2022/07/27.
//

import UIKit

class EventListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell",for:indexPath)
        let ladel = cell.contentView.viewWithTag(1)as! UILabel
        ladel.text = String(indexPath.row+1)
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 12
    }
    override func viewDidLoad() {
            super.viewDidLoad()
        let alert :UIAlertController  = UIAlertController  (title:"タイトル",message:"保存を完了しました",preferredStyle: .alert)
        
        
        
            // Do any additional setup after loading the view.
    }
        
}
    
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


