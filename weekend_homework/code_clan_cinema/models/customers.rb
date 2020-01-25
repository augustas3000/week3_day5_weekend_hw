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

  # Check how many tickets were bought by a customer
  def count_tickets
    return films_booked().length
  end

  def buy_ticket(screening_obj)

    if screening_obj.tickets_left == 0
      return "There are no more tickets left for this screening"
    end

    film_price = Film.find_by_id(screening_obj.film_id).price
    if @funds > film_price
      @funds -= film_price
      update()
      screening_obj.tickets_left -= 1
      screening_obj.update

      ticket_obj = Ticket.new({'customer_id' => @id,
                             'film_id' => screening_obj.film_id,
                             'screening_id' => screening_obj.id})

      ticket_obj.save_to_db

      return
    end
    return "The customer does not have enough funds"
  end

end
