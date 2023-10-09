With
A as
(
    Select empid
    From Sales_Orders
    Where To_Char(orderdate,'YYYY') = 2007
    Group By empid
    Order By sum(Freight) desc
)
Select *
From Sales_Orders
Where   To_Char(orderdate,'YYYY') = 2008 and
        empid in(
                    Select *
                    From A
                    Where ROWNUM <= 3
);

-- Yukaridaki sorguyu derived table ile inceleyin.
Select
    *
From sales_orders
Where To_Char(orderdate,'YYYY') = 2008
And empid in(
        Select
            *
        From
        (
            Select empid
            From Sales_Orders
            Where To_Char(orderdate,'YYYY') = 2007
            Group By empid
            Order By sum(Freight) desc
        ) A
        Where rownum <= 3
);

-- Hocanin cozumu de aynisi.

