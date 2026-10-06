USE customer_sales_intelligence;
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS sales_month,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_order_value), 2) AS total_revenue,
    ROUND(AVG(total_order_value), 2) AS average_order_value
FROM order_analytics
WHERE total_order_value IS NOT NULL
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY sales_month;

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS sales_month,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_order_value), 2) AS total_revenue,
    ROUND(AVG(total_order_value), 2) AS average_order_value
FROM order_analytics
WHERE total_order_value IS NOT NULL
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY total_revenue DESC
LIMIT 5;

-- Query 3: Top 10 Customers by Revenue

SELECT
    customer_unique_id,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_order_value), 2) AS total_spend,
    ROUND(AVG(total_order_value), 2) AS average_order_value
FROM order_analytics
WHERE total_order_value IS NOT NULL
GROUP BY customer_unique_id
ORDER BY total_spend DESC
LIMIT 10;

-- Query 4: State-wise Sales Performance

SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_unique_id) AS unique_customers,
    ROUND(SUM(total_order_value), 2) AS total_revenue,
    ROUND(AVG(total_order_value), 2) AS average_order_value
FROM order_analytics
WHERE total_order_value IS NOT NULL
GROUP BY customer_state
ORDER BY total_revenue DESC;


-- Query 5: Delivery Performance

SELECT
    COUNT(*) AS delivered_orders,
    SUM(CASE WHEN late_delivery = 1 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(
        100.0 * SUM(CASE WHEN late_delivery = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS late_delivery_rate,
    ROUND(AVG(delivery_days), 2) AS average_delivery_days,
    ROUND(AVG(delivery_delay_days), 2) AS average_delay_days
FROM order_analytics
WHERE order_delivered_customer_date IS NOT NULL;

-- Query 6: Repeat Customer Analysis

SELECT
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS customer_percentage,
    ROUND(AVG(total_spend), 2) AS average_customer_spend
FROM customer_analytics
GROUP BY
    CASE
        WHEN total_orders = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END
ORDER BY customer_count DESC;

-- Query 7: Review Score by Delivery Performance

SELECT
    CASE
        WHEN late_delivery = 1 THEN 'Late Delivery'
        WHEN late_delivery = 0 THEN 'On-Time Delivery'
        ELSE 'Unknown'
    END AS delivery_status,
    COUNT(*) AS order_count,
    ROUND(AVG(review_score), 2) AS average_review_score
FROM order_analytics
WHERE review_score IS NOT NULL
GROUP BY
    CASE
        WHEN late_delivery = 1 THEN 'Late Delivery'
        WHEN late_delivery = 0 THEN 'On-Time Delivery'
        ELSE 'Unknown'
    END
ORDER BY average_review_score DESC;

-- Query 8: Payment and Installment Analysis

SELECT
    max_installments,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_payment_value), 2) AS total_payment_value,
    ROUND(AVG(total_payment_value), 2) AS average_payment_value
FROM order_analytics
WHERE total_payment_value IS NOT NULL
GROUP BY max_installments
ORDER BY total_orders DESC;


-- Query 9: Order Status Analysis

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS order_percentage,
    ROUND(AVG(total_order_value), 2) AS average_order_value
FROM order_analytics
GROUP BY order_status
ORDER BY total_orders DESC;

-- Query 10: High-Value Customers

SELECT
    customer_unique_id,
    total_orders,
    ROUND(total_spend, 2) AS total_spend,
    ROUND(avg_order_value, 2) AS average_order_value,
    recency_days,
    repeat_customer
FROM customer_analytics
WHERE total_orders > 1
ORDER BY total_spend DESC
LIMIT 20;

-- Query 11: Customer Recency and Spending Segments

SELECT
    CASE
        WHEN recency_days <= 90 THEN 'Recent Customer'
        WHEN recency_days <= 180 THEN 'Active Customer'
        WHEN recency_days <= 365 THEN 'At-Risk Customer'
        ELSE 'Inactive Customer'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spend), 2) AS average_spend,
    ROUND(AVG(total_orders), 2) AS average_orders,
    ROUND(AVG(recency_days), 2) AS average_recency_days
FROM customer_analytics
GROUP BY
    CASE
        WHEN recency_days <= 90 THEN 'Recent Customer'
        WHEN recency_days <= 180 THEN 'Active Customer'
        WHEN recency_days <= 365 THEN 'At-Risk Customer'
        ELSE 'Inactive Customer'
    END
ORDER BY average_recency_days;



-- Query 12: Final Business KPI Summary

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_unique_id) AS total_customers,
    ROUND(SUM(total_order_value), 2) AS total_revenue,
    ROUND(AVG(total_order_value), 2) AS average_order_value,
    ROUND(AVG(review_score), 2) AS average_review_score,
    ROUND(AVG(delivery_days), 2) AS average_delivery_days,
    SUM(CASE WHEN late_delivery = 1 THEN 1 ELSE 0 END) AS late_orders,
    ROUND(
        100.0 * SUM(CASE WHEN late_delivery = 1 THEN 1 ELSE 0 END)
        / NULLIF(
            COUNT(CASE WHEN order_delivered_customer_date IS NOT NULL THEN 1 END),
            0
        ),
        2
    ) AS late_delivery_rate
FROM order_analytics
WHERE total_order_value IS NOT NULL;