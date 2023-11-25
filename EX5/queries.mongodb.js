// use Misasha

db.flights.countDocuments()

// main queries

// Q1
db.flights.find({ DestCityName: "San Francisco" })

// Q2
db.flights.countDocuments({ OriginAirportID: "NA01" })

// Q3
db.flights.aggregate([
    {
        $addFields: {
            "DistanceKilometersFloat": {
                $toDouble: {
                    $replaceOne: {
                        input: "$DistanceKilometers",
                        find: ",",
                        replacement: ""
                    }
                }
            }
        }
    },
    {
        $match: {
            DistanceKilometersFloat: { $gt: 5000 },
            DestCountry: "RU"
        }
    },
    {
        $project: {
            Cancelled: 1,
            DestCountry: 1,
            DistanceKilometers: 1
        }
    }
])

// Q4
db.flights.aggregate([
    {
        $addFields: {
            "DistanceKilometersFloat": {
                $toDouble: {
                    $replaceOne: {
                        input: "$DistanceKilometers",
                        find: ",",
                        replacement: ""
                    }
                }
            },
            "DistanceMilesFloat": {
                $toDouble: {
                    $replaceOne: {
                        input: "$DistanceMiles",
                        find: ",",
                        replacement: ""
                    }
                }
            }
        }
    },
    {
        $match: {
            $or: [
                {
                    $and: [
                        { DistanceKilometersFloat: { $gt: 0 } },
                        { DistanceMilesFloat: { $gt: 0 } }
                    ]
                },
                { Cancelled: true }
            ]
        }
    },
    {
        $out: "flights_filtered"
    }
])
// the following command will replace the original collection with the filtered one
db.flights_filtered.renameCollection("flights", true)

// aggregation

// Q1
db.flights.aggregate([
    {
        $group: {
            _id: "$DestCountry",
            count: { $sum: 1 }
        }
    },
    {
        $sort: { count: -1 }
    }
])

// Q2
db.flights.aggregate([
    {
        $group: {
            _id: "$DestCountry",
            countSunny: {
                $sum: {
                    $cond: [
                        { $eq: ["$DestWeather", "Sunny"] },
                        1,
                        0
                    ]
                }
            },
        }
    },
    {
        $project: {
            _id: 1,
            countSunny: 1,
        }
    }
])

// Q3
db.flights.aggregate([
    {
        $group: {
            _id: "$DestCountry",
            sumDistanceKilometers: {
                $sum: {
                    $toDouble: {
                        $replaceOne: {
                            input: "$DistanceKilometers",
                            find: ",",
                            replacement: ""
                        }
                    }
                }
            }
        }
    },
    {
        $sort: { sumDistanceKilometers: -1 }
    },
    {
        $limit: 1
    }
])

// Q4
db.flights.aggregate([
    {
        $addFields: {
            "AvgTicketPriceWithoutCurrency": {
                $substr: ["$AvgTicketPrice", 1, { $subtract: [{ $strLenCP: "$AvgTicketPrice" }, 2] }],
            }
        }
    },
    {
        $addFields: {
            "AvgTicketPriceWithoutComma": {
                $replaceOne: {
                    input: "$AvgTicketPriceWithoutCurrency",
                    find: ",",
                    replacement: ""
                }
            }
        }
    },
    {
        $group: {
            _id: "$DestCountry",
            sumAvgTicketPrice: {
                $sum: {
                    $toDouble: "$AvgTicketPriceWithoutComma"
                }
            }
        }
    },
    {
        $sort: { sumAvgTicketPrice: -1 }
    },
    {
        $limit: 10
    },
    {
        $project: {
            _id: 1,
            sumAvgTicketPrice: 1
        }
    }
])
