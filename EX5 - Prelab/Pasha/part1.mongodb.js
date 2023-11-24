// insert -> insertOne
db.grades.insertOne({
    student_id: 546799,
    scores: [
        {
            type: "quiz",
            score: 50
        },
        {
            type: "homework",
            score: 70
        }
    ]
})

// insert -> insertMany
db.grades.insertMany([
    {
        student_id: 546789,
        scores: [
            {
                type: "quiz",
                score: 50
            },
            {
                type: "homework",
                score: 70
            }
        ],
        class_id: 551
    },
    {
        student_id: 777777,
        scores: [
            {
                type: "quiz",
                score: 72
            },
        ],
        class_id: 550
    },
    {
        student_id: 223344,
        scores: [
            {
                type: "exam",
                score: 45
            },
        ],
        class_id: 551
    }
])

// find -> find
db.zips.find()

// find -> $eq operator
db.zips.find({ state: "AZ" })

// find -> $in operator
db.zips.find({ city: { $in: ["PHOENIX", "CHICAGO"] } })

// find -> findOne
db.zips.findOne()

// find -> $gt operator
db.sales.find({ "items.price": { $gt: 50 } })

// find -> array elements
db.accounts.find({ "products": "InvestmentStock" })
db.accounts.find({ products: { $elemMatch: { $eq: "InvestmentStock" } } })
db.sales.find({
    items: {
        $elemMatch: { name: "laptop", price: { $gt: 800 }, quantity: { $gte: 1 } }
    }
})

// logical operators -> $and
db.routes.find({
    $and: [{ "airline.name": "Southwest Airlines" }, { "stops": { $gte: 1 } }]
})
db.routes.find({
    "airline.name": "Southwest Airlines", "stops": { $gte: 1 }
})

// logical operators -> $or
db.routes.find({
    $or: [{ "dst_airport": "SEA" }, { "src_airport": "SEA" }]
})

// logical operators -> mixed
db.routes.find({
    $and: [
        { $or: [{ "dst_airport": "SEA" }, { "src_airport": "SEA" }] },
        { $or: [{ "airline.name": "American Airlines" }, { airplane: 320 }] }
    ]
})

// replace -> replaceOne()
db.comments.replaceOne(
    { _id: ObjectId("5a9427648b0beebeb69579e7") },
    {
        name: 'Mercedes Tyler',
        email: 'mercedes_tyler@fakegmail.com',
        movie_id: ObjectId("573a1390f29313caabcd4323"),
        text: 'Test',
        date: ISODate("2002-08-18T04:56:07.000Z")
    }
)
db.comments.findOne({ _id: ObjectId("5a9427648b0beebeb69579e7") })

// update -> updateOne
db.grades.updateOne(
    { _id: ObjectId("56d5f7eb604eb380b0d8d8ce") },
    { $set: { "final": 67.6 } }
)
db.grades.findOne({ _id: ObjectId("56d5f7eb604eb380b0d8d8ce") })

// update -> upsert
db.grades.updateOne(
    { student_id: 20000 },
    { $set: { "final": 88 } },
    { upsert: true }
)

// update -> $push
db.grades.updateOne(
    { student_id: 20000 },
    { $push: { "scores": { "type": "extra credit", "score": 100 } } }
)
db.grades.findOne({ student_id: 20000 })

// update -> findAndModify
db.grades.findAndModify({
    query: { student_id: 20000 },
    update: { $set: { "final": 100 } },
    new: true
})

// update -> updateMany
db.companies.updateMany(
    { number_of_employees: { $gt: 1000 } },
    { $set: { "big": true } }
)

// delete -> deleteOne
db.zips.find({ zip: "35014" })
db.zips.deleteOne({ _id: ObjectId("5c8eccc1caa187d17ca6ed16") })

// delete -> deleteMany
db.zips.deleteMany({ pop: 6055 })

// modify results -> sort
db.companies.find({ category_code: "music" }).sort({ name: 1 })
db.companies.find({ category_code: "music" }, { name: 1 }).sort({ name: 1 })

// modify results -> limit
db.companies.find({ category_code: "music" }).sort({ number_of_employees: -1 }).limit(3)
db.companies.find({ category_code: "music" }, { name: 1, number_of_employees: 1 }).sort({ number_of_employees: -1 }).limit(3)

// modify results -> projection (inclusion)
db.inspections.find({ sector: "Restaurant - 818" }, { business_name: 1, result: 1 })
db.inspections.find({ sector: "Restaurant - 818" }, { business_name: 1, result: 1, _id: 0 })

// modify results -> projection (exclusion)
db.inspections.find({ result: { $in: ["Pass", "Warning"] } }, { date: 0, "address.zip": 0 })

// modify results -> count
db.trips.countDocuments()
db.trips.countDocuments({ tripduration: { $gt: 120 }, usertype: "Subscriber" })

// aggregation -> match
db.zips.aggregate([
    {
        $match: { state: "CA" }
    }
])

// aggregation -> group
db.zips.aggregate([
    {
        $match: { state: "CA" }
    },
    {
        $group: {
            _id: "$city",
            totalZips: { $count: {} }
        }
    }
])

// aggregation -> sort
db.zips.aggregate([
    {
        $sort: {
            pop: -1
        }
    }
])

// aggregation -> limit
db.zips.aggregate([
    {
        $sort: {
            pop: -1
        }
    },
    {
        $limit: 3
    }
])

// aggregation -> project
db.zips.aggregate([
    {
        $project: {
            state: 1,
            zip: 1,
            population: "$pop",
            _id: 0
        }
    }
])

// aggregation -> set
db.zips.aggregate([
    {
        $set: {
            pop_2022: {
                $round: { $multiply: [1.0031, "$pop"] }
            }
        }
    }
])

// aggregation -> count
db.zips.aggregate([
    {
        $count: 'total_zips'
    }
])

// aggregate -> out
db.zips.aggregate([
    {
        $group: {
            _id: "$state",
            total_pop: { $sum: "$pop" }
        }
    },
    {
        $match: {
            total_pop: { $lt: 1000000 }
        }
    },
    {
        $out: "small_states"
    }
])
