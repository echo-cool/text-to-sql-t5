SELECT *
FROM flights
WHERE departure_city = 'DEN'
  AND arrival_city = 'PHI'
  AND departure_date = DATE_SUB(NOW(), INTERVAL 1 DAY);
SELECT *
FROM flights
WHERE departure_city = 'Washington'
  AND arrival_city = 'Boston'
  AND departure_time BETWEEN '14:00:00' AND '17:00:00';
SELECT *
FROM arrivals
WHERE departure_airport = 'BWI'
AND departure_time < '9:00:00'
AND arrival_time BETWEEN '08:00:00' AND '09:00:00';
SELECT *
FROM flights
WHERE departure_city = 'Phoenix'
AND destination_city = 'Milwaukee';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'San Francisco'
AND origin_city = 'Dallas';
SELECT *
FROM users
WHERE city = 'Denver'
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND arrival_city = 'San Francisco'
AND departure_date BETWEEN '2023-01-01' AND '2023-12-31'
AND flight_duration = 0;
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND arrival_city = 'Atlanta';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND destination_city = 'Atlanta';
SELECT *
FROM flights
WHERE departure_city = 'Newark'
  AND arrival_city = 'Tampa';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND arrival_city = 'BAL';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND destination_city = 'Boston';
SELECT *
FROM flights
WHERE departure_city = 'Houston'
AND destination_city = 'Milwaukee'
AND departure_date = 'Friday'
AND airline = 'American Airlines';
SELECT *
FROM flights
WHERE flight_origin = 'BOS'
  AND flight_destination = 'DEN'
  AND flight_date >= '2023-03-01'
  AND flight_date <= '2023-03-31';
SELECT *
FROM flights
WHERE departure_city = 'DENVER'
AND arrival_city = 'PHILADELPHIA';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
  AND departure_date = (
    SELECT MIN(departure_date)
    FROM flights
    WHERE departure_city = 'Denver'
  );
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Boston'
AND departure_date = '2023-08-08';
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
AND arrival_city = 'Philadelphia'
AND departure_time = '17:00'
AND arrival_time = '19:00';
SELECT destination, MIN(roundtrip_fare)
FROM flights
WHERE departure_city = 'Dallas'
GROUP BY destination;
SELECT flight_time
FROM flights
WHERE departure_city = 'Boston'
  AND departure_time < '8:00:00'
  AND arrival_city = 'Baltimore';
SELECT flight_id, origin, destination, num_stops
FROM flights
WHERE origin = 'BOS' AND destination = 'SFO'
ORDER BY num_stops DESC
LIMIT 1;
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND destination_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Baltimore'
AND departure_time >= '16:00:00'
AND departure_time <= '17:00:00';
SELECT *
FROM flights
WHERE departure_city = 'LA'
  AND arrival_city = 'CHARLOTTE'
  AND departure_date = '2023-10-27'
  AND departure_time = '09:00'
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND arrival_city = 'BAL'
AND departure_time <= 10
AND arrival_time >= 0
AND departure_date = 'THURSDAY'
SELECT *
FROM flights
WHERE departure_time BETWEEN '10:00:00' AND '13:00:00'
AND departure_airport = 'PIT'
AND arrival_airport = 'FTW';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Pittsburgh'
  AND departure_date = 'Tuesday'
SELECT *
FROM flights
WHERE flight_number = '415'
AND departure_city = 'Chicago'
AND arrival_city = 'Kansas City'
AND day = 'Thursday'
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND destination_city = 'San Francisco'
AND stops IN ('Dallas', 'American Airlines');
SELECT *
FROM flights
WHERE departure_time BETWEEN '07:00' AND '10:00'
AND departure_city = 'Philadelphia'
AND arrival_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND arrival_city = 'PHI';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND departure_time BETWEEN 430 AND 530;
SELECT *
FROM flights
WHERE departure_city = 'Detroit'
  AND destination_city = 'Chicago';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Houston'
  AND departure_time >= '2023-10-27 07:00:00'
  AND arrival_time <= '2023-10-27 19:00:00';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND arrival_city = 'Denver'
  AND departure_date = 'Sunday'
SELECT *
FROM flights
WHERE departure_city = 'DEN'
AND destination_city = 'DAL'
AND departure_time > '2023-10-27 19:00:00'
AND departure_time < '2023-10-27 20:00:00';
SELECT *
FROM flights
WHERE flight_origin = 'BA'
AND flight_destination = 'DEN'
AND (flight_number = 'UA201' OR flight_number = 'UA343');
SELECT *
FROM flights
WHERE departure_city = 'Indianapolis'
  AND arrival_city = 'Orlando'
  AND departure_date = '2023-12-27';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND departure_date >= '2023-10-27'
AND departure_date < '2023-10-30'
AND departure_time > 16:00
AND departure_city = 'DCA'
SELECT *
FROM flights
WHERE departure_city = 'Toronto'
  AND departure_time >= '17:00'
  AND arrival_city = 'Atlanta';
SELECT aircraft_type
FROM flights
WHERE departure_time < '10:00:00'
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND departure_time = 'Afternoon'
AND arrival_city = 'San Francisco'
AND arrival_time = '5:00 PM';
SELECT *
FROM routes
WHERE origin = 'Denver'
AND destination = 'Baltimore';
SELECT *
FROM travel_arrangements
WHERE origin = 'Dallas'
  AND destination = 'Pittsburgh'
  AND travel_date BETWEEN '2023-10-20'
  AND '2023-10-30';
SELECT *
FROM transportation_schedule
WHERE date = '2023-03-15'
  AND time = '08:00'
  AND day = 'Wednesday';
SELECT *
FROM flights
WHERE departure_city = 'Orlando'
  AND arrival_city = 'Kansas City';
SELECT *
FROM ground_transportation
WHERE location = 'Oakland';
SELECT *
FROM flights
WHERE departure_city = 'DENVER'
AND arrival_city = 'PHILADELPHIA';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND arrival_city = 'Pittsburgh';
SELECT price
FROM flights
WHERE flight_number = '19'
AND origin = 'New York'
AND destination = 'Los Angeles';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND destination_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'BOS'
  AND arrival_city = 'DEN'
  AND airline_name = 'American Airlines';
SELECT *
FROM business_class
WHERE origin = 'San Francisco'
AND destination = 'Denver'
AND airline = 'United Airlines';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Boston'
  AND departure_date = DATE(NOW())
  AND arrival_date = DATE(NOW() + 1 DAY);
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Dallas'
AND transfer_city = 'Atlanta';
SELECT DISTINCT aircraft_type
FROM aircraft
WHERE departure_city = 'Boston'
  AND arrival_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND destination_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND departure_date = DATE(NOW())
  AND arrival_city = 'Atlanta';
SELECT *
FROM flights
WHERE departure_time = '1pm';
SELECT *
FROM flights
WHERE departure_city = 'Salt Lake City'
AND arrival_city = 'New York City'
AND arrival_time <= 1800;
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
  AND arrival_city = 'Dallas'
  AND departure_date = '2023-12-16';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Baltimore';
SELECT *
FROM fares
WHERE departure_city = 'Dallas'
  AND arrival_city = 'San Francisco'
  AND departure_date >= '2023-01-01'
  AND departure_date <= '2023-12-31';
SELECT *
FROM flights
WHERE departure_city = 'Cleveland'
  AND arrival_city = 'Miami'
  AND departure_date = '2023-10-27'
  AND arrival_date = '2023-10-28';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'LAS'
  AND arrival_city = 'NYC'
  AND departure_date BETWEEN '2023-03-01'
  AND '2023-03-31';
SELECT *
FROM airlines
WHERE destination = 'Washington'
AND departure_city = 'Boston';
SELECT * FROM words WHERE word LIKE '%iah%';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND arrival_city = 'BAL'
AND arrival_time = '7:00 PM';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND arrival_city = 'Denver'
  AND departure_date = 'Sunday'
SELECT *
FROM flights
WHERE departure_city = 'Montreal'
AND destination_city = 'Charlotte';
SELECT COUNT(*)
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Philadelphia'
  AND departure_date = '2023-08-18';
SELECT *
FROM cities
WHERE city IN ('boston', 'pittsburgh');
SELECT *
FROM flights
WHERE price = (
    SELECT MAX(price)
    FROM flights
);
SELECT *
FROM flights
WHERE departure_airport = 'LA' OR departure_airport = 'JFK'
AND arrival_airport = 'CLE';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
  AND arrival_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
  AND arrival_city = 'Boston'
  AND departure_date >= '2023-01-01'
  AND departure_date <= '2023-12-31';
SELECT *
FROM flights
WHERE flight_date = '2023-09-05'
AND flight_origin = 'ATL'
AND flight_destination = 'BOS'
SELECT *
FROM airlines
WHERE departure_city = 'Miami'
AND departure_date = 'Friday';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND departure_date = 'Wednesday'
AND arrival_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
  AND arrival_city = 'SFO'
  AND departure_date = '2023-10-27'
  AND departure_time = '19:00';
SELECT *
FROM transportation
WHERE destination = 'Boston'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND arrival_city = 'San Francisco'
AND departure_date = 'Saturday'
AND arrival_date <= '4:00 PM';
SELECT *
FROM flights
WHERE departure_city = 'DENVER'
AND destination_city = 'SANFRANCISCO';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Boston'
  AND departure_date BETWEEN DATE_SUB('2023-10-27', INTERVAL 7 DAY)
  AND '2023-10-30';
SELECT * FROM aircraft WHERE aircraft_number = 'co 1209';
SELECT *
FROM flights
WHERE departure_date = '2023-10-27'
AND departure_time < '12:00:00'
AND departure_origin = 'DEN'
AND departure_destination = 'CHI';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND destination_city = 'BOS';
SELECT *
FROM flights
WHERE departure_airport = 'SFO'
AND arrival_airport = 'BOS';
SELECT COUNT(*)
FROM flights
WHERE destination = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'Houston'
  AND departure_date = 'Tuesday'
  AND arrival_city = 'Memphis';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'PIT'
  AND price = (
    SELECT MIN(price)
    FROM flights
    WHERE departure_city = 'ATL'
      AND arrival_city = 'PIT'
  );
SELECT *
FROM transportation
WHERE origin = 'PIT'
  AND destination = 'DOWNTOWN'
  AND mode = 'GROUND';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND arrival_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Pittsburgh'
  AND departure_time = 'Monday Morning'
SELECT * FROM train WHERE destination = 'Newark';
SELECT *
FROM flights
WHERE departure_time >= 17:00
AND departure_time < 19:00
AND destination = 'atlanta'
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND arrival_city = 'Baltimore';
SELECT * FROM words WHERE word LIKE '%ff%';
SELECT *
FROM flights
WHERE departure_airport = 'DEN'
AND departure_time < '10:00:00'
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND arrival_city = 'Dallas';
SELECT round_trip_first_class_fare
FROM united
WHERE origin = 'BOS'
  AND destination = 'SFO';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND arrival_city = 'Denver'
AND fare = (
    SELECT MIN(fare)
    FROM flights
    WHERE departure_city = 'Boston'
    AND arrival_city = 'Denver'
);
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND destination_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND arrival_city = 'Dallas'
AND departure_date >= '2023-03-01'
AND departure_date <= '2023-03-31';
SELECT *
FROM flights
WHERE departure_airport = 'ATL'
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND destination_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_city = 'SEATTLE'
  AND arrival_city = 'SLC';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
  AND destination_city = 'SFO'
  AND departure_date = (
    SELECT MIN(departure_date)
    FROM flights
    WHERE departure_city = 'PIT'
      AND destination_city = 'SFO'
  );
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND departure_time BETWEEN '12:00:00' AND '17:00:00';
SELECT * FROM table_name WHERE column_name = ord('what is ord');
SELECT *
FROM flights
WHERE departure_city = 'Los Angeles'
AND arrival_city = 'Pittsburgh'
AND departure_time <= 17:00
AND arrival_time >= 15:00
AND day = 'Tuesday';
SELECT *
FROM transportation
WHERE city = 'Boston'
AND type = 'ground transportation';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Bwi'
  AND departure_time >= '2023-03-01'
  AND departure_time <= '2023-03-31'
  AND meal_served = 'Lunch';
SELECT COUNT(*)
FROM flights
WHERE arrival_airport = 'General Mitchell International';
SELECT *
FROM airlines
WHERE destination IN ('CAN', 'INT');
SELECT *
FROM transportation
WHERE departure_airport = 'PIT'
  AND destination = 'TOWN'
  AND transportation_type = 'GROUND';
SELECT * FROM f28;
SELECT *
FROM car_rentals
WHERE pickup_date = 'next sunday'
AND pickup_time >= '09:00:00'
AND pickup_time <= '17:00:00';
SELECT *
FROM flights
WHERE departure_time > '12:00:00'
SELECT *
FROM flights
WHERE departure_time > '3:00 PM'
SELECT *
FROM flights
WHERE departure_city = 'Cleveland'
AND destination_city = 'Memphis';
SELECT * FROM translation
WHERE translation_text = 'what does the fare code qw mean';
SELECT *
FROM flights
WHERE departure_city = 'Cincinnati'
AND destination_city = 'Toronto';
SELECT *
FROM table_name
WHERE column_name = 'value';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'BOS'
  AND departure_date >= DATE_SUB(NOW(), INTERVAL 1 DAY)
  AND arrival_date <= DATE_SUB(NOW(), INTERVAL 7 DAY);
SELECT *
FROM flights
WHERE departure_city = 'Memphis'
AND destination_city = 'Las Vegas';
SELECT *
FROM flights
WHERE flight_origin = 'ATL'
  AND flight_destination = 'BAL'
  AND aircraft_type = 'BOeing 757'
  AND arrival_time = '2023-10-27 19:00';
SELECT *
FROM flights
WHERE departure_city = 'St. Paul'
AND destination_city = 'Kansas City'
AND departure_date = 'Friday'
AND supper_served = 'Yes';
SELECT *
FROM transportation
WHERE destination = 'Boston Downtown'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
  AND arrival_city = 'San Francisco';
SELECT *
FROM fares
WHERE route = 'Dallas, TX' AND destination = 'Denver, CO'
AND travel_date BETWEEN '2023-10-27' AND '2023-10-30';
SELECT *
FROM flights
WHERE departure_city = 'Seattle'
AND departure_date = 'Sunday'
AND departure_time > 430;
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND destination_city = 'DAL'
AND departure_time >= '12:00'
AND fare < 1100;
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND destination_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
  AND arrival_city = 'San Francisco'
  AND price < 200;
SELECT *
FROM flights
WHERE departure_city = 'American'
AND destination_city = 'San Francisco'
AND departure_date = 'Tuesday'
SELECT *
FROM airlines
WHERE EXISTS (
    SELECT 1
    FROM flights
    WHERE departure_time BETWEEN '14:00:00' AND '16:00:00'
    AND origin = 'BOS'
    AND destination = 'DEN'
);
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND departure_date = '2023-10-27'
AND departure_time >= 7:00
SELECT *
FROM flights
WHERE departure_city = 'Salt Lake City'
SELECT *
FROM flights
WHERE departure_city = 'Nashville'
  AND arrival_city = 'St. Louis'
  AND departure_time >= '2023-10-27'
  AND arrival_time <= '2023-10-30';
SELECT *
FROM classes;
SELECT *
FROM transportation
WHERE destination = 'Downtown San Francisco'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
  AND destination_city = 'Washington';
SELECT * FROM fares WHERE fare_code = 'qo';
SELECT *
FROM flights
WHERE airline IN ('American', 'Delta');
SELECT *
FROM prices
WHERE location = 'Pittsburgh'
AND service = 'limousine';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Washington'
  AND fare = (
    SELECT MIN(fare)
    FROM flights
    WHERE departure_city = 'Boston'
      AND arrival_city = 'Washington'
  );
SELECT *
FROM flights
WHERE departure_city = 'MIA'
  AND departure_date = '2023-10-27'
  AND departure_time = '08:00'
  AND arrival_city = 'LAS'
  AND arrival_date = '2023-10-27'
  AND arrival_time = '12:00';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'SFO'
  AND departure_date = '2023-10-27'
  AND arrival_date = '2023-10-30';
SELECT *
FROM flights
WHERE departure_city = 'DEN'
  AND destination_city = 'SF'
  AND departure_time >= '07:00'
  AND breakfast_served = 'YES';
SELECT *
FROM flights
WHERE departure_city = 'Cleveland'
  AND arrival_city = 'Miami'
  AND departure_time <= 16:00
  AND arrival_time >= 16:00;
SELECT *
FROM classes_of_service
WHERE lufthansa = 'true';
SELECT *
FROM airlines
WHERE direct_flights = 'yes'
AND origin IN ('WA', 'DEN')
SELECT *
FROM flights
WHERE flight_number = 'UA270'
AND departure_city = 'DENVER'
AND arrival_city = 'PHILADELPHIA';
SELECT *
FROM flights
WHERE departure_time BETWEEN '12:00:00' AND '16:00:00'
AND departure_airport = 'PIT'
AND day = 'Wed';
SELECT *
FROM flights
WHERE departure_city = 'Cleveland'
  AND departure_date = '2023-10-27'
  AND arrival_city = 'Miami';
SELECT *
FROM flights
WHERE departure_airport = 'OAK'
  AND arrival_airport = 'PHL'
  AND departure_time BETWEEN 17 AND 19
  AND arrival_time BETWEEN 17 AND 19;
SELECT *
FROM flights
WHERE departure_city = 'Phoenix'
AND destination_city = 'Milwaukee'
AND departure_date = 'Wednesday'
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND destination_city = 'DAL'
AND departure_time >= '12:00'
AND fare < 1100;
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Houston'
  AND departure_date >= '2023-01-01'
  AND departure_date <= '2023-12-31';
SELECT flight_details
FROM flights
WHERE departure_time BETWEEN '17:00:00' AND '19:00:00'
AND origin = 'CHI'
AND destination = 'MIL';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND departure_date = '2023-10-27'
  AND arrival_city = 'DCA'
  AND arrival_date = '2023-10-27';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND departure_time < '12:00:00'
  AND airline = 'American Airlines';
SELECT fare
FROM flights
WHERE flight_number = '928'
AND origin = 'DALLAS'
AND destination = 'BOSTON';
SELECT *
FROM airports
WHERE distance FROM airport_code = 'DALLAS'
ORDER BY distance;
SELECT *
FROM flights
WHERE departure_city = 'Cincinnati'
  AND departure_date = CURDATE()
  AND arrival_city = 'Burbank'
  AND arrival_date = CURDATE() + 1;
SELECT *
FROM airlines
WHERE destination = 'San Francisco'
AND departure_city = 'Washington';
SELECT *
FROM flights
WHERE departure_city = 'LAS'
AND arrival_city = 'NYC'
AND flight_duration = 1440;
SELECT *
FROM flights
WHERE flight_origin = 'Dallas'
AND flight_destination = 'Atlanta';
SELECT *
FROM flights
WHERE departure_city = 'Phoenix'
AND arrival_city = 'Las Vegas';
SELECT *
FROM flights
WHERE departure_city = 'Chicago'
AND departure_date = 'Sunday'
AND carrier = 'Continental';
SELECT *
FROM flights
WHERE departure_city = 'DENVER'
AND departure_date = '2023-10-27'
AND departure_time >= '12:00:00'
AND departure_date BETWEEN '2023-10-27' AND '2023-10-29'
SELECT *
FROM flights
WHERE departure_airport = 'Love Field'
AND destination_airport IN ('Airport A', 'Airport B', 'Airport C');
SELECT *
FROM flights
WHERE departure_city = 'Love Field'
OR arrival_city = 'Love Field';
SELECT *
FROM flights
WHERE flight_origin = 'BOS'
AND flight_destination = 'OAK'
AND flight_stops IN ('DEN');
SELECT *
FROM fares
WHERE origin = 'Dallas'
AND destination = 'Atlanta';
SELECT *
FROM transportation
WHERE origin = 'San Francisco Airport'
  AND destination = 'City';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'DEN';
SELECT *
FROM transportation
WHERE location = 'San Francisco'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
AND arrival_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'New York'
AND departure_date = 'Tuesday'
OR arrival_city = 'Miami'
AND arrival_date = 'Sunday';
SELECT *
FROM flights
WHERE departure_date = '1991-07-25'
  AND departure_airport = 'DEN'
  AND arrival_airport = 'BAL';
SELECT *
FROM flights
WHERE departure_city = 'Milwaukee'
  AND arrival_city = 'Phoenix';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'BWI'
  AND round_trip_fare < (
    SELECT MIN(round_trip_fare)
    FROM flights
    WHERE departure_city = 'ATL'
      AND arrival_city = 'BWI'
  );
SELECT *
FROM airlines
WHERE departure_city = 'Toronto'
AND arrival_city = 'Denver';
SELECT fare
FROM fares
WHERE date = '2023-11-07'
AND route = 'San Francisco to Oakland';
SELECT *
FROM words
WHERE definition LIKE '%ewr%';
SELECT *
FROM flights
WHERE departure_time >= '06:00'
AND departure_airport = 'ORD'
AND airline = 'Continental Airlines';
SELECT *
FROM flights
WHERE departure_city = 'DEN'
  AND arrival_city = 'BAL'
  AND airline = 'UNITED'
  AND class = 'FIRST';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_time = 'midnight'
AND destination = 'oakland';
SELECT flight_cost
FROM flights
WHERE flight_number = 'UA297'
AND departure_city = 'DENVER'
AND arrival_city = 'SANFRANCISCO';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND destination_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'atlanta'
AND arrival_city = 'oakland'
AND departure_date = 'thursday';
SELECT *
FROM flights
WHERE departure_city = 'Tampa'
  AND departure_time < '10:00:00'
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND arrival_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_city = 'Kansas City'
AND destination_city = 'Cleveland'
AND departure_date = 'Wednesday';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND departure_time >= '08:00:00'
  AND arrival_city = 'Baltimore';
SELECT city
FROM airlines
WHERE airline_name = 'Canadian Airlines International';
SELECT *
FROM car_rentals
WHERE city = 'Baltimore';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Boston'
  AND stopover_cities IN ('Dallas Fort Worth');
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND departure_date = '2023-11-11'
AND departure_time > 17:00
AND class = 'Economy';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'BOS';
SELECT *
FROM flights
WHERE departure_city = 'cincinnati'
AND destination_city = 'houston'
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND arrival_city = 'San Francisco'
OR departure_city = 'Denver'
AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'New York'
AND arrival_city = 'Miami';
SELECT *
FROM airlines
WHERE connections IN (
    SELECT destination
    FROM flights
    WHERE origin = 'PIT'
    AND destination = 'BAL'
);
SELECT * FROM table_name WHERE column_name = 'sa';
SELECT *
FROM flights
WHERE departure_airport = 'BWI'
  AND arrival_airport = 'DEN'
  AND date >= '2023-03-01'
  AND date <= '2023-03-31';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND departure_date = '2023-10-27'
AND departure_time < '0900';
SELECT *
FROM flights
WHERE departure_city = 'Newark'
  AND arrival_city = 'Nashville';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
  AND destination_city = 'Dallas';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND destination_city = 'Washington DC'
AND departure_date = '2023-11-11';
SELECT *
FROM transportation
WHERE origin = 'Orlando International'
AND destination = 'Orlando';
SELECT *
FROM cities
WHERE city IN ('chicago', 'san francisco');
SELECT *
FROM flights
WHERE departure_city = 'LAS'
AND departure_date = '2022-05-22'
AND arrival_city = 'BUR'
SELECT *
FROM flights
WHERE departure_city = 'ATL'
AND arrival_city = 'STL'
AND departure_time BETWEEN '2300:00' AND '2359:00';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'San Francisco'
AND airline = 'American Airlines';
SELECT *
FROM flights
WHERE departure_city = 'Milwaukee'
AND departure_date = 'Sunday'
AND arrival_city = 'St. Louis';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND arrival_city = 'NEW';
SELECT aircraft_type
FROM flights
WHERE flight_time = '8:00';
SELECT *
FROM ground_transport
WHERE location = 'Seattle'
SELECT *
FROM flights
WHERE departure_city = 'PIT'
  AND arrival_city = 'BOS'
  AND price < (
    SELECT MIN(price)
    FROM flights
    WHERE departure_city = 'PIT'
      AND arrival_city = 'BOS'
  );
SELECT *
FROM flights
WHERE departure_time BETWEEN '17:00:00' AND '19:00:00'
AND arrival_time BETWEEN '16:00:00' AND '20:00:00';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
  AND arrival_city = 'San Francisco'
  AND departure_time BETWEEN '14:00:00' AND '18:00:00';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Dallas';
SELECT flight_id, origin, destination, number_of_stops
FROM flights
WHERE origin = 'BOS'
  AND destination = 'SFO'
  AND number_of_stops > 3;
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND arrival_city = 'Baltimore'
ORDER BY price ASC;
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
  AND departure_date = '2023-10-27';
SELECT *
FROM flights
WHERE departure_date = '2023-04-10'
AND departure_city = 'ATL'
AND arrival_city = 'WAW'
AND day = 'Thursday';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Boston'
  AND departure_date >= DATE(NOW())
  AND arrival_date <= DATE(NOW() + INTERVAL 1 DAY);
SELECT *
FROM flights
WHERE departure_city = 'pittsburgh'
AND arrival_city = 'denver';
SELECT *
FROM flights
WHERE departure_city = 'St. Petersburg'
  AND departure_date = DATE_SUB(NOW(), INTERVAL 1 DAY)
  AND arrival_city = 'Milwaukee';
SELECT *
FROM flights
WHERE departure_city = 'Memphis'
AND destination_city = 'Charlotte';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND destination_city = 'Dallas'
AND has_one_stop = 1;
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
AND arrival_city = 'Boston';
SELECT *
FROM costs
WHERE city = 'Denver'
ORDER BY cost ASC;
SELECT *
FROM flights
WHERE departure_city = 'MINNEAPOLIS'
  AND destination_city = 'SAN_DIEGO'
  AND fare_class = 'COACH_economy';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
AND arrival_city = 'Denver';
SELECT *
FROM airlines
WHERE departure_city = 'Atlanta';
SELECT fares
FROM fares
WHERE route = 'Oakland to Dallas'
AND travel_date = '2023-12-16';
SELECT *
FROM airlines
WHERE departure_city = 'Boston'
  AND destination_city = 'Atlanta';
SELECT *
FROM flights
WHERE flight_origin = 'BOS'
AND flight_destination = 'PIT'
AND flight_date = '2023-10-27'
AND flight_time BETWEEN '08:00:00' AND '12:00:00'
AND meal_served = 'YES';
SELECT *
FROM flights
WHERE departure_city = 'DENVER'
AND arrival_city = 'PHILADELPHIA';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND arrival_city = 'Pittsburgh'
AND departure_date = '2023-07-08';
SELECT flight_time
FROM flights
WHERE airline = 'united'
AND flight_date = '2023-09-20'
AND flight_origin = 'PHL'
AND flight_destination = 'SFO';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND arrival_city = 'Baltimore';
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
AND arrival_city = 'Boston'
AND has_stopover = 'Yes'
AND stopover_cities IN ('Dallas Fort Worth');
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'Columbus'
AND arrival_city = 'Baltimore';
SELECT *
FROM translation
WHERE translation_text LIKE '%fare code qx%';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Dallas'
AND arrival_time >= '14:00';
SELECT price
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Baltimore'
SELECT aircraft_type
FROM flights
WHERE flight_number = 825
AND departure_airport = 'ATL'
AND destination_airport = 'DEN';
SELECT flight_id, airline, departure_time
FROM flights
WHERE departure_time = '838am'
AND flight_id IN (
    SELECT flight_id
    FROM flights
    WHERE origin = 'Boston'
    AND destination = 'Oakland'
);
SELECT *
FROM flights
WHERE departure_time = 'early saturday morning'
SELECT * FROM words WHERE word LIKE '%y%';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'WA'
  AND arrival_city = 'DEN';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND destination_city = 'ATL';
SELECT *
FROM transportation
WHERE location = 'San Francisco'
AND type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'Phoenix'
AND departure_date = 'Wednesday'
AND arrival_city = 'Milwaukee';
SELECT *
FROM flights
WHERE airline = 'Delta'
AND route LIKE '%ATL%'
SELECT * FROM table_name WHERE column_name = 'yn_code';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
  AND departure_date = 'Wednesday'
  AND arrival_city = 'Washington DC';
SELECT *
FROM flights
WHERE departure_time >= '4:00 PM'
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND destination_city = 'Washington, D.C.';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Atlanta'
  AND departure_date = '2023-11-07';
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
  AND arrival_city = 'Denver'
  AND departure_time BETWEEN '08:00:00' AND '12:00:00';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND departure_time = '2:00 PM'
  AND arrival_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'Kansas City'
AND departure_date = '2022-05-22'
AND destination_city = 'Burbank'
AND flight_date = 'Saturday'
SELECT *
FROM flights
WHERE departure_date = 'tuesday'
  AND destination = 'st. petersburg';
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'PIT'
  AND price = (
    SELECT MIN(price)
    FROM flights
    WHERE departure_city = 'ATL'
      AND arrival_city = 'PIT'
  );
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
  AND arrival_city = 'Dallas';
SELECT COUNT(*)
FROM flights
WHERE departure_city IN (
    SELECT DISTINCT departure_city
    FROM flights
    WHERE departure_date = CURDATE()
)
AND departure_time >= '09:00:00'
AND departure_time <= '17:00:00';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
  AND destination_city = 'San Francisco';
SELECT *
FROM aircraft
WHERE airline_name = 'Canadian Airlines';
SELECT *
FROM flights
WHERE departure_city = 'BALtimore'
AND arrival_city = 'PHILADELPHIA'
AND arrival_time > 2100;
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND destination_city = 'ATL'
AND departure_date = '2023-10-27'
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND destination_city IN ('Pittsburgh', 'Atlanta');
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND arrival_city = 'San Francisco'
AND has_stop_over = 'Yes'
AND departure_city IN ('Denver')
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'Chicago'
  AND departure_date = 'Saturday'
  AND destination_city = 'Seattle';
SELECT *
FROM flights
WHERE departure_airport = 'Love Field'
AND departure_date >= '2023-01-01'
AND departure_date <= '2023-12-31';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND departure_time >= '08:00:00'
  AND arrival_city = 'Denver';
SELECT *
FROM flights
WHERE departure_time = '06-04-2023 08:00:00'
SELECT *
FROM flights
WHERE departure_city = 'Memphis'
AND arrival_city = 'Miami'
AND price = (
    SELECT MIN(price)
    FROM flights
    WHERE departure_city = 'Memphis'
    AND arrival_city = 'Miami'
);
SELECT *
FROM flights
WHERE departure_city = 'Denver'
  AND destination_city = 'San Francisco'
  AND day = 'Wednesday';
SELECT *
FROM transportation
WHERE origin = 'Dallas Airport'
  AND destination = 'Downtown Dallas';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
  AND departure_date = '2023-10-27'
  AND flight_price = 124;
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND departure_date = '2023-04-16'
AND departure_time >= '20:00:00'
AND arrival_city = 'Boston';
SELECT *
FROM flights
WHERE departure_city = 'Houston'
  AND arrival_city = 'Las Vegas'
  AND round_trip = 1;
SELECT *
FROM flights
WHERE departure_city = 'San Jose'
AND arrival_city = 'St Paul';
SELECT COUNT(*) FROM seats WHERE seat_number = 734;
SELECT *
FROM words
WHERE word LIKE '%ewr%';
SELECT *
FROM flights
WHERE flight_number = '813'
AND departure_city = 'Boston'
AND arrival_city = 'Oakland'
AND EXISTS (
    SELECT 1
    FROM flights
    WHERE flight_number = '813'
    AND departure_city = 'Another_City'
);
SELECT *
FROM flights
WHERE departure_city = 'pittsburgh'
  AND arrival_city = 'new york city';
SELECT *
FROM flights
WHERE flight_number = '497766'
AND departure_airport = 'St. Petersburg'
AND arrival_airport = 'Milwaukee'
AND has_one_stop = 'Yes'
AND departure_time >= DATE_SUB(NOW(), INTERVAL 1 DAY)
SELECT airline_name
FROM airlines
WHERE airline_abbreviation = 'EA';
SELECT *
FROM airlines
WHERE airline_name = 'us';
SELECT *
FROM transportation
WHERE location = 'Denver'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'Phoenix'
AND arrival_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'Washington'
  AND departure_time >= '15:00:00'
  AND departure_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'Orlando'
AND destination_city = 'San Diego'
AND aircraft_type = 'Boeing 737';
SELECT *
FROM flights
WHERE flight_time = '718am'
AND departure_city = 'LAS'
AND arrival_city = 'NYC';
SELECT *
FROM ground_transportation
WHERE location = 'Denver, CO';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND arrival_city = 'DEN'
OR departure_city = 'DEN'
AND arrival_city = 'PIT';
SELECT *
FROM ground_transport
WHERE location LIKE '%san francisco%';
SELECT *
FROM flights
WHERE departure_time < '12:00:00'
AND airline = 'Northwest Airlines';
SELECT *
FROM flights
WHERE departure_airport = 'General Mitchell International Airport';
SELECT *
FROM flights
WHERE departure_city = 'DEN'
AND arrival_city = 'PHI'
SELECT *
FROM limousine_service
WHERE location = 'Boston';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore';
None
SELECT cost
FROM flights
WHERE origin = 'DEN'
  AND destination = 'PIT'
  AND date >= '2023-10-27'
  AND date <= '2023-10-30';
SELECT *
FROM airlines
WHERE departure_city = 'Boston'
  AND destination_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND destination_city = 'SFO'
SELECT fare
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'Denver, Colorado'
AND arrival_city = 'Dallas, Texas';
SELECT *
FROM flights
WHERE departure_city = 'Chicago'
AND destination_city = 'Kansas City'
AND departure_date = '2023-06-17'
AND departure_time BETWEEN '19:00:00' AND '21:00:00';
SELECT flight_id, departure_city, arrival_city, arrival_time
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Atlanta'
  AND arrival_time = (
    SELECT MIN(arrival_time)
    FROM flights
    WHERE departure_city = 'Boston'
      AND arrival_city = 'Atlanta'
  );
SELECT *
FROM flights
WHERE departure_city = 'Toronto'
AND departure_time BETWEEN 17:00:00 AND 19:00:00
SELECT *
FROM flights
WHERE departure_city = 'ATL'
  AND arrival_city = 'PIT';
SELECT *
FROM flights
WHERE departure_city = 'Washington, DC'
AND departure_time = 'Tuesday morning'
SELECT *
FROM airports
WHERE airport_city = 'Washington, DC';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND departure_date = '2023-10-21'
AND arrival_city = 'Boston';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND departure_date >= '2023-10-27'
AND departure_date <= '2023-10-30';
SELECT *
FROM transportation
WHERE origin = 'Boston Airport'
  AND destination = 'Boston Downtown';
SELECT *
FROM flights
WHERE departure_city = 'Tampa'
  AND arrival_city = 'Milwaukee'
  AND departure_date = DATE_SUB(NOW(), INTERVAL 1 DAY)
  AND arrival_date = DATE_SUB(NOW(), INTERVAL 1 DAY);
SELECT *
FROM flights
WHERE departure_city = 'Toronto'
AND arrival_city = 'San Diego'
AND stopover_city = 'Denver';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Washington DC'
AND month = 12
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND departure_date = 'Wednesday'
AND departure_time <= '12:00:00';
SELECT *
FROM flights
WHERE departure_city = 'DEN'
AND departure_date = DATE_ADD(NOW(), INTERVAL 2 DAY)
AND arrival_city = 'PHI'
AND arrival_date = DATE_ADD(NOW(), INTERVAL 2 DAY);
SELECT *
FROM coach_class
WHERE flight_origin = 'PIT'
  AND flight_destination = 'ATL';
SELECT *
FROM vehicles
WHERE vehicle_type = 'airport limousine'
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND destination_city = 'San Francisco'
AND departure_date >= DATE_SUB(NOW(), INTERVAL 1 DAY)
SELECT *
FROM flights
WHERE departure_city = 'Charlotte'
AND destination_city = 'Atlanta'
AND departure_date = DATE_ADD(NOW(), INTERVAL 1 DAY)
SELECT *
FROM flights
WHERE departure_city = 'Oakland'
  AND arrival_city = 'Atlanta'
  AND class = 'First Class';
SELECT *
FROM flights
WHERE departure_city = 'Nashville'
AND arrival_city = 'Seattle';
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
  AND arrival_city = 'Denver'
  AND departure_date >= '2023-01-01'
  AND departure_date <= '2023-12-31';
SELECT *
FROM flights
WHERE departure_city = 'Newark'
AND arrival_city = 'Cleveland';
SELECT fare
FROM fares
WHERE origin = 'Indianapolis'
  AND destination = 'Seattle'
  AND travel_date BETWEEN '2023-01-01'
  AND '2023-12-31';
SELECT flight_id, airline, departure_city, arrival_city, travel_date
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Pittsburgh'
  AND travel_date = 'Monday'
  AND class = 'First Class';
SELECT *
FROM flights
WHERE departure_city = 'Chicago'
AND departure_date = 'Saturday'
AND departure_time = '08:00';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND destination_city = 'LAX'
AND day = 'THURSDAY'
AND departure_time BETWEEN '18:00:00' AND '20:00:00';
SELECT *
FROM flights
WHERE departure_date = '2023-12-27'
AND origin = 'IND'
AND destination = 'ORD';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND arrival_city = 'Philadelphia'
AND departure_date = '2023-09-15';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Oakland'
  AND departure_date >= DATE('2023-01-01')
  AND departure_date <= DATE('2023-12-31');
SELECT *
FROM transportation
WHERE location = 'Washington, DC';
SELECT *
FROM flights
WHERE departure_city = 'Washington'
  AND destination_city = 'San Francisco';
CREATE TABLE employees (
    employee_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY (employee_id)
);
SELECT *
FROM flights
WHERE departure_time = 'Friday Afternoon'
AND destination = 'Oakland';
SELECT *
FROM flights
WHERE departure_city = 'St. Paul'
AND destination_city = 'Kansas City'
AND departure_date = 'Friday'
AND meal = 'Yes';
SELECT *
FROM flights
WHERE departure_city = 'Long Beach'
AND destination_city = 'St. Louis'
AND has_stops = 'Yes'
AND pickup_city = 'Dallas';
SELECT *
FROM travel_time
WHERE origin = 'Kansas City'
  AND destination = 'St. Paul';
SELECT *
FROM flights
WHERE departure_city = 'Los Angeles'
AND arrival_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND destination_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'DENVER'
AND destination_city = 'SAN FRANCISCO'
AND departure_date = '2023-10-15'
SELECT *
FROM flights
WHERE departure_city = 'Denver'
  AND arrival_city = 'Salt Lake City';
SELECT *
FROM services
WHERE service_category IN ('what classes of service does twa have');
SELECT *
FROM flights
WHERE departure_time BETWEEN '17:00:00' AND '19:00:00'
AND destination = 'Oakland'
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Houston'
  AND departure_date >= '2023-01-01'
  AND departure_date <= '2023-12-31';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND departure_airport = 'BWI'
AND arrival_city = 'Seattle'
AND arrival_airport = 'SEA';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND arrival_city = 'Boston'
AND has_stop_over = 'Yes'
AND stopover_cities IN ('Dallas Fort Worth');
SELECT distance
FROM airports
WHERE airport_name = 'San Francisco International Airport'
AND distance < 500;
SELECT * FROM airlines WHERE airline_name = 'dl';
SELECT * FROM flights WHERE departure_date = (SELECT MAX(departure_date) FROM flights);
SELECT *
FROM flights
WHERE arrival_airport = 'General Mitchell International Airport';
SELECT *
FROM flights
WHERE departure_city = 'New York'
AND destination_city = 'Los Angeles'
AND has_stop = 'Yes'
AND stop_city = 'Milwaukee';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND destination_city = 'Dallas'
AND airline = 'American Airlines';
SELECT *
FROM flights
WHERE departure_city = 'Westchester County'
AND destination_city = 'Cincinnati';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Pittsburgh'
  AND departure_date = '2023-10-27'
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Washington'
  AND departure_date = '2023-10-27'
  AND flight_type = 'One Way';
SELECT *
FROM flights
WHERE departure_time = (
    SELECT MAX(departure_time)
    FROM flights
    WHERE departure_airport = 'SFO'
);
SELECT *
FROM transportation
WHERE location = 'Minneapolis'
AND transport_type = 'ground';
SELECT * FROM airplanes WHERE type = 'M80';
SELECT *
FROM flights
WHERE departure_time < '9:00:00'
SELECT *
FROM economy
WHERE city IN ('Dallas', 'Baltimore');
SELECT * FROM airports WHERE airport_name = 'Tampa International Airport';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND departure_date = CURDATE();
SELECT fare_amount
FROM fares
WHERE origin = 'ATL'
  AND destination = 'BAL'
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND destination_city = 'Dallas'
AND departure_date = '2023-07-29';
SELECT *
FROM fares
WHERE origin = 'Houston'
AND destination = 'Las Vegas';
SELECT *
FROM fares
WHERE departure_city = 'New York'
AND departure_date = 'Tuesday'
SELECT * FROM sfo
WHERE destination = 'denver';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'Tampa';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND departure_date >= '2023-10-27'
  AND airline = 'United Airlines'
  AND earliest_flight = 'YES';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND arrival_city = 'Philadelphia';
SELECT *
FROM flights
WHERE departure_city = 'phoenix'
  AND destination_city = 'detroit'
  AND departure_date = 'tuesday'
SELECT *
FROM flights
WHERE departure_city = 'Toronto'
AND arrival_city = 'San Diego'
AND stops IN ('St. Louis');
SELECT *
FROM flights
WHERE departure_city = 'Atlanta'
AND arrival_city = 'Denver'
AND service_type = 'Meal';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Atlanta';
SELECT *
FROM flights
WHERE departure_city = 'Washington, DC'
AND destination_city = 'Philadelphia'
AND month = 'December'
AND day = '2';
SELECT *
FROM flights
WHERE flight_origin = 'BAL'
AND flight_destination = 'SAN'
AND flight_arrival_time = '8:00 PM'
AND day = 'FRIDAY';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND arrival_city = 'San Francisco';
SELECT aircraft_type
FROM flights
WHERE departure_time < '6:00 PM'
AND departure_airport = 'ATL'
AND arrival_airport = 'DEN';
SELECT *
FROM flights
WHERE departure_time = 'tomorrow morning'
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Boston'
AND departure_date = '1991-08-31';
SELECT *
FROM fares
WHERE departure_city = 'New York'
AND departure_date = 'Tuesday'
SELECT *
FROM flights
WHERE departure_city = 'Phoenix'
AND destination_city = 'Milwaukee'
AND airline = 'American Airlines'
AND date = 'Wednesday';
SELECT *
FROM flights
WHERE departure_city = 'Tampa'
  AND destination_city = 'Cincinnati';
SELECT *
FROM transportation
WHERE location = 'Philadelphia'
AND type = 'ground transportation';
SELECT *
FROM rental_cars
WHERE location = 'Washington, DC';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND arrival_city = 'Atlanta'
OR arrival_city = 'Atlanta'
AND departure_city = 'Atlanta';
SELECT *
FROM fares
WHERE origin = 'Dallas'
AND destination = 'San Francisco';
SELECT distance
FROM airports
WHERE airport_name = 'Dallas/Fort Worth International Airport'
AND distance < 20;
SELECT *
FROM fares
WHERE origin = 'San Jose'
  AND destination = 'Salt Lake City'
  AND trip_date BETWEEN '2023-01-01'
  AND '2023-12-31';
SELECT fare
FROM flights
WHERE flight_number = '852'
AND departure_city = 'San Francisco'
AND arrival_city = 'Dallas Fort Worth';
SELECT *
FROM flights
WHERE departure_city = 'PIT'
AND departure_time = '2023-10-27 18:00:00'
AND arrival_city = 'PHI'
AND arrival_time = '2023-10-27 20:00:00';
SELECT fare
FROM flights
WHERE origin = 'Dallas'
  AND destination = 'Baltimore'
  AND fare < (SELECT MIN(fare)
              FROM flights
              WHERE origin = 'Dallas'
                AND destination = 'Baltimore');
SELECT *
FROM flights
WHERE departure_time BETWEEN '07:00' AND '10:00';
SELECT *
FROM fares
WHERE origin = 'Denver'
  AND destination = 'Atlanta'
  AND fare_class = 'Economy';
SELECT *
FROM flights
WHERE departure_city = 'Baltimore'
AND departure_date = 'Tuesday'
AND departure_time = '08:00:00'
SELECT *
FROM flights
WHERE departure_city = 'Chicago'
  AND destination_city = 'Nashville';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND departure_date = '1992-01-01'
AND arrival_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Denver'
AND day = 'Thursday';
SELECT COUNT(*)
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Atlanta'
  AND flight_duration >= 120;
SELECT *
FROM flights
WHERE departure_airport = 'OAK'
  AND arrival_airport = 'BOS'
  AND airline = 'TWA';
SELECT *
FROM flights
WHERE departure_city = 'LAS'
  AND destination_city = 'NYC'
  AND departure_time >= '2023-10-27 00:00:00'
  AND departure_time <= '2023-10-27 23:59:59';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND departure_time < '05:00:00'
AND departure_date = 'Thursday';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Dallas'
AND stops IN ('Atlanta');
SELECT *
FROM flights
WHERE departure_city = 'St. Petersburg'
AND departure_date = '2023-10-27'
AND departure_time = '09:00';
SELECT *
FROM airlines
WHERE airline_city = 'Pittsburgh';
SELECT price
FROM flights
WHERE flight_number = 'UA270'
AND departure_city = 'DENVER'
AND arrival_city = 'PHILADELPHIA';
SELECT *
FROM airlines
WHERE destination = 'pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'Memphis'
AND arrival_city = 'Tacoma'
AND stops IN ('Los Angeles');
SELECT *
FROM fares
WHERE origin = 'PIT'
AND destination = 'PHI'
SELECT *
FROM flights
WHERE departure_city = 'Toronto'
AND arrival_city = 'San Francisco';
SELECT fare
FROM flights
WHERE flight_number = '217'
AND origin = 'DALLAS'
AND destination = 'SAN FRANCISCO';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND departure_time >= '18:00:00'
AND departure_day = 'Wednesday'
SELECT *
FROM flights
WHERE departure_city = 'Indianapolis'
AND destination_city = 'San Diego'
AND departure_time >= '17:00'
AND departure_time <= '19:00';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'Denver'
  AND departure_date = CURDATE()
  AND arrival_date = CURDATE();
SELECT *
FROM routes
WHERE departure_airport = 'PIT'
  AND arrival_airport = 'PIT'
  AND route_type = 'BUS';
SELECT *
FROM flights
WHERE departure_city = 'Milwaukee'
AND destination_city = 'Montreal';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND destination_city = 'Philadelphia'
  AND departure_time <= (SELECT MAX(departure_time) FROM flights
                       WHERE departure_city = 'Boston'
                         AND destination_city = 'Philadelphia');
SELECT flight_number
FROM flights
WHERE flight_origin = 'MINneapolis'
AND flight_destination = 'LONG BEACH'
AND flight_date = '2023-06-26';
SELECT *
FROM flights
WHERE departure_city = 'Philadelphia'
AND arrival_city = 'Dallas'
AND has_stop = 'Hartfield';
SELECT *
FROM airlines
WHERE departure_city = 'PIT'
  AND destination_city = 'SFO'
  AND departure_date = '2023-09-01'
  AND departure_day = 'MONDAY'
  AND arrival_date = '2023-09-02';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
  AND arrival_city = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'Boston'
AND destination_city = 'Denver'
AND departure_date = '2023-07-29';
SELECT *
FROM planes
WHERE departure_city = 'Pittsburgh'
  AND arrival_city = 'Baltimore';
SELECT *
FROM flights
WHERE departure_time = 'Monday Morning'
SELECT *
FROM flights
WHERE flight_number = '417'
AND origin = 'cincinnati'
AND destination = 'dallas';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND arrival_city = 'Atlanta';
SELECT *
FROM transportation
WHERE destination = 'Boston'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
AND destination_city = 'Las Vegas';
SELECT *
FROM flights
WHERE departure_city = 'Houston'
AND destination_city = 'Milwaukee'
AND departure_date = 'Friday'
AND airline = 'American Airlines';
SELECT price
FROM fares
WHERE route = 'ATL-DTW'
  AND date = '2023-10-27'
  AND vehicle_type = 'LIMO';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
  AND arrival_city = 'Pittsburgh';
SELECT *
FROM flights
WHERE departure_city = 'San Francisco'
  AND arrival_city = 'Washington';
SELECT *
FROM fares
WHERE origin = 'Seattle'
AND destination = 'Minneapolis';
SELECT *
FROM transportation
WHERE destination = 'Downtown Phoenix'
AND transportation_type = 'Ground Transportation';
SELECT *
FROM flights
WHERE departure_city = 'San Jose'
AND departure_date = '2023-06-03'
AND departure_time = '08:00';
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
  AND arrival_city = 'San Francisco'
  AND departure_date = 'Saturday'
  AND arrival_date = 'San Francisco';
SELECT *
FROM flights
WHERE departure_city = 'Denver'
  AND arrival_city = 'Pittsburgh'
  AND price < (SELECT MIN(price)
              FROM flights
              WHERE departure_city = 'Denver'
                AND arrival_city = 'Pittsburgh');
SELECT *
FROM flights
WHERE departure_airport = 'SAN'
AND destination_airport = 'DUB'
AND aircraft_type = 'BOeing 767';
SELECT *
FROM airlines
WHERE departure_city = 'Boston'
AND destination_city = 'Washington, DC'
AND EXISTS (
    SELECT *
    FROM airports
    WHERE airport_city = 'Other Cities'
    AND EXISTS (
        SELECT *
        FROM flights
        WHERE flight_date >= '2023-01-01'
        AND flight_date <= '2023-12-31'
        AND flight_from = 'Boston'
        AND flight_to = 'Washington, DC'
    )
);
SELECT *
FROM flights
WHERE departure_city = 'Dallas'
AND arrival_city = 'Oakland'
AND departure_time <= '12:00:00';
