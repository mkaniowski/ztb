CREATE (room315:Room {number: '315', name: 'Sala 315'})
CREATE (room210:Room {number: '210', name: 'Sala 210'})
CREATE (room215:Room {number: '215', name: 'Sala 215'})

MATCH (c2:Building {name: 'C-2'}), (room315:Room {number: '315'})
CREATE (room315)-[:LOCATED_IN]->(c2)

MATCH (b5:Building {name: 'C-2'}), (room210:Room {number: '210'})
CREATE (room210)-[:LOCATED_IN]->(b5)

MATCH (c3:Building {name: 'C-3'}), (room215:Room {number: '215'})
CREATE (room215)-[:LOCATED_IN]->(c3)