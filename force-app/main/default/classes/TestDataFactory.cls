@isTest

public class TestDataFactory {

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
    
    // Create orders with ordered status on one account
    // TotalAmount of each orders is equal to 100
    public static List<Order> createOrdersOnAccount(Integer numberOfOrders, Id accountId){

        //create a contract
        Contract cont = new Contract (AccountId = accountId, Status = 'Draft', StartDate = Date.today(), ContractTerm= 1);
        insert cont;
        cont.Status = 'Activated';
        update cont;

        //create a pricebook
        Id priceBookId = Test.getStandardPricebookId();

        //Create a product
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        Insert product;
        
        // Create a priceBookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id   = Test.getStandardPricebookId(),
            Product2Id     = product.Id,
            UnitPrice      = 1020,
            IsActive       = true
        );
        Insert pbe;

        // Insert draft orders
        List<Order> newOrders = new List<Order>();
            for(Integer i=0; i<numberOfOrders; i++) {
                Order newOrder = new Order(
                    AccountId = accountId, ContractId = cont.Id, EffectiveDate = System.today(), Status = 'Draft', Pricebook2Id = priceBookId , ShipmentCost__c= 10);
                newOrders.add(newOrder);
            }
        insert newOrders;

        // Create an order product: totalAmount is equal to 100
        List<OrderItem> items = new List<OrderItem>();
        for(Order newOrder : newOrders) {
            OrderItem item = new OrderItem (OrderId = newOrder.Id, PricebookEntryId = pbe.Id, Quantity=10, UnitPrice = 10);
            items.add(item);
        }
        insert items;

        // Activate the orders
        return newOrders;
    }

}