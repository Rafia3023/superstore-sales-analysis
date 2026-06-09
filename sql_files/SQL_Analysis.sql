select * from sales;

-- 1.What is the total profit?

select sum("Profit") as total_profit
from sales;

-- 2. Which custome segment is most profitable?

select Segment, 
sum("Profit") as total_porfit
from sales
group by Segment 
order by total_porfit desc;

-- 3. Which category has highest sales but low profit?

select "Category",
sum("Profit") as total_profit
from sales
group by "Category"
order by total_sales desc;

-- 4. What is the total discount?

select sum("Discount") as total_discount
from sales;

-- 5. How many product sold?

select sum("Quantity") as total_product_sold
from sales;

-- 6 Which state has hightest sales but poor profit margin?

SELECT State,
    SUM("Sales") AS total_sales,
    SUM("Profit") AS total_profit,
    ROUND(
        (SUM("Profit") / SUM("Sales")) * 100,
        2
    ) AS profit_margin_percent
FROM sales
GROUP BY State
ORDER BY total_sales DESC;


-- 7. Which sub_category has highest and least sales?

select "Sub-Category",
		sum("Sales") as total_sales
from sales
group by "Sub-Category"
order by total_sales desc
limit 1;

-- 8. What is total sales?

select round(sum("Sales"::NUMERIC), 2) as total_sales
from sales;

-- 9. Which month has highest sales?

SELECT
    EXTRACT(
        MONTH FROM
        CASE      
            WHEN SPLIT_PART("Order Date", '-', 1)::INT > 12 THEN
                TO_DATE("Order Date", 'DD-MM-YYYY')
                
            ELSE
                TO_DATE("Order Date", 'MM-DD-YYYY')       
        END
    ) AS month,
   round(SUM("Sales"::NUMERIC), 2)  AS total_sales
FROM sales
GROUP BY month
ORDER BY total_sales DESC;

-- 10. Is profit increasing or decreasing over time?

SELECT 
    TO_CHAR(
        TO_DATE("Order Date", 'DD-MM-YYYY'),
        'Mon YYYY'
    ) AS month,
    ROUND(SUM("Profit")::numeric, 2) AS total_profit
FROM sales
GROUP BY month
ORDER BY MIN(
    TO_DATE("Order Date", 'DD-MM-YYYY')
) desc;

-- 11. Which customer segment is most profitable?

select "Segment",
round(sum("Profit"::NUMERIC), 2) as total_profit
from sales
group by "Segment"
order by total_profit desc;

-- 12. Which customers purchase repeatedly?

select "Customer Name",
count("Order ID") as total_order
from sales
group by "Customer Name"
order by total_order desc;

--13. Does high discount increase sales?

SELECT "Discount",
    ROUND(SUM("Sales")::numeric, 2) AS total_sales
FROM sales
GROUP BY "Discount"
ORDER BY "Discount" desc;

-- 14. Which shipping mode is most profitable?

select "Ship Mode",
round(sum("Profit"::Numeric), 2) as total_profit
from sales
group by "Ship Mode"
order by total_profit desc;

--15. What is profit and discount percentage ?

--PROFIT MARGIN PERCENTAGE

select round(sum("Profit"::NUMERIC)/sum("Sales"::NUMERIC) * 100,
			2
			) as profit_margin_percentage
from sales	

--DISCOUNT PERCENTAGE

select round(avg("Discount"):: NUMERIC * 100,
			2
			) as avg_discount_percentage
from sales

--16. What is the profit by region ?

SELECT "Region",
		ROUND(
        (
           SUM("Profit"::numeric)/SUM("Sales"::numeric)) * 100,
        2
    ) AS profit_margin_percentage

FROM sales
GROUP BY "Region"
ORDER BY profit_margin_percentage DESC;

-- 17. Find the total number of orders?

select count(*) as total_orders
from sales;

-- 18. Find top 5 product by sales?

select "Product Name",
round(sum("Sales"::NUMERIC), 2) as total_sales
from sales
group by "Product Name"
order by total_sales desc
limit 5;

-- 19. Find top 5 customer by profit?

select "Customer Name",
round(sum("Sales"::NUMERIC), 2) as total_sales
from sales
group by "Customer Name"
order by total_sales desc
limit 5;

-- 20. Which custome segment has highest Sales?

select "Segment", 
round(sum("Sales"::NUMERIC), 2) as total_sales
from sales
group by "Segment" 
order by total_sales desc;