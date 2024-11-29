# ZTB - indeksy
### Michał Kaniowski - 405505


## Indeksy oparte o haszowanie
```postgresql
SELECT * FROM zamowienia WHERE idkompozycji = 'buk1';
```

Przed indeksowaniem:
```postgresql
Seq Scan on zamowienia  (cost=0.00..167.19 rows=424 width=52) (actual time=0.013..0.759 rows=424 loops=1)
Filter: (idkompozycji = 'buk1'::bpchar)
Rows Removed by Filter: 7591
Planning Time: 0.057 ms
Execution Time: 0.784 ms
```
---
```postgresql
CREATE INDEX zamowienia_idkompozycji_hash ON zamowienia USING hash(idkompozycji);
```

Po indeksowaniu:
```postgresql
Bitmap Heap Scan on zamowienia  (cost=15.29..87.59 rows=424 width=52) (actual time=0.044..0.204 rows=424 loops=1)
  Recheck Cond: (idkompozycji = 'buk1'::bpchar)
  Heap Blocks: exact=67
  ->  Bitmap Index Scan on zamowienia_idkompozycji_hash  (cost=0.00..15.18 rows=424 width=0) (actual time=0.029..0.029 rows=424 loops=1)
        Index Cond: (idkompozycji = 'buk1'::bpchar)
Planning Time: 1.256 ms
Execution Time: 0.244 ms
```

```postgresql
DROP INDEX zamowienia_idkompozycji_hash;
```

## Indeksy oparte o b-drzewa

```postgresql
CREATE INDEX zamowienia_idkompozycji_btree ON zamowienia(idkompozycji);
```

```postgresql
SELECT * FROM zamowienia WHERE idkompozycji < 'c';
```

```postgresql
Bitmap Heap Scan on zamowienia  (cost=27.39..118.77 rows=1950 width=52) (actual time=0.541..0.816 rows=1950 loops=1)
  Recheck Cond: (idkompozycji < 'c'::bpchar)
  Heap Blocks: exact=67
  ->  Bitmap Index Scan on zamowienia_idkompozycji_btree  (cost=0.00..26.91 rows=1950 width=0) (actual time=0.525..0.525 rows=1950 loops=1)
        Index Cond: (idkompozycji < 'c'::bpchar)
Planning Time: 2.205 ms
Execution Time: 0.880 ms

```

---

```postgresql
SELECT * FROM zamowienia WHERE idkompozycji >= 'c';
```

```postgresql
Seq Scan on zamowienia  (cost=0.00..167.19 rows=6065 width=52) (actual time=0.011..1.134 rows=6065 loops=1)
  Filter: (idkompozycji >= 'c'::bpchar)
  Rows Removed by Filter: 1950
Planning Time: 0.098 ms
Execution Time: 1.297 ms

```

---

```postgresql
SET enable_seqscan TO off;
```

przed c:
```postgresql
Bitmap Heap Scan on zamowienia  (cost=27.39..118.77 rows=1950 width=52) (actual time=0.058..0.338 rows=1950 loops=1)
  Recheck Cond: (idkompozycji < 'c'::bpchar)
  Heap Blocks: exact=67
  ->  Bitmap Index Scan on zamowienia_idkompozycji_btree  (cost=0.00..26.91 rows=1950 width=0) (actual time=0.045..0.045 rows=1950 loops=1)
        Index Cond: (idkompozycji < 'c'::bpchar)
Planning Time: 0.055 ms
Execution Time: 0.401 ms
```

c i po:
```postgresql
Bitmap Heap Scan on zamowienia  (cost=75.29..218.10 rows=6065 width=52) (actual time=1.429..1.922 rows=6065 loops=1)
  Recheck Cond: (idkompozycji >= 'c'::bpchar)
  Heap Blocks: exact=67
  ->  Bitmap Index Scan on zamowienia_idkompozycji_btree  (cost=0.00..73.77 rows=6065 width=0) (actual time=1.407..1.407 rows=6065 loops=1)
        Index Cond: (idkompozycji >= 'c'::bpchar)
Planning Time: 0.081 ms
Execution Time: 2.104 ms
```

```postgresql
DROP INDEX zamowienia_idkompozycji_btree;
```

## Indeksy a wzorce

```postgresql
CREATE INDEX zamowienia_uwagi_idx ON zamowienia(uwagi);
```

```postgresql
SELECT * FROM zamowienia WHERE uwagi LIKE 'do%';
```

```postgresql
Seq Scan on zamowienia  (cost=10000000000.00..10000000167.19 rows=11 width=52) (actual time=333.533..333.850 rows=11 loops=1)
  Filter: ((uwagi)::text ~~ 'do%'::text)
  Rows Removed by Filter: 8004
Planning Time: 3.461 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 2.629 ms (Deform 0.957 ms), Inlining 191.875 ms, Optimization 63.500 ms, Emission 78.130 ms, Total 336.134 ms"
Execution Time: 833.447 ms
```

```postgresql
DROP INDEX zamowienia_uwagi_idx;
```

---

```postgresql
CREATE INDEX zamowienia_uwagi_pattern_idx ON zamowienia(uwagi varchar_pattern_ops);
```

```postgresql
SELECT * FROM zamowienia WHERE uwagi LIKE 'do%';
```

```postgresql
Bitmap Heap Scan on zamowienia  (cost=4.40..35.16 rows=11 width=52) (actual time=0.443..0.446 rows=11 loops=1)
  Filter: ((uwagi)::text ~~ 'do%'::text)
  Heap Blocks: exact=1
  ->  Bitmap Index Scan on zamowienia_uwagi_pattern_idx  (cost=0.00..4.39 rows=11 width=0) (actual time=0.432..0.432 rows=11 loops=1)
        Index Cond: (((uwagi)::text ~>=~ 'do'::text) AND ((uwagi)::text ~<~ 'dp'::text))
Planning Time: 1.808 ms
Execution Time: 0.484 ms
```

```postgresql
DROP INDEX zamowienia_uwagi_pattern_idx;
```

## Indeksy wielokolumnowe

```postgresql
CREATE INDEX zamowienia_multicol_idx ON zamowienia(idklienta, idodbiorcy, idkompozycji);
```

```postgresql
SELECT * FROM zamowienia WHERE idklienta = 'wartosc1' AND idodbiorcy = 1 AND idkompozycji = '1';
```

```postgresql
Index Scan using zamowienia_multicol_idx on zamowienia  (cost=0.28..8.30 rows=1 width=52) (actual time=0.018..0.018 rows=0 loops=1)
  Index Cond: (((idklienta)::text = 'wartosc1'::text) AND (idodbiorcy = 1) AND (idkompozycji = '1'::bpchar))
Planning Time: 0.067 ms
Execution Time: 0.032 ms
```

---

```postgresql
SELECT * FROM zamowienia WHERE idklienta = 'wartosc1' OR idodbiorcy = 1 OR idkompozycji = '1';
```

```postgresql
Bitmap Heap Scan on zamowienia  (cost=437.30..509.32 rows=287 width=52) (actual time=9.573..9.672 rows=287 loops=1)
  Recheck Cond: (((idklienta)::text = 'wartosc1'::text) OR (idodbiorcy = 1) OR (idkompozycji = '1'::bpchar))
  Heap Blocks: exact=66
  ->  BitmapOr  (cost=437.30..437.30 rows=287 width=0) (actual time=9.553..9.553 rows=0 loops=1)
        ->  Bitmap Index Scan on zamowienia_multicol_idx  (cost=0.00..4.29 rows=1 width=0) (actual time=0.407..0.407 rows=0 loops=1)
              Index Cond: ((idklienta)::text = 'wartosc1'::text)
        ->  Bitmap Index Scan on zamowienia_multicol_idx  (cost=0.00..216.40 rows=287 width=0) (actual time=8.732..8.732 rows=287 loops=1)
              Index Cond: (idodbiorcy = 1)
        ->  Bitmap Index Scan on zamowienia_multicol_idx  (cost=0.00..216.40 rows=1 width=0) (actual time=0.412..0.412 rows=0 loops=1)
              Index Cond: (idkompozycji = '1'::bpchar)
Planning Time: 0.117 ms
Execution Time: 9.710 ms
```

---

```postgresql
SELECT * FROM zamowienia WHERE idkompozycji = 'buk1';
```

```postgresql
Bitmap Heap Scan on zamowienia  (cost=216.50..288.80 rows=424 width=52) (actual time=0.462..0.577 rows=424 loops=1)
  Recheck Cond: (idkompozycji = 'buk1'::bpchar)
  Heap Blocks: exact=67
  ->  Bitmap Index Scan on zamowienia_multicol_idx  (cost=0.00..216.40 rows=424 width=0) (actual time=0.447..0.448 rows=424 loops=1)
        Index Cond: (idkompozycji = 'buk1'::bpchar)
Planning Time: 0.105 ms
Execution Time: 0.611 ms
```

---

```postgresql
DROP INDEX zamowienia_multicol_idx;
```

```postgresql
CREATE INDEX zamowienia_idklienta_idx ON zamowienia(idklienta);
CREATE INDEX zamowienia_idodbiorcy_idx ON zamowienia(idodbiorcy);
CREATE INDEX zamowienia_idkompozycji_idx ON zamowienia(idkompozycji);
```

```postgresql
SELECT * FROM zamowienia WHERE idklienta = 'wartosc1' AND idodbiorcy = 1 AND idkompozycji = '1';
```

```postgresql
Index Scan using zamowienia_idkompozycji_idx on zamowienia  (cost=0.28..8.31 rows=1 width=52) (actual time=0.312..0.312 rows=0 loops=1)
  Index Cond: (idkompozycji = '1'::bpchar)
  Filter: (((idklienta)::text = 'wartosc1'::text) AND (idodbiorcy = 1))
Planning Time: 2.895 ms
Execution Time: 0.325 ms
```


```postgresql
SELECT * FROM zamowienia WHERE idklienta = 'wartosc1' OR idodbiorcy = 1 OR idkompozycji = '1';
```

```postgresql
Bitmap Heap Scan on zamowienia  (cost=15.23..87.25 rows=287 width=52) (actual time=0.876..0.988 rows=287 loops=1)
  Recheck Cond: (((idklienta)::text = 'wartosc1'::text) OR (idodbiorcy = 1) OR (idkompozycji = '1'::bpchar))
  Heap Blocks: exact=66
  ->  BitmapOr  (cost=15.23..15.23 rows=287 width=0) (actual time=0.861..0.862 rows=0 loops=1)
        ->  Bitmap Index Scan on zamowienia_idklienta_idx  (cost=0.00..4.29 rows=1 width=0) (actual time=0.498..0.499 rows=0 loops=1)
              Index Cond: ((idklienta)::text = 'wartosc1'::text)
        ->  Bitmap Index Scan on zamowienia_idodbiorcy_idx  (cost=0.00..6.43 rows=287 width=0) (actual time=0.354..0.354 rows=287 loops=1)
              Index Cond: (idodbiorcy = 1)
        ->  Bitmap Index Scan on zamowienia_idkompozycji_idx  (cost=0.00..4.29 rows=1 width=0) (actual time=0.007..0.007 rows=0 loops=1)
              Index Cond: (idkompozycji = '1'::bpchar)
Planning Time: 0.072 ms
Execution Time: 1.053 ms
```

```postgresql
SELECT * FROM zamowienia WHERE idkompozycji = 'buk1';
```

```postgresql
Bitmap Heap Scan on zamowienia  (cost=7.57..79.87 rows=424 width=52) (actual time=0.038..0.158 rows=424 loops=1)
  Recheck Cond: (idkompozycji = 'buk1'::bpchar)
  Heap Blocks: exact=67
  ->  Bitmap Index Scan on zamowienia_idkompozycji_idx  (cost=0.00..7.46 rows=424 width=0) (actual time=0.025..0.026 rows=424 loops=1)
        Index Cond: (idkompozycji = 'buk1'::bpchar)
Planning Time: 0.070 ms
Execution Time: 0.185 ms
```

## Indeksy a sortowanie

```postgresql
SELECT * FROM zamowienia ORDER BY idkompozycji;
```

```postgresql
Index Scan using zamowienia_idkompozycji_idx on zamowienia  (cost=0.28..424.02 rows=8015 width=52) (actual time=0.428..3.338 rows=8015 loops=1)
Planning Time: 3.493 ms
Execution Time: 3.577 ms
```

```postgresql
DROP INDEX zamowienia_idkompozycji_idx;
```

```postgresql
Sort  (cost=10000000666.86..10000000686.90 rows=8015 width=52) (actual time=2.960..3.261 rows=8015 loops=1)
  Sort Key: idkompozycji
  Sort Method: quicksort  Memory: 631kB
  ->  Seq Scan on zamowienia  (cost=10000000000.00..10000000147.15 rows=8015 width=52) (actual time=0.005..0.383 rows=8015 loops=1)
Planning Time: 0.510 ms
Execution Time: 3.479 ms
```

```postgresql
DROP INDEX zamowienia_idklienta_idx;
DROP INDEX zamowienia_idodbiorcy_idx;
```

## Indeksy częściowe

```postgresql
CREATE INDEX zamowienia_zaplacone_idx ON zamowienia(idklienta) WHERE zaplacone = true;
```

```postgresql
SELECT * FROM zamowienia WHERE idklienta = 'wartosc' AND zaplacone = true;
```

```postgresql
Index Scan using zamowienia_zaplacone_idx on zamowienia  (cost=0.28..8.30 rows=1 width=52) (actual time=0.393..0.394 rows=0 loops=1)
  Index Cond: ((idklienta)::text = 'wartosc'::text)
Planning Time: 1.542 ms
Execution Time: 0.414 ms
```

---

```postgresql
SELECT * FROM zamowienia WHERE zaplacone = false;
```

```postgresql
Seq Scan on zamowienia  (cost=10000000000.00..10000000147.15 rows=7 width=52) (actual time=29.248..29.594 rows=7 loops=1)
  Filter: (NOT zaplacone)
  Rows Removed by Filter: 8008
Planning Time: 0.044 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.202 ms (Deform 0.111 ms), Inlining 1.605 ms, Optimization 17.768 ms, Emission 9.856 ms, Total 29.431 ms"
Execution Time: 29.839 ms
```

---

```postgresql
SELECT SUM(cena) FROM zamowienia WHERE zaplacone = false;
```

```postgresql
Aggregate  (cost=10000000147.17..10000000147.18 rows=1 width=32) (actual time=72.535..72.536 rows=1 loops=1)
  ->  Seq Scan on zamowienia  (cost=10000000000.00..10000000147.15 rows=7 width=5) (actual time=72.081..72.400 rows=7 loops=1)
        Filter: (NOT zaplacone)
        Rows Removed by Filter: 8008
Planning Time: 0.108 ms
JIT:
  Functions: 5
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.344 ms (Deform 0.181 ms), Inlining 15.430 ms, Optimization 35.157 ms, Emission 21.491 ms, Total 72.421 ms"
Execution Time: 72.930 ms
```

```postgresql
DROP INDEX zamowienia_zaplacone_idx;
```

## Indeksy a wyrażenia

```postgresql
CREATE INDEX klienci_miasto_idx ON klienci(LOWER(miasto));
```

```postgresql
SELECT * FROM klienci WHERE LOWER(miasto) LIKE 'krak%';
```

```postgresql
Seq Scan on klienci  (cost=10000000000.00..10000000001.75 rows=1 width=692) (actual time=39.303..39.325 rows=23 loops=1)
  Filter: (lower((miasto)::text) ~~ 'krak%'::text)
  Rows Removed by Filter: 27
Planning Time: 1.441 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.219 ms (Deform 0.078 ms), Inlining 10.453 ms, Optimization 18.156 ms, Emission 10.654 ms, Total 39.483 ms"
Execution Time: 39.589 ms
```

```postgresql
DROP INDEX klienci_miasto_idx;
```

## Indeksy GiST

```postgresql
ALTER TABLE zamowienia ADD COLUMN lokalizacja point;
UPDATE zamowienia SET lokalizacja=point(random()*100, random()*100);
```

```postgresql
SELECT *
FROM zamowienia
WHERE sqrt(power(lokalizacja[0] - 50, 2) + power(lokalizacja[1] - 50, 2)) <= 10;
```

```postgresql
Seq Scan on zamowienia  (cost=10000000000.00..10000000378.41 rows=2672 width=68) (actual time=57.433..58.874 rows=268 loops=1)
"  Filter: (sqrt((power((lokalizacja[0] - '50'::double precision), '2'::double precision) + power((lokalizacja[1] - '50'::double precision), '2'::double precision))) <= '10'::double precision)"
  Rows Removed by Filter: 7747
Planning Time: 0.687 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.393 ms (Deform 0.136 ms), Inlining 4.139 ms, Optimization 31.728 ms, Emission 21.506 ms, Total 57.766 ms"
Execution Time: 59.324 ms
```

```postgresql
SELECT * FROM zamowienia WHERE lokalizacja[0] <= 50 AND lokalizacja[1] >= 50;
```


```postgresql
Seq Scan on zamowienia  (cost=10000000000.00..10000000278.23 rows=891 width=68) (actual time=43.772..44.503 rows=1986 loops=1)
  Filter: ((lokalizacja[0] <= '50'::double precision) AND (lokalizacja[1] >= '50'::double precision))
  Rows Removed by Filter: 6029
Planning Time: 0.056 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.270 ms (Deform 0.127 ms), Inlining 2.673 ms, Optimization 26.233 ms, Emission 14.817 ms, Total 43.992 ms"
Execution Time: 44.878 ms
```

---

```postgresql
CREATE INDEX zamowienia_lokalizacja_gist_idx ON zamowienia USING GiST(lokalizacja);
```

```postgresql
SELECT *
FROM zamowienia
WHERE sqrt(power(lokalizacja[0] - 50, 2) + power(lokalizacja[1] - 50, 2)) <= 10;
```

```postgresql
Seq Scan on zamowienia  (cost=10000000000.00..10000000378.41 rows=2672 width=68) (actual time=57.924..59.296 rows=268 loops=1)
"  Filter: (sqrt((power((lokalizacja[0] - '50'::double precision), '2'::double precision) + power((lokalizacja[1] - '50'::double precision), '2'::double precision))) <= '10'::double precision)"
  Rows Removed by Filter: 7747
Planning Time: 0.085 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.323 ms (Deform 0.154 ms), Inlining 4.895 ms, Optimization 32.921 ms, Emission 20.041 ms, Total 58.181 ms"
Execution Time: 59.673 ms
```

```postgresql
SELECT * FROM zamowienia WHERE lokalizacja[0] <= 50 AND lokalizacja[1] >= 50;
```

```postgresql
Seq Scan on zamowienia  (cost=10000000000.00..10000000278.23 rows=891 width=68) (actual time=42.704..43.400 rows=1986 loops=1)
  Filter: ((lokalizacja[0] <= '50'::double precision) AND (lokalizacja[1] >= '50'::double precision))
  Rows Removed by Filter: 6029
Planning Time: 0.061 ms
JIT:
  Functions: 2
"  Options: Inlining true, Optimization true, Expressions true, Deforming true"
"  Timing: Generation 0.349 ms (Deform 0.165 ms), Inlining 2.426 ms, Optimization 25.582 ms, Emission 14.647 ms, Total 43.004 ms"
Execution Time: 43.854 ms
```