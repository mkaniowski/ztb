SELECT 'Akademia Górniczo-Hutnicza',
       ST_Area(ST_Transform(geom, 2180)) / 1000000 as area_km2
FROM osm1.natural_nodes
WHERE tags -> 'name' = 'Akademia Górniczo-Hutnicza'
  AND tags -> 'type' = 'multipolygon';

-- 0.2274403394920485

SELECT 'Miasteczko Studenckie AGH',
       ST_Area(ST_Transform(geom, 2180)) / 1000000 as area_km2
FROM osm1.natural_nodes
WHERE tags -> 'landuse' = 'residential'
  AND tags -> 'type' = 'multipolygon';

-- 0.09199785804697332