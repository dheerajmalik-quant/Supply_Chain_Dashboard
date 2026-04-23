SELECT 
    order_status,
    COUNT(order_id) AS total_orders,
    COUNT(order_delivered_customer_date) AS orders_with_delivery_date,
    COUNT(order_id) - COUNT(order_delivered_customer_date) AS missing_delivery_dates
FROM public.olist_orders_dataset
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT 
order_status,
COUNT(order_id) AS total_orders,
COUNT(order_delivered_customer_date) AS orders_with_delivery_date,
COUNT(order_id) - COUNT(order_delivered_customer_date) AS missing_delivery_dates
FROM olist_orders_dataset ood 
GROUP BY order_status 
ORDER BY total_orders DESC;

