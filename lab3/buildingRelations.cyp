MATCH (b1:Building {name: 'B-1'}), (b2:Building {name: 'B-2'})
CREATE (b1)-[:NEIGHBOUR {floor: [-1]}]->(b2),
       (b2)-[:NEIGHBOUR {floor: [-1]}]->(b1)

MATCH (b2:Building {name: 'B-2'}), (b3:Building {name: 'B-3'})
CREATE (b2)-[:NEIGHBOUR {floor: [-1]}]->(b3),
       (b3)-[:NEIGHBOUR {floor: [-1]}]->(b2)

MATCH (b3:Building {name: 'B-3'}), (b4:Building {name: 'B-4'})
CREATE (b3)-[:NEIGHBOUR {floor: [-1]}]->(b4),
       (b4)-[:NEIGHBOUR {floor: [-1]}]->(b3)

MATCH (c1:Building {name: 'C-1'}), (c2:Building {name: 'C-2'})
CREATE (c1)-[:NEIGHBOUR {floor: [-1, 0, 1, 2, 3, 4]}]->(c2),
       (c2)-[:NEIGHBOUR {floor: [-1, 0, 1, 2, 3, 4]}]->(c1)

MATCH (c2:Building {name: 'C-2'}), (c3:Building {name: 'C-3'})
CREATE (c2)-[:NEIGHBOUR {floor: [0, 1, 2, 3, 4, 5]}]->(c3),
       (c3)-[:NEIGHBOUR {floor: [0, 1, 2, 3, 4, 5]}]->(c2)

MATCH (c1:Building {name: 'C-1'}), (a1:Building {name: 'A-1'})
CREATE (c1)-[:NEIGHBOUR {floor: [1]}]->(a1),
       (a1)-[:NEIGHBOUR {floor: [1]}]->(c1)

MATCH (a1:Building {name: 'A-1'}), (a0:Building {name: 'A-0'})
CREATE (a1)-[:NEIGHBOUR {floor: [1]}]->(a0),
       (a0)-[:NEIGHBOUR {floor: [1]}]->(a1)

MATCH (hb1b2:Building {name: 'H-B1B2'}), (b1:Building {name: 'B-1'})
CREATE (hb1b2)-[:NEIGHBOUR {floor: [0, 1]}]->(b1),
       (b1)-[:NEIGHBOUR {floor: [0, 1]}]->(hb1b2)

MATCH (hb1b2:Building {name: 'H-B1B2'}), (b2:Building {name: 'B-2'})
CREATE (hb1b2)-[:NEIGHBOUR {floor: [0, 1]}]->(b2),
       (b2)-[:NEIGHBOUR {floor: [0, 1]}]->(hb1b2)

MATCH (a1:Building {name: 'A-1'}), (ha1:Building {name: 'H-A1'})
CREATE (a1)-[:NEIGHBOUR {floor: [1]}]->(ha1),
       (ha1)-[:NEIGHBOUR {floor: [1]}]->(a1)

MATCH (a1:Building {name: 'A-1'}), (a2:Building {name: 'A-2'})
CREATE (a1)-[:NEIGHBOUR {floor: [1]}]->(a2),
       (a2)-[:NEIGHBOUR {floor: [1]}]->(a1)

MATCH (a2:Building {name: 'A-2'}), (ha2:Building {name: 'H-A2'})
CREATE (a2)-[:NEIGHBOUR {floor: [1]}]->(ha2),
       (ha2)-[:NEIGHBOUR {floor: [1]}]->(a2)

MATCH (ha1:Building {name: 'H-A1'}), (ha2:Building {name: 'H-A2'})
CREATE (ha1)-[:NEIGHBOUR {floor: [1]}]->(ha2),
       (ha2)-[:NEIGHBOUR {floor: [1]}]->(ha1)