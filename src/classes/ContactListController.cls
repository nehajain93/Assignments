/**
 * Controller for ContactListPage 
 */
public with sharing class ContactListController 
{
	// search by Name
	public String searchString {get; set;}
    
    // sort direction
    public String orderByDir {get; set;}
    
    // sorting field
    public String orderByField {get; set;}
    
    // page size
    Public Integer size{get;set;}  
    
    // page number
    Public Integer pageNumber{get;set;}  
    
    // total records
    Public Integer noOfRecords{get; set;} 
    
    /**
	 * Initialize page
	 */
    public ContactListController()
    {
        size = ContactSetting.getPageSize();
        pageNumber = 1;
        searchString = '';
        orderByDir = 'ASC';
        orderByField = 'Name';
    }
    /**
	 *  Initialize setcontroller with all values 
	 */
    public ApexPages.StandardSetController setCon 
    {
        get 
        {
            if(setCon == null) 
            {
            	ContactSelector selector = new ContactSelector();
            	String fieldString = ContactUtil.getFieldString();
            	String searchFieldString = 'Name';
            	// If setting on search string in all columns
            	if(ContactSetting.getSearchAll()) 
            		searchFieldString = fieldString;
            	List<Contact> contactList = selector.selectAllByFilter(fieldString, ContactUtil.getWhereClause(searchFieldString, searchString), orderByField + ' ' + orderByDir);
            	// Instantiating StandardSetController with a list of more than 10,000 records doesn’t throw an exception, 
            	// and instead truncates the records to the limit.
            	setCon = new ApexPages.StandardSetController(contactList);
            	setCon.setPageSize(size);
            	setCon.setPageNumber(pageNumber);  
                noOfRecords = setCon.getResultSize();
            }            
            return setCon;
        }
        set;
    }
    
    /**
	 * return list of record    
	 */
    public List<Contact> getContacts() 
    {
         return (List<Contact>) setCon.getRecords();
    }
    /**
	 * reset setcontroller
	 */
    public void refreshContacts()
    {
    	pageNumber = setCon.getPageNumber();  
    	setCon = null;
    }
    /**
	 * reverse sorting direction and reset setcontroller
	 */
    public void sortContacts()
    {
    	if(orderByDir == 'ASC')
    		orderByDir = 'DESC';
    	else
    		orderByDir = 'ASC';
    	refreshContacts();	
    }
}