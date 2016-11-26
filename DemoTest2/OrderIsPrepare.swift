import UIKit
import Firebase
import FirebaseDatabase

class OrderIsPrepare : UITableViewController {
    
    
   
   
    @IBOutlet var PrepareTable: UITableView!

    
    var CartRes = [Res_Info]()
    var CartMeal = [MealModel]()
    var GuestToOrder = [OrderGuestModel]()
    var MealToOrder = [MealModel]()
    var Guest_Count : String?
    var ResUID : String?
    var GuestCount : String?

    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
  CatchResUID()
        self.CartRes.removeAll()
        self.CartMeal.removeAll()
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
        
        FIRDatabase.database().reference().child("User_Res").child(ResUID!).observeEventType(.Value, withBlock: {(snapshot) in
            print (snapshot)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Res = Res_Info()
                Cart_Res.setValuesForKeysWithDictionary(dictionary)
                print(Cart_Res)
                self.CartRes.append(Cart_Res)
                print(Cart_Res.Res_Name)
                print(Cart_Res.Res_Loc)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("User_Res").child(ResUID!).child("Res_Order").child(Guest_Uid!).child("Order_Meal").observeEventType(.ChildAdded, withBlock: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let Cart_Meal = MealModel()
                Cart_Meal.setValuesForKeysWithDictionary(dictionary)
                self.CartMeal.append(Cart_Meal)
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})
        FIRDatabase.database().reference().child("User_Res").child(ResUID!).child("Res_Order").child(Guest_Uid!).child("Order_Guest").observeEventType(.Value, withBlock: {(snapshot) in
            print(snapshot.value)
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let GuestCount = OrderGuestModel()
                GuestCount.setValuesForKeysWithDictionary(dictionary)
                self.Guest_Count = GuestCount.Guest_Count
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }})

    }
    func removeCart(){
        let Guest_Uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("User_Guest").child(Guest_Uid!).child("Guest_Cart").removeValue()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (CartMeal.count)
        return CartMeal.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.row == 0 {
            let Cart_Res = CartRes[indexPath.row]
            print(CartRes)
            self.tableView.rowHeight = 381
            let cell = PrepareTable.dequeueReusableCellWithIdentifier("ResOrder" , forIndexPath:  indexPath) as! PrepareResCell
            let  Cart_Meal = CartMeal[indexPath.row]
        print(Cart_Res.Res_Name)
            print(CartRes[indexPath.row])
            print (Cart_Res.Res_Name)
            print (Cart_Res.Res_Name)
            print(Cart_Res.Res_Loc)
            cell.ResNameInOrder.text = Cart_Res.Res_Name
            cell.ResLocInOrder.text = Cart_Res.Res_Loc
//            cell.ResTel.text = Cart_Res.Res_Tel
            cell.GuestCountInOrder.text = Guest_Count
            cell.MealNameInOrder.text = Cart_Meal.MealId
            cell.MealCountInOrder.text = Cart_Meal.MealCount
            cell.MealPriceInOrder.text = Cart_Meal.MealPrice
            
            return cell
        }else{
            self.tableView.rowHeight = 95
            let cell = PrepareTable.dequeueReusableCellWithIdentifier("MealOrder", forIndexPath:  indexPath) as! PrepareMealCell
            let  Cart_Meal = CartMeal[indexPath.row]
            cell.MealNameInOrder.text = Cart_Meal.MealId
            cell.MealCountInOrder.text = Cart_Meal.MealCount
            cell.MealPriceOrder.text = Cart_Meal.MealPrice
            
            return cell
        }
    }
        func CatchResUID(){
        let UserUID = FIRAuth.auth()?.currentUser?.uid
        
FIRDatabase.database().reference().child("User_Guest").child(UserUID!).child("Guest_Cart").child("Cart_Res").observeEventType(.Value, withBlock: {(snapshot) in
    print (snapshot.value)
            if let dicrionary = snapshot.value as? [String:AnyObject]{
            
                let GetUid = CartResInfo()
                GetUid.setValuesForKeysWithDictionary(dicrionary)
                self.ResUID = GetUid.OrderUIDForRes
                print(self.ResUID)
                self.getvalueToDictionary()
    }
    
        })
        
    }
}