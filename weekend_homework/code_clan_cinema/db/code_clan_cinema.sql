DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS screenings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds NUMERIC
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price NUMERIC
);

CREATE TABLE screenings(
  id SERIAL PRIMARY KEY,
  screen_time VARCHAR(255),
  film_id INT references films(id),
  tickets_left INT
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  customer_id INT references customers(id),
  film_id INT references films(id),
  screening_id INT references screenings(id)
);
