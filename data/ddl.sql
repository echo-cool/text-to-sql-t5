CREATE TABLE "aircraft" (
	"aircraft_code" VARCHAR(3) NULL  ,
	"aircraft_description" VARCHAR(50) NULL  ,
	"manufacturer" VARCHAR(30) NULL  ,
	"basic_type" VARCHAR(30) NULL  ,
	"engines" INTEGER NULL  ,
	"propulsion" VARCHAR(10) NULL  ,
	"wide_body" VARCHAR(3) NULL  ,
	"wing_span" INTEGER NULL  ,
	"length" INTEGER NULL  ,
	"weight" INTEGER NULL  ,
	"capacity" INTEGER NULL  ,
	"pay_load" INTEGER NULL  ,
	"cruising_speed" INTEGER NULL  ,
	"range_miles" INTEGER NULL  ,
	"pressurized" VARCHAR(3) NULL
)

CREATE TABLE "airline" (
	"airline_code" VARCHAR(2) NULL  ,
	"airline_name" TEXT NULL  ,
	"note" TEXT NULL
)

CREATE TABLE "airport" (
	"airport_code" VARCHAR(3) NULL  ,
	"airport_name" TEXT NULL  ,
	"airport_location" TEXT NULL  ,
	"state_code" VARCHAR(2) NULL  ,
	"country_name" VARCHAR(6) NULL  ,
	"time_zone_code" VARCHAR(3) NULL  ,
	"minimum_connect_time" INTEGER NULL
)

CREATE TABLE "airport_service" (
	"city_code" VARCHAR(4) NULL  ,
	"airport_code" VARCHAR(3) NULL  ,
	"miles_distant" INTEGER NULL  ,
	"direction" VARCHAR(2) NULL  ,
	"minutes_distant" INTEGER NULL
)

CREATE TABLE "city" (
	"city_code" VARCHAR(4) NULL  ,
	"city_name" VARCHAR(18) NULL  ,
	"state_code" VARCHAR(2) NULL  ,
	"country_name" VARCHAR(6) NULL  ,
	"time_zone_code" VARCHAR(3) NULL
)

CREATE TABLE "class_of_service" (
	"booking_class" VARCHAR(2) NOT NULL DEFAULT '' ,
	"rank" INTEGER NULL  ,
	"class_description" TEXT NULL  ,
	PRIMARY KEY ("booking_class")
)

CREATE TABLE "code_description" (
	"code" VARCHAR(4) NOT NULL DEFAULT '' ,
	"description" TEXT NULL  ,
	PRIMARY KEY ("code")
)

CREATE TABLE "compartment_class" (
	"compartment" VARCHAR(5) NULL  ,
	"class_type" VARCHAR(8) NULL
)

CREATE TABLE "date_day" (
	"month_number" INTEGER NULL  ,
	"day_number" INTEGER NULL  ,
	"year" INTEGER NULL  ,
	"day_name" VARCHAR(10) NULL
)

CREATE TABLE "days" (
	"days_code" VARCHAR(20) NULL  ,
	"day_name" VARCHAR(10) NULL
)

CREATE TABLE "dual_carrier" (
	"main_airline" VARCHAR(2) NULL  ,
	"low_flight_number" INTEGER NULL  ,
	"high_flight_number" INTEGER NULL  ,
	"dual_airline" VARCHAR(2) NULL  ,
	"service_name" TEXT NULL
)

CREATE TABLE "equipment_sequence" (
	"aircraft_code_sequence" VARCHAR(12) NULL  ,
	"aircraft_code" VARCHAR(3) NULL
)

CREATE TABLE "fare" (
	"fare_id" INTEGER NOT NULL DEFAULT '0' ,
	"from_airport" VARCHAR(3) NULL  ,
	"to_airport" VARCHAR(3) NULL  ,
	"fare_basis_code" TEXT NULL  ,
	"fare_airline" TEXT NULL  ,
	"restriction_code" TEXT NULL  ,
	"one_direction_cost" INTEGER NULL  ,
	"round_trip_cost" INTEGER NULL  ,
	"round_trip_required" VARCHAR(3) NULL  ,
	PRIMARY KEY ("fare_id")
)

CREATE TABLE "fare_basis" (
	"fare_basis_code" TEXT NULL  ,
	"booking_class" TEXT NULL  ,
	"class_type" TEXT NULL  ,
	"premium" TEXT NULL  ,
	"economy" TEXT NULL  ,
	"discounted" TEXT NULL  ,
	"night" TEXT NULL  ,
	"season" TEXT NULL  ,
	"basis_days" TEXT NULL
)

CREATE TABLE "flight" (
	"flight_id" INTEGER NOT NULL DEFAULT '0' ,
	"flight_days" TEXT NULL  ,
	"from_airport" VARCHAR(3) NULL  ,
	"to_airport" VARCHAR(3) NULL  ,
	"departure_time" INTEGER NULL  ,
	"arrival_time" INTEGER NULL  ,
	"airline_flight" TEXT NULL  ,
	"airline_code" VARCHAR(3) NULL  ,
	"flight_number" INTEGER NULL  ,
	"aircraft_code_sequence" TEXT NULL  ,
	"meal_code" TEXT NULL  ,
	"stops" INTEGER NULL  ,
	"connections" INTEGER NULL  ,
	"dual_carrier" TEXT NULL  ,
	"time_elapsed" INTEGER NULL  ,
	PRIMARY KEY ("flight_id")
)

CREATE TABLE "flight_fare" (
	"flight_id" INTEGER NULL  ,
	"fare_id" INTEGER NULL
)

CREATE TABLE "flight_leg" (
	"flight_id" INTEGER NULL  ,
	"leg_number" INTEGER NULL  ,
	"leg_flight" INTEGER NULL
)

CREATE TABLE "flight_stop" (
	"flight_id" INTEGER NULL  ,
	"stop_number" INTEGER NULL  ,
	"stop_days" TEXT NULL  ,
	"stop_airport" TEXT NULL  ,
	"arrival_time" INTEGER NULL  ,
	"arrival_airline" TEXT NULL  ,
	"arrival_flight_number" INTEGER NULL  ,
	"departure_time" INTEGER NULL  ,
	"departure_airline" TEXT NULL  ,
	"departure_flight_number" INTEGER NULL  ,
	"stop_time" INTEGER NULL
)

CREATE TABLE "food_service" (
	"meal_code" TEXT NULL  ,
	"meal_number" INTEGER NULL  ,
	"compartment" TEXT NULL  ,
	"meal_description" VARCHAR(10) NULL
)

CREATE TABLE "ground_service" (
	"city_code" TEXT NULL  ,
	"airport_code" TEXT NULL  ,
	"transport_type" TEXT NULL  ,
	"ground_fare" INTEGER NULL
)

CREATE TABLE "month" (
	"month_number" INTEGER NULL  ,
	"month_name" TEXT NULL
)

CREATE TABLE "restriction" (
	"restriction_code" TEXT NULL  ,
	"advance_purchase" INTEGER NULL  ,
	"stopovers" TEXT NULL  ,
	"saturday_stay_required" TEXT NULL  ,
	"minimum_stay" INTEGER NULL  ,
	"maximum_stay" INTEGER NULL  ,
	"application" TEXT NULL  ,
	"no_discounts" TEXT NULL
)

CREATE TABLE "state" (
	"state_code" TEXT NULL  ,
	"state_name" TEXT NULL  ,
	"country_name" TEXT NULL
)

CREATE TABLE "time_interval" (
	"period" TEXT NULL  ,
	"begin_time" INTEGER NULL  ,
	"end_time" INTEGER NULL
)

CREATE TABLE "time_zone" (
	"time_zone_code" TEXT NULL  ,
	"time_zone_name" TEXT NULL  ,
	"hours_from_gmt" INTEGER NULL
)

