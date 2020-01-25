require_relative('../db/sql_runner.rb')
require('pg')
require('pry')


class Ticket
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
    @screen_id = options['screening_id'].to_i

  end

  def save_to_db
    sql = "INSERT INTO tickets (customer_id, film_id, screening_id)
        VALUES ($1, $2, $3)
        RETURNING id"
    values = [@customer_id, @film_id, @screen_id]

    result = SqlRunner.run(sql, values)
    # binding.pry
    @id = result[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


end
