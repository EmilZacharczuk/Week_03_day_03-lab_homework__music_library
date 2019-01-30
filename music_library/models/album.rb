require('pg')
require_relative('../db/sqlrunner')
require_relative('artist')

class Album

  attr_accessor :title, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
  end

  def save()
      db = PG.connect({ dbname: 'music_library', host: 'localhost' })
      sql = "INSERT INTO albums
      (
        title,
        genre,
        artist_id
      ) VALUES
      (
        $1, $2, $3
      )
      RETURNING id"
      values = [@title, @genre, @artist_id]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]["id"].to_i
      db.close()
  end


  def self.delete_all
    db = PG.connect({ dbname: 'music_library', host: 'localhost' })
    sql = "DELETE FROM albums"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def resp_art()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql, values)
    resp_art = results.map { |artist| Artist.new(artist)}
    return resp_art[0].name
  end
end
