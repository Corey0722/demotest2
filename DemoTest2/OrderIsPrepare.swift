import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class OrderIsPrepare : UITableViewController {
    
    
   
   
    @IBOutlet var PrepareTable: UITableView!

    
    var CartRes = [Res_Info]()
    var CartMeal = [MealModel]()
    var GuestToOrder = [OrderGuestModel]()
    var MealToOrder = [MealModel]()
    var Guest_Count : String?
    var ResUID : String?
    var GuestCount : String?

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  CatchResUID()
        self.CartRes.removeAll()
        self.CartMeal.removeAll()
        self.PrepareTable.reloadData()
      
     
  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getvalueToDictionary(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
        print(ResUID)
        
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).observe(.value, with: {(snapshot) in
            print (snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Res = Res_Info()
                Cart_Res.setValuesForKeys(dictionary)
                print(Cart_Res)
                self.CartRes.append(Cart_Res)
                print(Cart_Res.StoreID)
                print(Cart_Res.StoreLoc)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).child("StoreOrder").child(Guest_Uid!).child("OrderMeal").observe(.childAdded, with: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Meal = MealModel()
                Cart_Meal.setValuesForKeys(dictionary)
                self.CartMeal.append(Cart_Meal)
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("UserStore").child(ResUID!).child("StoreOrder").child(Guest_Uid!).child("OrderGuest").observe(.value, with: {(snapshot) in
            print(snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let GuestCount = OrderGuestModel()
                GuestCount.setValuesForKeys(dictionary)
                self.Guest_Count = GuestCount.GuestCount
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
                    })

    }
    func removeCart(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("UserGuest").child(Guest_Uid!).child("GuestCart").removeValue()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (CartMeal.count)
        return CartMeal.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.row == 0 {
            let Cart_Res = CartRes[indexPath.row]
            print(CartRes)
            self.tableView.rowHeight = 381
            let cell = PrepareTable.dequeueReusableCell(withIdentifier: "ResOrder" , for:  indexPath) as! PrepareResCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.ResNameInOrder.text = Cart_Res.StoreID
            cell.ResLocInOrder.text = Cart_Res.StoreLoc
//            cell.ResTel.text = Cart_Res.Res_Tel
            cell.GuestCountInOrder.text = Guest_Count
            cell.MealNameInOrder.text = Cart_Meal.MealID
            cell.MealCountInOrder.text = Cart_Meal.MealCount
            cell.ResTelInOrder.text = Cart_Res.StoreTel
            cell.MealPriceInOrder.text = Cart_Meal.MealPrice
            cell.StorePic.sd_setImage(with: URL(string: Cart_Res.StorePic!))
            cell.MealPic.sd_setImage(with: URL(string: Cart_Meal.MealPic!))
                
            
            return cell
        }else{
            self.tableView.rowHeight = 95
            let cell = PrepareTable.dequeueReusableCell(withIdentifier: "MealOrder", for:  indexPath) as! PrepareMealCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.MealNameInOrder.text = Cart_Meal.MealID
            cell.MealCountInOrder.text = Cart_Meal.MealCount
            cell.MealPriceOrder.text = Cart_Meal.MealPrice
            cell.MealPic.sd_setImage(with: URL(string: Cart_Meal.MealPic!))
            return cell
        }
    }
        func CatchResUID(){
        let UserUID = FIRAuth.auth()?.currentUser?.uid
        
FIRDatabase.database().reference().child("UserGuest").child(UserUID!).child("GuestCart").child("CartStore").observe(.value, with: {(snapshot) in
    print (snapshot.value)
            if let dicrionary = snapshot.value as? [String:AnyObject]{
            
                let GetUid = CartResInfo()
                GetUid.setValuesForKeys(dicrionary)
                self.ResUID = GetUid.OrderUIDForStore
                print(self.ResUID)
                self.getvalueToDictionary()
    }
    
        })
        
    }
}
