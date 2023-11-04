// Neo4j - Query Language (Cypher)
MATCH (p:Person { name:"Homer Flinstone" })
RETURN p

// Neo4j - Create a Node using Cypher
CREATE (a:Artist { Name : "Strapping Young Lad" })

CREATE (b:Album { Name : "Heavy as a Really Heavy Thing", Released : "1995" })
RETURN b

CREATE (a:Album { Name: "Killers"}), (b:Album { Name: "Fear of the Dark"})
RETURN a,b

CREATE (a:Album { Name: "Piece of Mind"})
CREATE (b:Album { Name: "Somewhere in Time"})
RETURN a,b

// Neo4j - Create a Relationship using Cypher
MATCH (a:Artist),(b:Album)
WHERE a.Name = "Strapping Young Lad" AND b.Name = "Heavy as a Really Heavy Thing"
CREATE (a)-[r:RELEASED]->(b)
RETURN r

CREATE (p:Person { Name: "Devin Townsend" })

MATCH (a:Artist),(b:Album),(p:Person)
WHERE a.Name = "Strapping Young Lad" AND b.Name = "Heavy as a Really Heavy Thing" AND p.Name = "Devin Townsend"
CREATE (p)-[pr:PRODUCED]->(b), (p)-[pf:PERFORMED_ON]->(b), (p)-[pl:PLAYS_IN]->(a)
RETURN a,b,p

// Neo4j - Create an Index using Cypher
CREATE INDEX // Different from the tutorial
FOR (a:Album)
ON (a.Name)

:schema

MATCH (a:Album {Name: "Somewhere in Time"})
USING INDEX a:Album(Name)
RETURN a

// Neo4j - Create a Constraint using Cypher

CREATE CONSTRAINT FOR (a:Artist)
REQUIRE a.Name IS UNIQUE

:schema

CREATE (a:Artist {Name: "Joe Satriani"})
RETURN a

CREATE (a:Artist {Name: "Joe Satriani"})
RETURN a

CREATE CONSTRAINT FOR (a:Artist) REQUIRE a.Name IS NOT NULL // different from the tutorial (enterprise edition)

// Neo4j - Selecting data with MATCH using Cypher
MATCH (p:Person)
WHERE p.Name = "Devin Townsend"
RETURN p

MATCH (p:Person {Name: "Devin Townsend"})
RETURN p

MATCH (a:Artist)-[:RELEASED]->(b:Album)
WHERE b.Name = "Heavy as a Really Heavy Thing"
RETURN a

MATCH (n) RETURN n

MATCH (n) RETURN n
LIMIT 5

// Neo4j - Import Data from a CSV File using Cypher
LOAD CSV FROM 'https://www.quackit.com/neo4j/tutorial/genres.csv' AS line
CREATE (:Genre { GenreId: line[0], Name: line[1]})

MATCH (n:Genre) RETURN n

LOAD CSV WITH HEADERS FROM 'https://www.quackit.com/neo4j/tutorial/tracks.csv' AS line
CREATE (:Track { TrackId: line.Id, Name: line.Track, Length: line.Length})

MATCH (n:Track) RETURN n

LOAD CSV WITH HEADERS FROM 'https://www.quackit.com/neo4j/tutorial/tracks.csv' AS line FIELDTERMINATOR ';'
CREATE (:Track { TrackId: line.Id, Name: line.Track, Length: line.Length})

CALL { // different from the tutorial
    LOAD CSV WITH HEADERS FROM 'https://www.quackit.com/neo4j/tutorial/tracks.csv' AS line
    CREATE (:Track { TrackId: line.Id, Name: line.Track, Length: line.Length})
}

:auto CALL {
    LOAD CSV WITH HEADERS FROM 'https://www.quackit.com/neo4j/tutorial/tracks.csv' AS line
    CREATE (:Track { TrackId: line.Id, Name: line.Track, Length: line.Length})
}
IN TRANSACTIONS OF 800 ROWS

// Neo4j - Drop an Index using Cypher
DROP INDEX index_67e06f58 // different from the tutorial

:schema

// Neo4j - Drop a Constraint using Cypher
DROP CONSTRAINT constraint_bb37e9f5 // different from the tutorial

:schema

// Neo4j - Delete a Node using Cypher
MATCH (a:Album {Name: "Killers"}) DELETE a

MATCH (a:Artist {Name: "Iron Maiden"}), (b:Album {Name: "Powerslave"}) // no record
DELETE a, b

MATCH (n) DELETE n

// Neo4j - Delete a Relationship using Cypher
MATCH ()-[r:RELEASED]-()
DELETE r

MATCH (a:Artist),(b:Album) // recover the previously deleted relationship
WHERE a.Name = "Strapping Young Lad" AND b.Name = "Heavy as a Really Heavy Thing"
CREATE (a)-[r:RELEASED]->(b)
RETURN r

MATCH (:Artist)-[r:RELEASED]-(:Album)
DELETE r

MATCH (a:Artist),(b:Album) // recover the previously deleted relationship
WHERE a.Name = "Strapping Young Lad" AND b.Name = "Heavy as a Really Heavy Thing"
CREATE (a)-[r:RELEASED]->(b)
RETURN r

MATCH (:Artist {Name: "Strapping Young Lad"})-[r:RELEASED]-(:Album {Name: "Heavy as a Really Heavy Thing"})
DELETE r

MATCH (a:Artist),(b:Album) // recover the previously deleted relationship
WHERE a.Name = "Strapping Young Lad" AND b.Name = "Heavy as a Really Heavy Thing"
CREATE (a)-[r:RELEASED]->(b)
RETURN r

MATCH (a:Artist {Name: "Strapping Young Lad"}) DETACH DELETE a

MATCH (n) DETACH DELETE n
