@isTest

public class TestDataFactory {

    public static Account createOrdersForOneAccount(Integer num){

        // create an  account

        Account acc = new Account (Name = 'name', Description = 'test', Chiffre_d_affaire__c = 0);
        insert acc;

        //create a contract
        Contract cont = new Contract (AccountId = acc.Id, Status = 'Draft', StartDate = Date.today(), ContractTerm= 1);
        insert cont;
        cont.Status = 'Activated';
        update cont;

        //create a pricebook
        Id priceBookId = Test.getStandardPricebookId();

        //product creation 
        Product2 prod = new Product2(name = 'prod', IsActive=true);
        insert prod;

        // create a pricebook entry
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = priceBookId, Product2Id = prod.id, UseStandardPrice = false, UnitPrice= 100.00, IsActive= true);
        insert pbe;

        // create orders
        List<Order>  orderList = new List<Order>();

        for (Integer i=0; i<num ; i++){
            Order ord = new Order(AccountId = acc.Id, ContractId = cont.Id, EffectiveDate = System.today(), Status = 'Draft', Pricebook2Id = priceBookId , ShipmentCost__c= 10);
            orderList.add(ord);    
        }
        insert orderList;

        // create order item
        List<OrderItem> orderItems = new List<OrderItem>();

        for(integer j = 0 ; j<num; j++){

            OrderItem ordIt1 = new OrderItem(OrderId = orderList[j].Id , PriceBookEntryId = pbe.id, UnitPrice = 100,Quantity = 1 );
            orderItems.add(ordIt1);
        }
        insert orderItems;

        for(order o : orderList){
            o.Status = 'Activated';
        }

        update orderList;
        update orderItems;
        return acc;
    }

    //creates a new user
    public static User createUser(String name){
        Profile profileId = [SELECT Id 
                            FROM Profile 
                            WHERE Name = 'Standard User'
                            LIMIT 1];

        User newUser = new User(Username          = 'Testy' + name +'@dev.com', 
                                Email             = 'testy@dev.com',
                                Alias             = name,
                                LastName          = 'Testerson',
                                ProfileId         = profileId.id,
                                LanguageLocaleKey = 'en_US',
                                TimeZoneSidKey    = 'America/Los_Angeles',
                                LocaleSidKey      = 'en_US',
                                EmailEncodingKey  = 'ISO-8859-1');

        insert newUser;
        return newUser;
    }
    
    // Create a priceBookEntry
    public static PriceBookEntry createPriceBookEntry() {
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert product;
        
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id   = Test.getStandardPricebookId(),
            Product2Id     = product.Id,
            UnitPrice      = 1020,
            IsActive       = true
        );
        Insert pbe;
        Return pbe;
    }
    
    // Create an order with draft status, associated to an account
    public static Order createOrder(Id accountId, boolean doInsert) {
        Order newOrder    = new Order(
            AccountId     = accountId,
            Pricebook2Id  = Test.getStandardPricebookId(),
            status        = 'draft',
            effectiveDate = Date.today()
        );
        if(doInsert) {
            insert newOrder;
        }
        return newOrder;
    }
    
    // Create several orders with ordered status on one account
    // TotalAmount of each orders is equal to 100
    public static List<Order> createOrdersOnAccount(Integer numberOfOrders, Id accountId){
        // First insert draft orders
        List<Order> newOrders = new List<Order>();
        for(Integer i=0; i<numberOfOrders; i++) {
            Order newOrder = new Order(
                AccountId = accountId,
                Pricebook2Id = Test.getStandardPricebookId(),
                status = 'draft',
                effectiveDate = Date.today()
            );
            newOrders.add(newOrder);
        }
        insert newOrders;
        // Create a priceBookEntry
        PriceBookEntry pbe = TestDataFactory.createPriceBookEntry();
        // Create an order product: totalAmount is equal to 100
        List<OrderItem> items = new List<OrderItem>();
        for(Order newOrder : newOrders) {
            OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 10);
            items.add(item);
        }
        insert items;     
        // Activate the orders
        for(Order newOrder : newOrders) {
            newOrder.Status = 'ordered';
        }
        update newOrders;
        return newOrders;
    }
    
    // Create an ordered order with multiple products
    public static List<Order> createMultipleProductsOrders(Id accountId, Integer numOrders, Integer numProducts){
        List<Order> newOrders = new List<Order>();
        for(Integer i=0; i<numOrders; i++) {
            Order newOrder = TestDataFactory.createOrder(accountId, false);
            newOrders.add(newOrder);
        }
        insert newOrders;
        // Create a priceBookEntry
        PriceBookEntry pbe = TestDataFactory.createPriceBookEntry();
        // Create order products : each product add 50 to order TotalAmount 
        List<OrderItem> items = new List<OrderItem>();
        for(Order newOrder : newOrders) {
            for(Integer j=0; j<numProducts; j++) {
                OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=5, UnitPrice = 10);
                items.add(item);
            } 
        }   
        insert items;
        // Activate the orders
        for(Order newOrder : newOrders) {
            newOrder.Status = 'ordered';
        }
        update newOrders;
        return newOrders;
    }
    
}