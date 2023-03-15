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
    
    @IBOutlet weak var collectionView:UICollectionView!{
        didSet{
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 160, height: 160)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 25, right: 25)
            collectionView.collectionViewLayout = layout
        }
    }
    
    let db = Firestore.firestore()
    var eventArray = [EventData]() //何？
    
    func fetchData(){ //Firestoreからデータを取ってきて・・に保存する関数
        //↓どんなことしてる？
        db.collection("events").order(by: "date", descending: false).addSnapshotListener{ [self] _snapShot, _error in
            if let err = _error {
                print("Error getting documents: \(err)" )
                return
            }
            
            let documents = _snapShot!.documents
            
            self.eventArray = documents.compactMap{ //何してる？
                return try? $0.data(as: EventData.self)}
        }
        self.collectionView.reloadData()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //セルの設定
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell",for:indexPath)
        
        let withLabel = cell.contentView.viewWithTag(1)as! UILabel
        let dateLabel = cell.contentView.viewWithTag(2)as! UILabel
        let topicLabel = cell.contentView.viewWithTag(3)as! UILabel
        
        cell.backgroundColor = UIColor.white
        cell.layer.cornerRadius = 12
        cell.layer.shadowOpacity = 0.4
        cell.layer.shadowRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 8, height: 8)
        cell.layer.masksToBounds = false
        
        withLabel.text = self.eventArray[indexPath.row].user2+"さん"
        
    let f = DateFormatter()
        f.setTemplate(.noYear)
        dateLabel.text = f.string(from: self.eventArray[indexPath.row].date)
        topicLabel.text = self.eventArray[indexPath.row].topic
        
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
    
extension DateFormatter {
    enum Template:String {
        case date = "yMd"    //2017/1/1
        case time = "Hms"    //12:39:22
        case hull = "yMdkHms"  //2017/1/1 12:39:22
        
        case onlyHour = "k"  //17時
        
        case era = "GG"//"西暦" (default) or "平成" (本体設定で指定している場合)
        
        case weekDay = "EEEE"//日曜日
        case noYear = "MdkHm"
    }
    func setTemplate(_ template: Template){
        // optionは拡張用の引数だが使用されていないため常に0
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
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


