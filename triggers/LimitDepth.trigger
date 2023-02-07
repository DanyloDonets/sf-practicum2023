trigger LimitDepth on Product_category__c (before insert, before update) {

    Set<Id> ParentCatIds = new Set<Id>();
    for (Product_category__c category : Trigger.new) {
        if (String.isNotBlank(category.ParentCategory__c)){
            ParentCatIds.add(category.ParentCategory__c);
        }
    }

    List<Product_category__c> parentCategories = [
        SELECT ParentCategory__r.ParentCategory__r.ParentCategory__c
        FROM Product_category__c
        WHERE Id = :ParentCatIds
    ];
    for (Product_category__c record : parentCategories) {
        System.debug('@@@ Parent category ' + record.Id);
    }
    
}