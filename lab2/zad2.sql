ALTER TABLE cities
    ADD COLUMN geography_geom GEOGRAPHY(POINT, 4326);

UPDATE cities SET geography_geom = geom::GEOGRAPHY;


SELECT c1.name                                           AS city1,
       c2.name                                           AS city2,
       ST_Distance(c1.geography_geom, c2.geography_geom) AS distance_geography_meters
FROM cities c1,
     cities c2
WHERE c1.name = 'Kraków' AND c2.name = 'Warszawa';

-- 252651.02830741