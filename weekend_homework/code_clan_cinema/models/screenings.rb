require_relative('../db/sql_runner.rb')
require('pg')
require('pry')

class Screening
  attr_reader :id
  attr_accessor :tickets_left

  def initialize(options)

    @id = options['id'].to_i if options['id']
    @screen_time = options['screen_time']

    # lets say each screening obj is initialised with 100 tickets available,
    # we will keep reducing this as we generate ticket objects:
    @tickets_left = 100
  end

  def save_to_db
    sql = "INSERT INTO screenings (screen_time, tickets_left)
        VALUES ($1, $2)
        RETURNING id"
    values = [@screen_time, @tickets_left]

    result = SqlRunner.run(sql, values)
    # binding.pry
    @id = result[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings WHERE screenings.id = $1"
    value = [id]
    result = SqlRunner.run(sql, value)

    screening_object = Screening.new(result[0])
    return screening_object
  end

  def update
    sql = "UPDATE screenings SET (screen_time, tickets_left) = ($1, $2)
    WHERE id = $3"
    values = [@screen_time, @tickets_left, @id]
    SqlRunner.run(sql, values)
  end

end
