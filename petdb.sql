CREATE DATABASE petdb;
USE petdb;


CREATE TABLE Pet (
   color varchar(50) NOT NULL,
   vaccination varchar(50) NOT NULL,
   sterilization varchar(50) NOT NULL,
   borrowing_availability boolean NOT NULL,
   age int,
   breed_id int,
   species_id int,
   personality varchar(100),
   pet_id int PRIMARY KEY
);

CREATE TABLE Pet_Owner (
   first_name varchar(50) NOT NULL,
   last_name varchar(50) NOT NULL,
   age int,
   city varchar(50),
   state varchar(50),
   zip int,
   occupation varchar(50),
   description text,
   user_id int PRIMARY KEY
);

CREATE TABLE Borrower (
   first_name varchar(50) NOT NULL,
   last_name varchar(50) NOT NULL,
   availability varchar(50),
   occupation varchar(50),
   age int,
   description text,
   city varchar(50),
   state varchar(50),
   zip int,
   borrower_id int PRIMARY KEY
);

CREATE TABLE Borrower_Review (
   review_text varchar(100),
   pet_id int PRIMARY KEY
);

CREATE TABLE Event (
   description text,
   event_date date,
   city varchar(50),
   state varchar(50),
   zip varchar(50),
   event_id int PRIMARY KEY
);

CREATE TABLE Borrower_Pet_Preferences (
    species_id int,
    type_id int,
    habit_id int,
    borrower_id int PRIMARY KEY
);

CREATE TABLE Habits (
    borrower_id int,
    habit_id int,
    description text
);

CREATE TABLE Owner_Events (
   user_id int,
   event_id int
);

CREATE TABLE Owner_Friends (
    user_id int PRIMARY KEY,
    friend_user_id int PRIMARY KEY
);

CREATE TABLE Friends (
    friend_user_id int,
    start_date date
);

CREATE TABLE Borrower_Borrow (
    borrower_id int PRIMARY KEY,
    pet_id int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS PetServiceProviders
(
    user_id INTEGER PRIMARY KEY,
    city    varchar(100),
    state   varchar(2),
    zip     INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS Experience
(
    psp_id        INTEGER NOT NULL,
    education     varchar(100),
    career        varchar(100),
    qualification varchar(100),
    city          varchar(100),
    state         varchar(2),
    zip           INTEGER NOT NULL,
    CONSTRAINT fk_pspID
        FOREIGN KEY (psp_id) REFERENCES PetServiceProviders (user_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS ProviderReview
(
    psp_id      INTEGER NOT NULL,
    cust_id     INTEGER NOT NULL,
    rating      varchar(100),
    CHECK ( rating BETWEEN 1 AND 5),
    description varchar(1000)
);

CREATE TABLE IF NOT EXISTS Service
(
    user_id        INTEGER      NOT NULL,
    service_id     INTEGER PRIMARY KEY,
    type           varchar(100) NOT NULL,
    duration_hours INTEGER      NOT NULL,
    service_date   datetime DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS PreferredPetSpecies
(
    service_id    INTEGER NOT NULL,
    species_id    INTEGER NOT NULL,
    vaccination   BOOLEAN,
    age           INTEGER NOT NULL,
    sterilization BOOLEAN
);

CREATE TABLE IF NOT EXISTS OwnerPets
(
    user_id INTEGER NOT NULL,
    pet_num INTEGER NOT NULL,
    pet_id  INTEGER NOT NULL
)




