//
//  keep.swift
//  tomodati
//
//  Created by 海月 on 2022/07/27.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    let db = Firestore.firestore()
    var eventArray = [EventData]()
    
    func fetchData(){ //Firestoreからデータを取ってきて・・に保存する関数
        db.collection("events").addSnapshotListener{[self] _snapShot, _error in
            if let err = _error {
                print("Error getting documents: \(err)")
                return
            }else {
                let documents = _snapShot!.documents
                self.eventArray = documents.compactMap{
                    return try? $0.data(as: EventData.self)
                }
                self.collectionView.reloadData()
            }
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //セルの設定
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell",for:indexPath)
        let label = cell.contentView.viewWithTag(1)as! UILabel
        label.text = self.eventArray[indexPath.row].topic
        
    return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.eventArray.count
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
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


