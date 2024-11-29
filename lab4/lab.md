# ZTB
## lab 4
### Michał Kaniowski

---

### Zadanie 1

T1:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT vacation_days FROM employees WHERE id = 2;
```

Baza zwróciła wartość 10.

T2:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE employees SET vacation_days = 15 WHERE id = 2;

COMMIT;
```

T1:
```postgresql
SELECT vacation_days FROM employees WHERE id = 2;

COMMIT;
```

Baza zwróciła wartość 15.

---

### Zadanie 2

T1:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT vacation_days FROM employees WHERE id = 2 FOR UPDATE;
```

T2:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

UPDATE employees SET vacation_days = 12 WHERE id = 2;

COMMIT;
```

Operacja jest zablokowana i czeka na zakończenie transakcji T1.

T1:
```postgresql
COMMIT;
```

Po zakończniu transakcji T1, T2 zostaje zakończona.

---

### Zadanie 3

T1, T2:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

T1:
```postgresql
SELECT vacation_days FROM employees WHERE id = 2;
```

Baza zwróciła wartość 10.

T2:
```postgresql
UPDATE employees SET vacation_days = 15 WHERE id = 2;
COMMIT;
```

T1:
```postgresql
SELECT vacation_days FROM employees WHERE id = 2;
COMMIT;
```

Baza zwróciła wartość 10 (niezmieniony, ponieważ T1 nie widzi zmian wykonanych przez T2)

---

### Zadanie 4

T1, T2:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

T1:
```postgresql
UPDATE employees SET vacation_days = vacation_days + 5 WHERE id = 1;
```

T2:
```postgresql
SELECT vacation_days FROM employees WHERE id = 1;
UPDATE employees SET vacation_days = vacation_days + 10 WHERE id = 1;
```

T1, T2:
```postgresql
COMMIT;
```

Podczas zatwierdzania T2 baza zgłasza błąd serializacji - ([40001] ERROR: could not serialize access due to concurrent update)

T1 i T2 modyfikują te same dane w sposób, który uniemożliwia ustalenie serializowalności.

Błąd serializacji wynika z konfliktu między transakcjami, który uniemożliwia silnikowi bazy danych uporządkowanie operacji w sposób zgodny z izolacją transakcji.

---

### Zadanie 5

T1, T2:
```postgresql
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

T1:
```postgresql
SELECT * FROM employees WHERE id = 2 FOR UPDATE;
```

T2:
```postgresql
UPDATE employees SET vacation_days = vacation_days + 5 WHERE id = 2;
```

T1, T2:
```postgresql
COMMIT;
```

Blokady na poziomie rekordu zmuszają drugą transakcję do oczekiwania na zwolnienie blokady.

W przypadku równoczesnych prób blokady tego samego rekordu może wystąpić błąd serializacji, jeśli transakcje nie mogą zostać uporządkowane w sposób zgodny z izolacją.

---

### Zadanie 6


| Run  | Transactions | No transactions |
|------|--------------|-----------------|
| 1    | 40,2092908   | 88,056154       |
| 2    | 40,0282167   | 83,8640949      |
| 3    | 39,4586472   | 84,9477979      |
| avg: | 39,9         | 85,62           |


Skrypt bez transakcji: Każde polecenie INSERT działa jako oddzielna transakcja.

Skrypt z transakcjami: Grupowanie operacji w jedną transakcję.

