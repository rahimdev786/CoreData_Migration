//
//  ViewController.swift
//  CoreData_Migration
//
//  Created by arshad on 4/24/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let Moc = PersistanceStore.shared.context
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let file = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path
        print(file!)
        
        
        let data1:[String:String] = ["empName":"khan baba","empAge":"00986","empAddress":"Hyderabad"]
        
//        let data2:[String:Any] = ["empID":UUID().uuidString,"empName":"Basherr","empAge":3200]
//        let data3:[String:Any] = ["empID":UUID().uuidString,"empName":"ravi","empAge":0989]
//        let data4:[String:Any] = ["empID":UUID().uuidString,"empName":"hannu","empAge":12324]
//
        saveData(data: data1)
//        saveData(data: data3)
//        saveData(data: data4)
//        saveData(data: data2)
//
        //print(UUID().uuidString)
        //print(UUID(uuidString: UUID().uuidString))
        

       // let edit = editData(i: 11, passData: data1)
        
        //let _ = delete(i: 20)
        
        for i in self.FetchData(){
            print(i.empAddress!)
        }
        
    }
}

extension ViewController{
    func saveData(data:[String:String]){
        let insertData = CDEmpolyee(context:Moc)
        insertData.empID = UUID()
        insertData.eName = data["empName"]
        insertData.empAge = data["empAge"]
        insertData.empAddress = data["empAddress"]
        
        /*
        if let data1 =  Int32(data["empAge"] as! String) {
            insertData.empAge = data1
        }
         */
        try? Moc.save()
    }
    
    
    func FetchData() -> [CDEmpolyee]{
        
        var data = [CDEmpolyee]()
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "CDEmpolyee")
        do {
         data =  try Moc.fetch(fetchData) as! [CDEmpolyee]
        } catch let err {
            print(err.localizedDescription)
        }
        return data
    }
    
    func editData(i:Int,passData:[String:String]) -> [CDEmpolyee]{
        let data = self.FetchData()
        data[i].eName = passData["empName"]
        data[i].empAge = passData["empAge"]
        data[i].empAddress = passData["empAddress"]
        try? Moc.save()
        
        return data
    }
    
    func delete(i:Int) -> [CDEmpolyee]{
        
        //here data having Nsmanaged object in array
        var data = self.FetchData()
        
        //deleted in coredata but still row will be empty in sqlite
        try? Moc.delete(data[i])
        
        //delete empty row in sqlite from fetch Data array
        data.remove(at: i)
        
        //finally save Data
        try? Moc.save()
        
        //reload Data
        return data
    }
}

