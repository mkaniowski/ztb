CREATE TABLE cities
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255)          NOT NULL,
    geom GEOMETRY(POINT, 4326) NOT NULL
);


INSERT INTO cities (name, geom)
VALUES ('Kraków', ST_SetSRID(ST_GeomFromText('POINT(19.938333 50.061389)'), 4326)),
       ('Warszawa', ST_SetSRID(ST_GeomFromText('POINT(21.0122287 52.2296756)'), 4326));

-- 2.419652610235209

SELECT c1.name                                                               AS city1,
       c2.name                                                               AS city2,
       ST_Distance(ST_Transform(c1.geom, 2180), ST_Transform(c2.geom, 2180)) AS distance_default
FROM cities c1,
     cities c2
WHERE c1.name = 'Kraków' AND c2.name = 'Warszawa';

-- 252507.901553961



SELECT c1.name                             AS city1,
       c2.name                             AS city2,
       ST_DistanceSphere(c1.geom, c2.geom) AS distance_sphere_meters
FROM cities c1,
     cities c2
WHERE c1.name = 'Kraków' AND c2.name = 'Warszawa';

-- 252464.97257319

