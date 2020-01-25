
require('pg')
require 'pry'
require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/screenings.rb')



# Create customers, films and tickets
# CRUD actions (create, read, update, delete) customers, films and tickets.
# Show which films a customer has booked to see, and see which customers are coming to see one film.

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()

# ---------------------------------------------------------------------------
# Scenario:
# 8 customer objects (6 buy one tickets, 2 buy 2 tickets each)
# 3 film objects
# 6 screening objects - 17:00 and 20:00 for each film
# 10 ticket objects
# ---------------------------------------------------------------------------
# 1. Initialize customer objects:
john = Customer.new({'name' => 'John', 'funds' => 30.00})
john.save_to_db
maria = Customer.new({'name' => 'Maria', 'funds' => 40.00})
maria.save_to_db
joseph = Customer.new({'name' => 'Joseph', 'funds' => 40.00})
joseph.save_to_db
carl = Customer.new({'name' => 'Carl', 'funds' => 50.00})
carl.save_to_db
dan = Customer.new({'name' => 'Dan', 'funds' => 60.00})
dan.save_to_db
gabriel = Customer.new({'name' => 'Gabriel', 'funds' => 50.00})
gabriel.save_to_db
lucy = Customer.new({'name' => 'Lucy', 'funds' => 40.00})
lucy.save_to_db
mathiew = Customer.new({'name' => 'Mathiew', 'funds' => 40.00})
mathiew.save_to_db
# 2. Initialize film objects:
silence_of_lambs = Film.new({'title' => 'Silence of Lambs', 'price' => 5.00})
silence_of_lambs.save_to_db
home_alone = Film.new({'title' => 'Home Alone', 'price' => 4.00})
home_alone.save_to_db
rush_hour = Film.new({'title' => 'Rush Hour', 'price' => 7.00})
rush_hour.save_to_db
# 3. Initialize screening objects:
screen_17_00_sol = Screening.new({'screen_time' => "17:00", 'film_id' => silence_of_lambs.id})
screen_17_00_sol.save_to_db
screen_21_00_sol = Screening.new({'screen_time' => "21:00", 'film_id' => silence_of_lambs.id})
screen_21_00_sol.save_to_db

screen_17_00_ha = Screening.new({'screen_time' => "17:00", 'film_id' => home_alone.id})
screen_17_00_ha.save_to_db
screen_21_00_ha = Screening.new({'screen_time' => "21:00", 'film_id' => home_alone.id})
screen_21_00_ha.save_to_db

screen_17_00_rh = Screening.new({'screen_time' => "17:00", 'film_id' => rush_hour.id})
screen_17_00_rh.save_to_db
screen_21_00_rh = Screening.new({'screen_time' => "21:00", 'film_id' => rush_hour.id})
screen_21_00_rh.save_to_db


# 4. Customers buy tickets:
john.buy_ticket(screen_21_00_sol)
maria.buy_ticket(screen_17_00_ha)
joseph.buy_ticket(screen_21_00_sol)
carl.buy_ticket(screen_17_00_rh)
carl.buy_ticket(screen_21_00_ha)
dan.buy_ticket(screen_21_00_ha)
dan.buy_ticket(screen_17_00_rh)
gabriel.buy_ticket(screen_17_00_sol)
lucy.buy_ticket(screen_21_00_sol)
mathiew.buy_ticket(screen_21_00_ha)


p silence_of_lambs.popular_time
p home_alone.popular_time
p rush_hour.popular_time

p silence_of_lambs.count_customers
p home_alone.count_customers
p rush_hour.count_customers

p dan.films_booked
p dan.count_tickets

# binding.pry
# nil
