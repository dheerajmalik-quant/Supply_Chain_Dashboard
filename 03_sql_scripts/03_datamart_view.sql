CREATE OR REPLACE VIEW public.vw_supply_chain_datamart AS
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
    cd.order_id,
    cd.purchase_date,
    cd.estimated_delivery_date,
    cd.actual_delivery_date,
    (CAST(cd.actual_delivery_date AS DATE) - CAST(cd.estimated_delivery_date AS DATE)) AS days_difference,
    CASE 
        WHEN CAST(cd.actual_delivery_date AS DATE) > CAST(cd.estimated_delivery_date AS DATE) THEN 'Late'
        ELSE 'On Time'
    END AS sla_status,
    oi.product_id,
    oi.seller_id,
    CAST(oi.price AS NUMERIC(10,2)) AS product_price,
    CAST(oi.freight_value AS NUMERIC(10,2)) AS freight_cost,
    p.product_category_name,
    s.seller_state,
    CAST(r.review_score AS INTEGER) AS customer_review_score
FROM cleaned_deliveries cd
LEFT JOIN public.olist_order_items_dataset oi ON cd.order_id = oi.order_id
LEFT JOIN public.olist_products_dataset p ON oi.product_id = p.product_id
LEFT JOIN public.olist_sellers_dataset s ON oi.seller_id = s.seller_id
LEFT JOIN public.olist_order_reviews_dataset r ON cd.order_id = r.order_id;