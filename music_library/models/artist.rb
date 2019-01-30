require('pg')
require_relative('../db/sqlrunner')
require_relative('album')

class Artist

  attr_reader(:id)
  attr_accessor(:name)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    db = PG.connect({ dbname: 'music_library', host: 'localhost' })
    sql = "INSERT INTO artists (name) VALUES ($1) RETURNING *"
    values = [@name]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end


  def self.delete_all
    db = PG.connect({ dbname: 'music_library', host: 'localhost' })
    sql = "DELETE FROM artists"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def album_list()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |album| Album.new(album)}
  end
end
