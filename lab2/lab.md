# PostGIS i OSM
### Michał Kaniowski

---

## Zad 1

```postgresql
CREATE TABLE cities
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255)          NOT NULL,
    geom GEOMETRY(POINT, 4326) NOT NULL
);


INSERT INTO cities (name, geom)
VALUES ('Kraków', ST_SetSRID(ST_GeomFromText('POINT(19.938333 50.061389)'), 4326)),
       ('Warszawa', ST_SetSRID(ST_GeomFromText('POINT(21.0122287 52.2296756)'), 4326));
```
2.419652610235209 stopni


```postgresql
SELECT c1.name                                                               AS city1,
       c2.name                                                               AS city2,
       ST_Distance(ST_Transform(c1.geom, 2180), ST_Transform(c2.geom, 2180)) AS distance_default
FROM cities c1,
     cities c2
WHERE c1.name = 'Kraków' AND c2.name = 'Warszawa';
```
252507.901553961m dokadniejszy


```postgresql
SELECT c1.name                             AS city1,
       c2.name                             AS city2,
       ST_DistanceSphere(c1.geom, c2.geom) AS distance_sphere_meters
FROM cities c1,
     cities c2
WHERE c1.name = 'Kraków' AND c2.name = 'Warszawa';
```
252464.97257319m szybki


---

## Zad 2

```postgresql
ALTER TABLE cities
    ADD COLUMN geography_geom GEOGRAPHY(POINT, 4326);

UPDATE cities SET geography_geom = geom::GEOGRAPHY;


SELECT c1.name                                           AS city1,
       c2.name                                           AS city2,
       ST_Distance(c1.geography_geom, c2.geography_geom) AS distance_geography_meters
FROM cities c1,
     cities c2
WHERE c1.name = 'Kraków' AND c2.name = 'Warszawa';
```

252651.02830741m

Typ **GEOGRAPHY** jest szczególnie przydatny do obliczeń na dużych dystansach i globalnych danych.

Typ **GEOMETRY** po transformacji do lokalnych układów współrzędnych lepiej sprawdza się przy precyzyjnych pomiarach na mniejszych obszarach.

---

## Zad 3

amenity: pub, bar, toilets, toilet, wc, restroom, public_bathroom, university

landuse: residential

---


## Zad 5

```postgresql
SELECT 'Akademia Górniczo-Hutnicza',
       ST_Area(ST_Transform(geom, 2180)) / 1000000 as area_km2
FROM osm1.natural_nodes
WHERE tags -> 'name' = 'Akademia Górniczo-Hutnicza'
  AND tags -> 'type' = 'multipolygon';
```

0.2274403394920485 km^2

```postgresql
SELECT 'Miasteczko Studenckie AGH',
       ST_Area(ST_Transform(geom, 2180)) / 1000000 as area_km2
FROM osm1.natural_nodes
WHERE tags -> 'landuse' = 'residential'
  AND tags -> 'type' = 'multipolygon';
```

0.09199785804697332 km^2

---

## Zad 6


```postgresql
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
```

| area\_name | object\_type | object\_name |
| :--- | :--- | :--- |
| Akademia Górniczo-Hutnicza | pub | Karlik |
| Akademia Górniczo-Hutnicza | pub | Klub Gwarek |
| Miasteczko Studenckie AGH | pub | Klub Filutek |
| Miasteczko Studenckie AGH | pub | Klub Zaścianek |
| Miasteczko Studenckie AGH | toilets | Klub Filutek |
| Miasteczko Studenckie AGH | toilets | Klub Zaścianek |
| Miasteczko Studenckie AGH | toilets |  |

---

## Zad 7

```postgresql
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
```

| osm\_id | pub\_name | distance | geom |
| :--- | :--- | :--- | :--- |
| 6129326981 | null | 421.23059055455536 | {"type": "Point", "coordinates": \[19.9276836, 50.0682616\]} |
| 2351408882 | Klub Gwarek | 444.08671996210654 | {"type": "Point", "coordinates": \[19.9156931, 50.0658476\]} |
| 6148239779 | Whisky Bar Egon | 487.93913217230806 | {"type": "Point", "coordinates": \[19.9183065, 50.0698287\]} |
| 8757494572 | Cosmic Games Pub | 505.2485320272777 | {"type": "Point", "coordinates": \[19.9301169, 50.0662208\]} |
| 2351408470 | Karlik | 529.2612405779865 | {"type": "Point", "coordinates": \[19.9145004, 50.066086\]} |
| 9894718217 | Świat Piwa. Beer Shop & Bistro | 561.1560203414374 | {"type": "Point", "coordinates": \[19.9307407, 50.0648292\]} |
| 752177457 | Garage Pub | 706.2266803413332 | {"type": "Point", "coordinates": \[19.9263137, 50.0597683\]} |
| 7049970185 | Klub Buda | 743.0218483523246 | {"type": "Point", "coordinates": \[19.930108, 50.0608793\]} |
| 3288623107 | Zaginiony Świat | 765.0430554204668 | {"type": "Point", "coordinates": \[19.933319, 50.0678625\]} |
| 279040195 | Stary Port | 804.4231640419548 | {"type": "Point", "coordinates": \[19.9318205, 50.0612594\]} |
