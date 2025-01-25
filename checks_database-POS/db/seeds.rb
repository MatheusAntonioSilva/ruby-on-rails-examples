puts 'Inserting Products' 
Product.create!(description: 'Product One')
Product.create!(description: 'Product Two')
puts 'Finished inserting the Products'

puts 'Insert data into mongodb...'
client = Mongo::Client.new('mongodb://mongo/test')
collection = client[:people]
docs = [{ _id: 1, name: 'Test',  hobbies: [ 'hiking', 'tennis', 'fly fishing' ], siblings: { brothers: 0, sisters: 1 } },
        { _id: 2, name: 'Matheus', hobbies: ['skiing', 'stamp collecting' ], siblings: { brothers: 1, sisters: 0 } } ]

collection.insert_many(docs)
puts 'Finished inserting data into mongodb'