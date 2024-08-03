# OLIST STORE ANALYSIS (PROJECT 01 - E-COMMERCE ANALYTICS)

use olist_store_analysis;

# KPI 1 :- 'Week Day Vs Week End (order_purchase_timestamp) Payment Statistics'

select case when weekday(order_purchase_timestamp) in (5,6) then "WeekEnd" 
else "WeekDay" end as "Week_Day_End", concat(round((sum(payments.payment_value)/1000000),2), " M") as TotalPayment from olist_orders_dataset6 as orders 
inner join olist_order_payments_dataset4 as payments
on orders.order_id = payments.order_id group by Week_Day_End;

# KPI 2 :- 'Number of Orders with review score 5 and payment type as credit card'

select count(*) as "Orders Count" from olist_order_payments_dataset4 inner join olist_order_reviews_dataset5 on olist_order_payments_dataset4.order_id = olist_order_reviews_dataset5.order_id 
where payment_type = "credit_card" and review_score = 5;

# KPI 3 :- 'Average number of days taken for order_delivered_customer_date for pet_shop'

select round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)),0) as "Avg. Delivery Days" from olist_orders_dataset6 
inner join olist_order_items_dataset3 on olist_orders_dataset6.order_id = olist_order_items_dataset3.order_id
inner join olist_products_dataset7 on olist_order_items_dataset3.product_id = olist_products_dataset7.product_id 
where olist_products_dataset7.product_category_name = "pet_shop";

# KPI 4 :- 'Average price and payment values from customers of sao paulo city'

select round(avg(olist_order_items_dataset3.price),2) as "Avg Price", round(avg(olist_order_payments_dataset4.payment_value),2) as "Avg Payment"
from olist_order_items_dataset3 inner join olist_orders_dataset6 on olist_order_items_dataset3.order_id = olist_orders_dataset6.order_id
inner join olist_order_payments_dataset4 on olist_orders_dataset6.order_id = olist_order_payments_dataset4.order_id inner join olist_customers_dataset1
on olist_orders_dataset6.customer_id = olist_customers_dataset1.customer_id where olist_customers_dataset1.customer_city = "sao paulo";

# KPI 5 :- 'Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores'

select olist_order_reviews_dataset5.review_score as "Review Score", 
round(avg(datediff(olist_orders_dataset6.order_delivered_customer_date,olist_orders_dataset6.order_purchase_timestamp)),0) as "Avg Shipping Days"
from olist_orders_dataset6 inner join olist_order_reviews_dataset5 on
olist_orders_dataset6.order_id = olist_order_reviews_dataset5.order_id group by olist_order_reviews_dataset5.review_score order by olist_order_reviews_dataset5.review_score;