// 1
MATCH (b:Building)
  WHERE NOT (b)-[:NEIGHBOUR]-(:Building)
RETURN b //12

// 2
MATCH (b:Service)
RETURN count(b) AS numberOfServiceBuildings //6

// 3
MATCH (a:Building { name: 'A-1' })-[r:NEIGHBOUR]->(b:Building)
RETURN b.name AS neighbouringBuilding, r.floor AS floor
//"H-A1"
//[1]

//"A-2"
//[1]

//"A-0"
//[1]

//"C-1"
//[1]


// 4
MATCH p=shortestPath((start:Building {name: 'U-2'})-[:NEIGHBOUR]-(end:Building {name: 'B-2'}))
RETURN p // No results

// 5
MATCH p=shortestPath((start:Building {name: 'C-3'})-[*]-(end:Building {name: 'A-0'}))
RETURN p

//╒══════════════════════════════════════════════════════════════════════╕
//│p                                                                     │
//╞══════════════════════════════════════════════════════════════════════╡
//│(:Building:ResearchTeaching {name: "C-3"})<-[:ENTERS]-(:Entrance {floo│
//│r: [0],building: "C-3"})<-[:NEIGHBOR]-(:Entrance {floor: [0],building:│
//│ "A-0"})-[:ENTERS]->(:Building:Service {name: "A-0"})                 │
//└──────────────────────────────────────────────────────────────────────┘

// 6
MATCH (b:Building)-[:NEIGHBOUR]->()
WITH b, count(*) AS neighborCount
  WHERE neighborCount = 3
RETURN b // B-2