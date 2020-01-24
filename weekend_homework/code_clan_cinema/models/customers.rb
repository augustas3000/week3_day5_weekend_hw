require_relative('../db/sql_runner.rb')
require('pg')
require('pry')


class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def save_to_db
    sql = "INSERT INTO customers (name, funds)
        VALUES ($1, $2)
        RETURNING id"
    values = [@name, @funds]

    result = SqlRunner.run(sql, values)
    # binding.pry
    @id = result[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  # Show which films a customer has booked to see
  def films_booked
    sql = "SELECT films.* FROM films
           INNER JOIN tickets ON films.id = tickets.film_id
           WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    array_of_film_objects = result.map {|row_hash| Film.new(row_hash)}
    return array_of_film_objects
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE customers.id = $1"
    value = [id]
    result = SqlRunner.run(sql, value)

    customer_object = Customer.new(result[0])
    return customer_object
  end

  def update
    sql = "UPDATE customers SET (name, funds) = ($1, $2)
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def pay_for_ticket(film_price)
    @funds -= film_price
  end

  # Check how many tickets were bought by a customer
  def count_tickets
    return films_booked().length
  end

end
