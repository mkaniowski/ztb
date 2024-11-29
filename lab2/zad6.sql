WITH agh_miasteczko AS (SELECT 'Miasteczko Studenckie AGH' AS area_name, geom
                        FROM osm1.natural_nodes
                        WHERE tags -> 'landuse' = 'residential'
                          AND tags -> 'type' = 'multipolygon'
                        LIMIT 1),
     agh AS (SELECT 'Akademia Górniczo-Hutnicza' AS area_name, geom
             FROM osm1.natural_nodes
             WHERE tags -> 'name' = 'Akademia Górniczo-Hutnicza'
               AND tags -> 'type' = 'multipolygon'
             LIMIT 1),
     areas AS (SELECT *
               FROM agh_miasteczko
               UNION ALL
               SELECT *
               FROM agh),
     objects AS (SELECT osm_id,
                        tags -> 'name' AS object_name,
                        CASE
                            WHEN tags -> 'amenity' IN ('pub', 'bar') THEN 'pub'
                            WHEN tags -> 'amenity' IN ('toilets', 'toilet', 'wc', 'restroom', 'public_bathroom')
                                THEN 'toilets'
                            END        AS object_type,
                        geom
                 FROM osm1.natural_nodes
                 WHERE tags -> 'amenity' IN ('pub', 'bar', 'toilets', 'toilet', 'wc', 'restroom', 'public_bathroom')
                 UNION ALL
                 SELECT osm_id,
                        tags -> 'name' AS object_name,
                        'toilets'      AS object_type,
                        geom
                 FROM osm1.natural_nodes
                 WHERE tags ? 'toilets'
                   AND tags -> 'toilets' IN ('yes', 'public', 'designated'))
SELECT areas.area_name,
       objects.object_type,
       COALESCE(objects.object_name, '') AS object_name
FROM areas
         JOIN objects ON ST_Intersects(areas.geom, objects.geom)
ORDER BY areas.area_name,
         objects.object_type,
         objects.object_name;