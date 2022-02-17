Q7 :-Solution
----------------------------------------------------------------------------------------------------------------------------
SELECT 
    CARTON_ID, (len * width * height) Carton_Vol
FROM
    carton
HAVING Carton_Vol > ((SELECT 
        SUM((o.PRODUCT_QUANTITY * p.len * p.width * p.height)) TOTAL_VOLUME
    FROM
        order_items o
            JOIN
        product p ON o.product_id = p.product_id
    WHERE
        ORDER_ID = 10006))
ORDER BY Carton_Vol
LIMIT 1;

Q8 :-Solution
----------------------------------------------------------------------------------------------------------------------------

SELECT 
    a.CUSTOMER_ID,
    CONCAT(a.CUSTOMER_FNAME, ' ', a.CUSTOMER_LNAME) full_name,
    b.ORDER_ID,
    SUM(c.PRODUCT_QUANTITY) PRODUCT_QUANTITY
FROM
    online_customer a
        JOIN
    order_header b ON a.CUSTOMER_ID = b.CUSTOMER_ID
        JOIN
    order_items c ON b.order_id = c.order_id
WHERE
    b.order_status = 'Shipped'
        AND b.order_id IN (SELECT 
            ORDER_ID
        FROM
            order_items
        GROUP BY ORDER_ID
        HAVING SUM(PRODUCT_QUANTITY) > 10)
GROUP BY ORDER_ID
LIMIT 6;



Q9 :-Solution
----------------------------------------------------------------------------------------------------------------------------
SELECT 
    a.ORDER_ID,
    b.CUSTOMER_ID,
    CONCAT(b.CUSTOMER_FNAME, ' ', b.CUSTOMER_LNAME) full_name,
    SUM(c.PRODUCT_QUANTITY) TOTAL_QUANTITY_OF_PRODUCTS
FROM
    order_header a
        JOIN
    online_customer b ON a.customer_id = b.customer_id
        LEFT JOIN
    order_items c ON a.order_id = c.order_id
WHERE
    a.ORDER_ID > 10030
        AND a.order_status = 'Shipped'
        AND CUSTOMER_FNAME LIKE 'A%'
GROUP BY a.ORDER_ID;



Q10 :-Solution
--------------------------------------------------------------------------------------------------------------------
SELECT 
    c.PRODUCT_CLASS_DESC,
    SUM(PRODUCT_QUANTITY) TOTAL_QUANTITY,
    SUM(b.PRODUCT_PRICE * a.PRODUCT_QUANTITY) TOTAL_VALUE
FROM
    order_items a
        JOIN
    product b ON a.product_id = b.product_id
        JOIN
    product_class c ON b.PRODUCT_CLASS_CODE = c.PRODUCT_CLASS_CODE
        JOIN
    order_header d ON a.ORDER_ID = d.ORDER_ID
        JOIN
    online_customer e ON d.CUSTOMER_ID = e.CUSTOMER_ID
        JOIN
    address f ON e.ADDRESS_ID = f.ADDRESS_ID
WHERE
    COUNTRY NOT IN ('India' , 'USA')
GROUP BY PRODUCT_CLASS_DESC
ORDER BY Total_Quantity DESC
LIMIT 1;

