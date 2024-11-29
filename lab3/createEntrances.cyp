UNWIND [
  'S-1', 'S-2', 'D-1', 'U-2', 'A-4', 'A-3', 'C-4', 'C-3', 'C-2', 'U-1', 'H-A2', 'H-A1', 'A-2', 'A-1', 'C-1', 'A-0',
  'B-1', 'B-2', 'B-3', 'B-4', 'H-B3B4', 'H-B1B2'] AS buildingName
MATCH (b:Building {name: buildingName})
CREATE (:Entrance {building: buildingName, floor: [0]})-[:ENTERS]->(b)


MATCH (e1:Entrance), (e2:Entrance)
  WHERE id(e1) < id(e2)
CREATE (e1)-[:NEIGHBOR]->(e2)
CREATE (e2)-[:NEIGHBOR]->(e1)

MATCH (e1:Entrance)-[r:NEIGHBOR]->(e2:Entrance)
DELETE r