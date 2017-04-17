// insert some documents to inventory collection
db.inventory.insertMany([
   { item: "journal", qty: 25, size: { h: 14, w: 21, uom: "cm" }, status: "A" },
   { item: "notebook", qty: 50, size: { h: 8.5, w: 11, uom: "in" }, status: "A" },
   { item: "paper", qty: 100, size: { h: 8.5, w: 11, uom: "in" }, status: "D" },
   { item: "planner", qty: 75, size: { h: 22.85, w: 30, uom: "cm" }, status: "D" },
   { item: "postcard", qty: 45, size: { h: 10, w: 15.25, uom: "cm" }, status: "A" }
]);

// select all documents in collection
db.inventory.find( {} )

// select all documents with status = "D" in collection
db.inventory.find( { status: "D" } )

// select all documents with status = "A" and qty less than 30 collection
db.inventory.find( { status: "A", qty: { $lt: 30 } } )

// select all documents with status = "A" OR qty less than 30 collection
db.inventory.find( { $or: [ { status: "A" }, { qty: { $lt: 30 } } ] } )