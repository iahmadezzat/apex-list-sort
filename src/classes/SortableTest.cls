/**
 * Created by Ahmad on 12/08/2021.
 */

@IsTest
public with sharing class SortableTest {

    final static Integer count = 50;

    @IsTest
    static void testSObjectSortByNameAsc() {
        List<Opportunity> opportunities = opportunities(count);
        opportunities = Sortable.sortAscending(opportunities, 'Name');

        System.assertEquals(
                'Test Opp #1',
                opportunities[0].Name,
                'First opportunity in list should be Test Opp #9'
        );

        System.assertEquals(
                opportunities[count - 1].Name,
                'Test Opp #9',
                'Last opportunity in list should be the last name alphabetically'
        );
    }

    @IsTest
    static void testSObjectSortByDateAsc() {
        List<Opportunity> opportunities = opportunities(count);
        opportunities = Sortable.sortAscending(opportunities, 'CloseDate');

        System.assertEquals(
                opportunities[0].CloseDate,
                System.today().addDays(1),
                'First opportunity in list should have the close date of today plus one'
        );

        System.assertEquals(
                opportunities[count - 1].CloseDate,
                System.today().addDays(count),
                'Last opportunity in list should have the close date of today plus 50'
        );
    }

    @IsTest
    static void testSObjectSortByDateDesc() {
        List<Opportunity> opportunities = opportunities(count);
        opportunities = Sortable.sortDescending(opportunities, 'CreatedDate');
    }

    @IsTest
    static void testSObjectSortByNumberDesc() {
        List<Opportunity> opportunities = opportunities(count);
        opportunities = Sortable.sortDescending(opportunities, 'Amount');

        System.assertEquals(
                10 * count,
                opportunities[0].Amount,
                'First opportunity in list should the highest amount. 10 * 50'
        );

        System.assertEquals(
                10 * 1,
                opportunities[count - 1].Amount,
                'Last opportunity in list should the lowest amount. 10 * 1'
        );

    }

    private static List<Opportunity> opportunities(Integer count) {
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Integer i = 1; i <= count; i++) {
            opportunities.add(
                    new Opportunity(
                            Name = 'Test Opp #' + i,
                            StageName = 'Prospecting',
                            Amount = 10 * i,
                            CloseDate = System.today().addDays(i)
                    )
            );
        }
        insert opportunities;
        return opportunities;
    }
}