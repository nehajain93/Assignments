/**
 * Util Class for Contact 
 */
public with sharing class ContactUtil 
{
	/**
	 * Return comma separated string of fields from fieldset
	 */
    public static String getFieldString()
    {
    	String fieldString = '';
    	for(Schema.FieldSetMember f : Schema.SObjectType.Contact.fieldSets.ContactListFields.getFields()) 
        {
            fieldString += f.getFieldPath() + ', ';
        }
        fieldString = fieldString.removeEnd(', ');
        return fieldString;
    }
    
    /**
	 * return where clause
	 */
	public static String getWhereClause(String searchFieldString, String searchString)
	{
		String likeClause = '';
		List<String> fieldList = searchFieldString.split(',');
		// field describe of contact
		Schema.DescribeSObjectResult objectDescribe  = Contact.SObjectType.getDescribe();
		Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();
		for(String fieldName : fieldList)
		{
			Schema.SObjectField field = fieldMap.get(fieldName.trim());
			// if field describe is null
			if(field != null)
			{
				Schema.DescribeFieldResult fieldDescribe = field.getDescribe();
				if(fieldDescribe.getType() != Schema.DisplayType.TextArea)
					likeClause += fieldName + ' LIKE \'%' + searchString + '%\' OR ';
			}
			else if(fieldName.trim().contains('.'))
			{
				likeClause += fieldName + ' LIKE \'%' + searchString + '%\' OR ';
			}
		}
		likeClause = likeClause.removeEnd('OR ');
		return likeClause;
	}
}