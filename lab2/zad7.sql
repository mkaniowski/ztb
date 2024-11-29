WITH building_c2 AS (SELECT geom                     AS geom_wgs84,
                            ST_Transform(geom, 2180) AS geom_2180
                     FROM osm1.natural_nodes
                     WHERE (tags -> 'ref' = 'C-2')
                     LIMIT 1),
     pubs AS (SELECT osm_id,
                     tags -> 'name'           AS pub_name,
                     geom                     AS geom_wgs84,
                     ST_Transform(geom, 2180) AS geom_2180
              FROM osm1.natural_nodes
              WHERE tags -> 'amenity' = 'pub'
                AND geom IS NOT NULL)
SELECT pubs.osm_id,
       pubs.pub_name,
       ST_Distance(pubs.geom_2180, building_c2.geom_2180) AS distance,
       ST_AsGeoJSON(pubs.geom_wgs84)::jsonb               AS geom
FROM pubs,
     building_c2
WHERE ST_DWithin(pubs.geom_2180, building_c2.geom_2180, 1000)
ORDER BY distance ASC;