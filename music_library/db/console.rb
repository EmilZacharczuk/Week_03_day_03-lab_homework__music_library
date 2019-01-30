require("pry")
require_relative("../models/album")
require_relative('../models/artist')

Album.delete_all
Artist.delete_all

artist1 = Artist.new({'name' => 'Prince'})
artist1.save()

artist2 = Artist.new({'name' => 'Adele'})
artist2.save()

artist3 = Artist.new({'name' => 'Madonna'})
artist3.save()


album1 = Album.new({
  'title' => 'purple rain',
  'genre' => 'pop',
  'artist_id' => artist1.id
  })
album1.save

album2 = Album.new({
  'title' => 'sign of the times',
  'genre' => 'pop',
  'artist_id' => artist1.id
  })
album2.save

album3 = Album.new({
  'title' => '19',
  'genre' => 'pop',
  'artist_id' => artist2.id
  })
album3.save

album4 = Album.new({
  'title' => '21',
  'genre' => 'pop',
  'artist_id' => artist2.id
  })
album4.save


artists = Artist.all()

albums = Album.all





binding.pry
nil
