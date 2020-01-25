require_relative('../db/sql_runner.rb')
require('pg')
require('pry')


class Film
  attr_reader :id, :price

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @title = options["title"]
    @price = options["price"].to_f
  end

  def save_to_db
    sql = "INSERT INTO films (title, price)
        VALUES ($1, $2)
        RETURNING id"
    values = [@title, @price]

    result = SqlRunner.run(sql, values)
    # binding.pry
    @id = result[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  # see which customers are coming to see one film
  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    array_of_customer_objects = result.map {|row_hash| Customer.new(row_hash)}
    return array_of_customer_objects
  end

  # Check how many customers are going to watch a certain film
  def count_customers
    return customers().length
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE films.id = $1"
    value = [id]
    result = SqlRunner.run(sql, value)

    film_object = Film.new(result[0])
    # #<Film:0x007f8c75a27a48 @id=33, @price="10.0", @title="Silence of Lambs">
    # binding.pry
    return film_object
  end

  # Write a method that finds out what is the
  # most popular time (most tickets sold) for a given film
  def popular_time
    sql = "SELECT screenings.screen_time FROM screenings
           INNER JOIN tickets ON screenings.id = tickets.screening_id
           WHERE tickets.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql,values)

    array_of_screen_times = result.map { |row_hash|
      row_hash['screen_time']}


    screentimes_counts = Hash.new(0)
    for time_str in array_of_screen_times
      screentimes_counts[time_str] += 1
    end

    return screentimes_counts.max_by{|k,v| v}[0]
    # frequency_hash = array_of_screen_times.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    # highest_frequency_pair = frequency_hash.max_by { |v| frequency_hash[v] }
    # return highest_frequency_pair[0]
  end

end
