WITH cleaned_deliveries AS (
    SELECT 
        order_id,
        customer_id,
        CAST(order_purchase_timestamp AS TIMESTAMP) AS purchase_date,
        CAST(order_estimated_delivery_date AS TIMESTAMP) AS estimated_delivery_date,
        CAST(order_delivered_customer_date AS TIMESTAMP) AS actual_delivery_date
    FROM public.olist_orders_dataset
    WHERE order_status = 'delivered' 
    AND order_delivered_customer_date IS NOT NULL
)
SELECT 
    order_id,
    purchase_date,
    estimated_delivery_date,
    actual_delivery_date,
    (CAST(actual_delivery_date AS DATE) - CAST(estimated_delivery_date AS DATE)) AS days_difference,
    CASE 
        WHEN CAST(actual_delivery_date AS DATE) > CAST(estimated_delivery_date AS DATE) THEN 'Late'
        ELSE 'On Time'
    END AS sla_status
FROM cleaned_deliveries
ORDER BY days_difference DESC;