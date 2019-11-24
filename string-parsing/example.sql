-- String Parsing Examples

-- Parse the attributes column and select products that contain the 'waterproof' attribute
SELECT id, name
FROM product p
WHERE 'waterproof' IN (SELECT unnest(regexp_split_to_array(attributes, ',')) AS attrs
                       FROM product
                       WHERE id = p.id);
