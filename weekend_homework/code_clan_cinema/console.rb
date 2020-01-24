
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
customer1 = Customer.new(
  {
    'name' => 'John',
    'funds' => 50.00
  }
)
customer1.save_to_db

film1 = Film.new(
  {
    'title' => 'Silence of Lambs',
    'price' => 10.00,
  }
)
film1.save_to_db

film1_screening1 = Screening.new(
  {
    'screen_time' => "20:00"
  }
)
film1_screening1.save_to_db

ticket1 = Ticket.new(
  {
    'customer_id' => customer1.id,
    'film_id' => film1.id,
    'screening_id' => film1_screening1.id
  }
)
ticket1.save_to_db
# ---------------------------------------------------------------------------
customer9 = Customer.new(
  {
    'name' => 'JohnGuy',
    'funds' => 500.00
  }
)
customer9.save_to_db


ticket9 = Ticket.new(
  {
    'customer_id' => customer9.id,
    'film_id' => film1.id,
    'screening_id' => film1_screening1.id
  }
)
ticket1.save_to_db

# ---------------------------------------------------------------------------
#
# customer2 = Customer.new(
#   {
#     'name' => 'Freddie',
#     'funds' => 80.00
#   }
# )
# customer2.save_to_db
#
# film2 = Film.new(
#   {
#     'title' => 'Rambo III',
#     'price' => 12.00,
#   }
# )
# film2.save_to_db
#
# film2_screening1 = Screening.new(
#   {
#     'screen_time' => "21:00"
#   }
# )
# film2_screening1.save_to_db
#
# ticket2 = Ticket.new(
#   {
#     'customer_id' => customer2.id,
#     'film_id' => film2.id,
#     'screening_id' => film2_screening1.id
#   }
# )
# ticket2.save_to_db
# # ------------------------------------------------------------------------------
# # add another screening for rambo and make one customer buy a ticket
#
# customer5 = Customer.new(
#   {
#     'name' => 'Jacquiline',
#     'funds' => 30.00
#   }
# )
# customer5.save_to_db
# #
# # film2 = Film.new(
# #   {
# #     'title' => 'Rambo III',
# #     'price' => 12.00,
# #   }
# # )
# # film2.save_to_db
#
# film2_screening2 = Screening.new(
#   {
#     'screen_time' => "24:00"
#   }
# )
# film2_screening2.save_to_db
#
# ticket5 = Ticket.new(
#   {
#     'customer_id' => customer5.id,
#     'film_id' => film2.id,
#     'screening_id' => film2_screening2.id
#   }
# )
# ticket5.save_to_db
#
#
#
#
# # # # ---------------------------------------------------------------------------
#
# customer3 = Customer.new(
#   {
#     'name' => 'Agata',
#     'funds' => 130.00
#   }
# )
# customer3.save_to_db
#
# # Agata will be seeing Rambo 3 which is already generated as var film2 , hence
# # the same id.
#
# ticket3 = Ticket.new(
#   {
#     'customer_id' => customer3.id,
#     'film_id' => film2.id,
#     'screening_id' => film2_screening1.id
#   }
# )
# ticket3.save_to_db
# # # # ---------------------------------------------------------------------------
# # # # customer 3-Agata is also seeing Silence of Lambs:
# #
# ticket4 = Ticket.new(
#   {
#     'customer_id' => customer3.id,
#     'film_id' => film1.id,
#     'screening_id' => film1_screening1.id
#   }
# )
# ticket4.save_to_db


#
#
#
# binding.pry
# nil
