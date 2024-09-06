CREATE OR REPLACE FUNCTION calculate_similarity(
    ad1_title TEXT, ad1_price BIGINT, ad1_category_id BIGINT,
    user_id BIGINT
)
RETURNS DOUBLE PRECISION AS $$
DECLARE
    similarity_score DOUBLE PRECISION := 0;
    ad2_title TEXT;
    ad2_price BIGINT;
    ad2_category_id BIGINT;
    title_similarity DOUBLE PRECISION;
    price_similarity DOUBLE PRECISION;
    category_similarity DOUBLE PRECISION;
    r RECORD;
BEGIN
    FOR r IN
        SELECT
            a.title AS ad2_title,
            a.price AS ad2_price,
            a.category_id AS ad2_category_id
        FROM favorites f
        JOIN ads a ON f.ad_id = a.id
        WHERE f.user_id = user_id
    LOOP
        ad2_title := r.ad2_title;
        ad2_price := r.ad2_price;
        ad2_category_id := r.ad2_category_id;

        title_similarity := (
            SELECT COUNT(*)::DOUBLE PRECISION
            FROM (
                SELECT unnest(string_to_array(ad1_title, ' ')) AS word
            ) AS words1
            JOIN (
                SELECT unnest(string_to_array(ad2_title, ' ')) AS word
            ) AS words2
            ON words1.word = words2.word
        ) / (
            (SELECT COUNT(*) FROM unnest(string_to_array(ad1_title, ' '))) +
            (SELECT COUNT(*) FROM unnest(string_to_array(ad2_title, ' '))) -
            (
                SELECT COUNT(*) FROM (
                    SELECT unnest(string_to_array(ad1_title, ' ')) AS word
                ) AS words1
                JOIN (
                    SELECT unnest(string_to_array(ad2_title, ' ')) AS word
                ) AS words2
                ON words1.word = words2.word
            )
        );

        price_similarity := 1.0 - abs(ad1_price - ad2_price) / greatest(ad1_price, ad2_price);

        category_similarity := CASE
            WHEN ad1_category_id = ad2_category_id THEN 1.0
            ELSE 0.0
        END;

        similarity_score := similarity_score +
            (title_similarity * 3) +
            price_similarity +
            category_similarity;
    END LOOP;

    RETURN similarity_score;
END;
$$ LANGUAGE plpgsql;