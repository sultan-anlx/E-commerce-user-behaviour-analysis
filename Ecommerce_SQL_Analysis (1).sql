CREATE TABLE customer_data (
    user_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    device_type VARCHAR(20),
    time_on_site DECIMAL(6,2),
    pages_viewed INT,
    previous_purchases INT,
    cart_items INT,
    discount_seen INT,
    ad_clicked INT,
    returning_user INT,
    avg_session_time DECIMAL(6,2),
    bounce_rate DECIMAL(5,2),
    purchase INT
);

 CREATE TABLE customer_data_raw (
    user_id TEXT,
    age TEXT,
    gender TEXT,
    device_type TEXT,
    time_on_site TEXT,
    pages_viewed TEXT,
    previous_purchases TEXT,
    cart_items TEXT,
    discount_seen TEXT,
    ad_clicked TEXT,
    returning_user TEXT,
    avg_session_time TEXT,
    bounce_rate TEXT,
    purchase TEXT
);

DROP TABLE IF EXISTS customer_data;

CREATE TABLE customer_data (
    user_id INT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    device_type VARCHAR(20),
    time_on_site DECIMAL(6,2),
    pages_viewed INT,
    previous_purchases INT,
    cart_items INT,
    discount_seen INT,
    ad_clicked INT,
    returning_user INT,
    avg_session_time DECIMAL(6,2),
    bounce_rate DECIMAL(6,2),
    purchase INT
);
  INSERT INTO customer_data_raw (
    user_id,
    age,
    gender,
    device_type,
    time_on_site,
    pages_viewed,
    previous_purchases,
    cart_items,
    discount_seen,
    ad_clicked,
    returning_user,
    avg_session_time,
    bounce_rate,
    purchase
)
SELECT
    -- USER ID (must be valid integer)
NULLIF(user_id, '')::NUMERIC::INT,

-- AGE (MEDIAN IMPUTATION)
COALESCE(
    NULLIF(age, '')::NUMERIC::INT,
    (SELECT PERCENTILE_CONT(0.5)
     WITHIN GROUP (ORDER BY NULLIF(age, '')::NUMERIC))
)::INT,

-- CATEGORICAL CLEANING (NO FAKE NUMBERS)
NULLIF(gender, ''),
NULLIF(device_type, ''),

-- BEHAVIORAL METRICS (SAFE NUMERIC CONVERSION)
COALESCE(NULLIF(time_on_site, '')::NUMERIC, 0)::NUMERIC(10,2),
COALESCE(NULLIF(pages_viewed, '')::NUMERIC, 0)::INT,

COALESCE(NULLIF(previous_purchases, '')::NUMERIC, 0)::INT,
COALESCE(NULLIF(cart_items, '')::NUMERIC, 0)::INT,
COALESCE(NULLIF(discount_seen, '')::NUMERIC, 0)::INT,
COALESCE(NULLIF(ad_clicked, '')::NUMERIC, 0)::INT,
COALESCE(NULLIF(returning_user, '')::NUMERIC, 0)::INT,

COALESCE(NULLIF(avg_session_time, '')::NUMERIC, 0)::NUMERIC(10,2),
COALESCE(NULLIF(bounce_rate, '')::NUMERIC, 0)::NUMERIC(10,2),

-- TARGET VARIABLE
COALESCE(NULLIF(purchase, '')::NUMERIC, 0)::INT

FROM customer_data_raw
WHERE NULLIF(user_id, '') IS NOT NULL;

SELECT COUNT(*) 
FROM customer_data_raw;

SELECT COUNT(*) FROM customer_data;

SELECT * 
FROM customer_data_raw
LIMIT 10;

-- TOTAL USERS --
SELECT COUNT(*) AS total_users
FROM customer_data_raw
WHERE NULLIF(user_id,'') IS NOT NULL;

-- Purchasers vs Non-purchasers --

SELECT
    COALESCE(NULLIF(purchase,'')::NUMERIC::INT,0) AS purchase,
    COUNT(*) AS total_users
FROM customer_data_raw
GROUP BY COALESCE(NULLIF(purchase,'')::NUMERIC::INT,0);

-- Gender distribution --

SELECT
    NULLIF(gender,'') AS gender,
    COUNT(*) AS total_users
FROM customer_data_raw
GROUP BY NULLIF(gender,'')
ORDER BY total_users DESC;

-- Returning VS New users distribution --

SELECT
    COALESCE(NULLIF(returning_user,'')::NUMERIC::INT,0) AS returning_user,
    COUNT(*) AS total_users
FROM customer_data_raw
GROUP BY COALESCE(NULLIF(returning_user,'')::NUMERIC::INT,0);


 -- age count --
SELECT
    MIN(NULLIF(age,'')::NUMERIC) AS lowest_age,
    MAX(NULLIF(age,'')::NUMERIC) AS highest_age
FROM customer_data_raw;

-- Conversion by Age -- 

WITH segmented AS (
    SELECT
        CASE
            WHEN NULLIF(age,'')::NUMERIC <= 31 THEN '18–31'
            WHEN NULLIF(age,'')::NUMERIC <= 45 THEN '32–45'
            ELSE '46–59'
        END AS age_group,

        COALESCE(NULLIF(purchase,'')::NUMERIC,0) AS purchase

    FROM customer_data_raw
    WHERE NULLIF(age,'') IS NOT NULL
)

SELECT
    age_group,

    COUNT(*) AS total_users,

    ROUND(
        SUM(purchase)::NUMERIC / COUNT(*) * 100,
        2
    ) AS conversion_rate_pct,

    ROUND(
        COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER () * 100,
        2
    ) AS share_of_total_users_pct

FROM segmented
GROUP BY age_group
ORDER BY age_group; 

-- gender cleaning - 
SELECT
    CASE
        WHEN LOWER(TRIM(gender)) IN ('male') THEN 'Male'
        WHEN LOWER(TRIM(gender)) IN ('female') THEN 'Female'
    END AS gender,

    COUNT(*) AS total_users
FROM customer_data_raw
WHERE gender IS NOT NULL
  AND TRIM(gender) <> ''
GROUP BY
    CASE
        WHEN LOWER(TRIM(gender)) IN ('male') THEN 'Male'
        WHEN LOWER(TRIM(gender)) IN ('female') THEN 'Female'
    END;
	
 -- Conversion by age -- 
 select 
    CASE
        WHEN LOWER(TRIM(gender)) = 'male' THEN 'Male'
        WHEN LOWER(TRIM(gender)) = 'female' THEN 'Female'
    END AS gender,

    COUNT(*) AS total_users,

    ROUND(
        COUNT(*)::NUMERIC
        / SUM(COUNT(*)) OVER () * 100,
        2
    ) AS percentage_of_total_users

FROM customer_data_raw
WHERE LOWER(TRIM(gender)) IN ('male','female')
GROUP BY
    CASE
        WHEN LOWER(TRIM(gender)) = 'male' THEN 'Male'
        WHEN LOWER(TRIM(gender)) = 'female' THEN 'Female'
    END;


-- returning vs new customers -- 
SELECT
    CASE
        WHEN COALESCE(NULLIF(returning_user,'')::NUMERIC,0) = 1 THEN 'Returning Users'
        ELSE 'New Users'
    END AS user_type,

    COUNT(*) AS total_users,

    ROUND(
        COUNT(*)::NUMERIC
        / SUM(COUNT(*)) OVER () * 100,
        2
    ) AS percentage_of_total_users

FROM customer_data_raw
GROUP BY
    CASE
        WHEN COALESCE(NULLIF(returning_user,'')::NUMERIC,0) = 1 THEN 'Returning Users'
        ELSE 'New Users'
    END;

	-- Behavioral drivers of purchase --

 SELECT
    COALESCE(NULLIF(purchase,'')::NUMERIC,0) AS purchase_group,

    ROUND(AVG(NULLIF(time_on_site,'')::NUMERIC), 2) AS avg_time_spent,
    ROUND(AVG(NULLIF(pages_viewed,'')::NUMERIC), 2) AS avg_pages_viewed,
    ROUND(AVG(NULLIF(bounce_rate,'')::NUMERIC), 2) AS avg_bounce_rate

FROM customer_data_raw
GROUP BY COALESCE(NULLIF(purchase,'')::NUMERIC,0)
ORDER BY purchase_group

  -- Ads Clicked vs Not Clicked -- 

 SELECT
    CASE
        WHEN COALESCE(NULLIF(ad_clicked,'')::NUMERIC,0) = 1 THEN 'Ads Clicked'
        ELSE 'No Ads Clicked'
    END AS ad_group,

    COUNT(*) AS total_users,

    ROUND(
        COUNT(*)::NUMERIC
        / SUM(COUNT(*)) OVER () * 100,
        2
    ) AS percentage_of_total_users

FROM customer_data_raw
GROUP BY
    CASE
        WHEN COALESCE(NULLIF(ad_clicked,'')::NUMERIC,0) = 1 THEN 'Ads Clicked'
		  ELSE 'No Ads Clicked'
    END;

	-- discount seen --

	SELECT
    CASE
        WHEN COALESCE(NULLIF(discount_seen,'')::NUMERIC,0) = 1 THEN 'Discount Seen'
        ELSE 'No Discount Seen'
    END AS discount_group,

    COUNT(*) AS total_users,

    ROUND(
        COUNT(*)::NUMERIC
        / SUM(COUNT(*)) OVER () * 100,
        2
    ) AS percentage_of_total_users

FROM customer_data_raw
GROUP BY
    CASE
        WHEN COALESCE(NULLIF(discount_seen,'')::NUMERIC,0) = 1 THEN 'Discount Seen'
        ELSE 'No Discount Seen'
    END;

	-- FUNNEL ANALYSIS --
	WITH base AS (
    SELECT
        user_id,

        -- clean purchase properly
        CASE
            WHEN NULLIF(purchase,'')::NUMERIC = 1 THEN 1
            ELSE 0
        END AS purchase_clean,

        COALESCE(NULLIF(time_on_site,'')::NUMERIC,0) AS time_on_site,
        COALESCE(NULLIF(bounce_rate,'')::NUMERIC,0) AS bounce_rate,
        COALESCE(NULLIF(cart_items,'')::NUMERIC,0) AS cart_items

    FROM customer_data_raw
),

stage1 AS (
    SELECT * FROM base
),

stage2 AS (
    SELECT * FROM stage1
    WHERE bounce_rate < 50 OR time_on_site > 3
),

stage3 AS (
    SELECT * FROM stage2
    WHERE cart_items > 0
),

stage4 AS (
    SELECT * FROM stage3
    WHERE purchase_clean = 1
)

SELECT
    (SELECT COUNT(*) FROM stage1) AS total_users,
    (SELECT COUNT(*) FROM stage2) AS engaged_users,
    (SELECT COUNT(*) FROM stage3) AS cart_users,
    (SELECT COUNT(*) FROM stage4) AS purchasers;