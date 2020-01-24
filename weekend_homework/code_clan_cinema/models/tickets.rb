require_relative('../db/sql_runner.rb')
require('pg')
require('pry')


class Ticket
  attr_reader :id

  # Limit the available tickets for screenings.??

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @customer_id = options["customer_id"].to_i
    @film_id = options["film_id"].to_i
    @screen_id = options['screening_id'].to_i

    # generating a ticket object with cutomer_id and film_id and screen_id object
    # is basically, equivalent to a customer buying a ticket to a specific film.
    # so on init we will change customer's budget:
    film_object = Film.find_by_id(@film_id)
    customer_obj = Customer.find_by_id(@customer_id)
    customer_obj.pay_for_ticket(film_object.price)
    customer_obj.update

    # also, as the ticket is created, this means -1 ticket from available tickets
    # variable of a screening time object involved:
    screening_object = Screening.find_by_id(@screen_id)
    screening_object.tickets_left -= 1
    screening_object.update

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

  # Buying tickets should decrease the funds of the customer by the price
  # Check how many tickets were bought by a customer
  # Check how many customers are going to watch a certain film

end
