CREATE OR REPLACE VIEW vw_Sales_OrderTotalsByYear
AS

SELECT
  To_Char(O.orderdate,'YYYY') AS orderyear,
  SUM(OD.qty) AS qty
FROM Sales.Orders O
  JOIN Sales.OrderDetails OD
    ON OD.orderid = O.orderid
GROUP BY To_Char(O.orderdate,'YYYY');



