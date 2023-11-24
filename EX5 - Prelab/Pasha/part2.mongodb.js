// use retrogames
game1 =
{
    name: "Invaders 2013",
    release_date: new Date(2013, 03, 02),
    categories: ["space", "shooter", "remake"],
    played: false
}
db.games.insertOne(game1);

db.games.find()

db.games.find().limit(100)

db.games.findOne({ name: "Invaders 2013" })

player1 =
{
    name: "PUZZLEGAMESMASTER",
    gender: "male",
    scores: [
        {
            game_id: new ObjectId("65605c4b428a4f025bdadc47"),
            game_name: "Invaders 2013",
            score: 10500,
            score_date: new Date(2013, 03, 02)
        }
    ]
}
db.players.insertOne(player1)

db.games.updateOne(
    { _id: ObjectId("65605c4b428a4f025bdadc47") },
    { $set: { played: true } }
)

db.players.update(
    { _id: new ObjectId("65605fe8428a4f025bdadc49") },
    {
        $push: {
            scores: {
                game_id: new ObjectId("51e10c50085977bc3cd92a65"),
                game_name: "Invaders 2013",
                score: 30250,
                score_date: new Date(2013, 03, 03)
            }
        }
    }
)
db.players.findOne()
