# Salesforce Apex Sort SObject List
This ```Sortable``` class provides two methods to sort any SObject List ascending ```sortAscending()``` or descending ```sortDescending()``` by a chosen field whether its type is text, number, date or time.

# Use Cases
* Reusable class for any SObject List, instead of implementing a custom code each time
* A generated Apex list which needs to be sorted before insertion, or performing other functions
* Sort a list from a query multiple times by different criteria

# Snippets
Sort by ```Name``` ASC
```apex
List<Account> accounts = [SELECT Name FROM Account];
accounts = Sortable.sortAscending(accounts, 'Name');
```
Sort by ```Amount``` DESC
```apex
List<Opportunity> opportunities = [SELECT Amount FROM Opportunity];
opportunities = Sortable.sortDescending(opportunities, 'Amount');
```
Sort by ```Birthdate``` ASC
```apex
List<Contact> contacts = [SELECT Birthdate FROM Contact];
contacts = Sortable.sortAscending(contacts, 'Birthdate');
```