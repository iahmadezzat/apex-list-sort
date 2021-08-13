/**
 * Created by Ahmad on 12/08/2021.
 */

global with sharing class Sortable {

    global static List<SObject> sortAscending(List<SObject> sObjects, String sortBy) {
        return sort(sObjects, sortBy, 'ASC');
    }

    global static List<SObject> sortDescending(List<SObject> sObjects, String sortBy) {
        return sort(sObjects, sortBy, 'DESC');
    }

    static List<SObject> sort(List<SObject> sObjects, String field, String orderDirection) {
        List<SObjectWrapper> wrapper = new List<SObjectWrapper>();
        for (SObject sObj : sObjects) {
            wrapper.add(new SObjectWrapper(sObj, field, orderDirection));
        }
        wrapper.sort();

        sObjects = new List<SObject>();
        for (SObjectWrapper sObj : wrapper) {
            sObjects.add(sObj.sObj);
        }
        return sObjects;
    }

    static String getFieldType(SObject sObj, String field) {
        return String.valueOf(sObj.getSObjectType().getDescribe().fields.getMap().get(field).getDescribe().getType());
    }

    class SObjectWrapper implements Comparable {

        public SObject sObj;
        public String field;
        public String order;
        public String stringValue;
        public Decimal decimalValue;
        public Date dateValue;
        public Datetime timeValue;

        SObjectWrapper(SObject sObj, String field, String order) {
            this.sObj = sObj;
            this.field = field;
            this.order = order;

            String fieldType = getFieldType(sObj, field);

            if (fieldType == 'CURRENCY' || fieldType == 'DOUBLE' || fieldType == 'INTEGER' || fieldType == 'PERCENT') {
                decimalValue = (Decimal) sObj.get(field);
            } else if (fieldType == 'DATE') {
                dateValue = Date.valueOf(sObj.get(field));
            } else if (fieldType == 'DATETIME') {
                timeValue = Datetime.valueOf(sObj.get(field));
            } else {
                stringValue = String.valueOf(sObj.get(field));
            }
        }

        public Integer compareTo(Object compareTo) {
            SObjectWrapper sObjectWrapper = (SObjectWrapper) compareTo;

            Boolean isGreater = (stringValue != null && stringValue > sObjectWrapper.stringValue) ||
                    (decimalValue != null && decimalValue > sObjectWrapper.decimalValue) ||
                    (dateValue != null && dateValue > sObjectWrapper.dateValue) ||
                    (timeValue != null && timeValue > sObjectWrapper.timeValue);

            Boolean isLess = (stringValue != null && stringValue < sObjectWrapper.stringValue) ||
                    (decimalValue != null && decimalValue < sObjectWrapper.decimalValue) ||
                    (dateValue != null && dateValue < sObjectWrapper.dateValue) ||
                    (timeValue != null && timeValue < sObjectWrapper.timeValue);

            if (order.equalsIgnoreCase('asc')) {
                return isGreater ? 1 : isLess ? -1 : 0;
            } else {
                return isGreater ? -1 : isLess ? 1 : 0;
            }
        }
    }
}