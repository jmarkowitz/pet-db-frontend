CREATE DATABASE IF NOT EXISTS petdb;
USE petdb;

CREATE TABLE IF NOT EXISTS PetServiceProviders
(
    user_id INTEGER PRIMARY KEY,
    city    varchar(100),
    state   varchar(2),
    zip     INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS PetOwner
(
    first_name  varchar(50) NOT NULL,
    last_name   varchar(50) NOT NULL,
    age         int,
    city        varchar(50),
    state       varchar(50),
    zip         int,
    occupation  varchar(50),
    description text,
    user_id     int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS Experience
(
    psp_id        INTEGER NOT NULL,
    education     varchar(100),
    career        varchar(100),
    qualification varchar(100),
    city          varchar(100),
    state         varchar(50),
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
    description varchar(1000),
    CONSTRAINT fk_prvd_review
        FOREIGN KEY (psp_id) REFERENCES PetServiceProviders (user_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_user_review
        FOREIGN KEY (cust_id) REFERENCES PetOwner (user_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS Service
(
    user_id        INTEGER      NOT NULL,
    service_id     INTEGER PRIMARY KEY,
    type           varchar(100) NOT NULL,
    duration_hours INTEGER      NOT NULL,
    service_date   datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_userID
        FOREIGN KEY (user_id) REFERENCES PetServiceProviders (user_id)
            ON UPDATE CASCADE ON DELETE restrict
);


CREATE TABLE IF NOT EXISTS PetSpecies
(
    species_id   INTEGER PRIMARY KEY,
    species_name varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS PreferredPetSpecies
(
    service_id    INTEGER NOT NULL,
    species_id    INTEGER NOT NULL,
    vaccination   BOOLEAN NOT NULL,
    age           INTEGER NOT NULL,
    sterilization BOOLEAN,
    CONSTRAINT fk_serviceID
        FOREIGN KEY (service_id) REFERENCES Service (service_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_prefspeciesID
        FOREIGN KEY (species_id) REFERENCES PetSpecies (species_id)
            ON UPDATE CASCADE ON DELETE restrict
);


CREATE TABLE IF NOT EXISTS Pet
(
    color                  varchar(50) NOT NULL,
    vaccination            varchar(50) NOT NULL,
    sterilization          varchar(50) NOT NULL,
    borrowing_availability boolean     NOT NULL,
    age                    int         NOT NULL,
    species_id             int         NOT NULL,
    personality            varchar(1000),
    pet_id                 int PRIMARY KEY,
    CONSTRAINT fk_pet_speciesID
        FOREIGN KEY (species_id) REFERENCES PetSpecies (species_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS PetBreed
(
    species_id INTEGER     NOT NULL,
    breed_id   INTEGER     NOT NULL,
    breed_name varchar(50) NOT NULL,
    CONSTRAINT fk_speciesID
        FOREIGN KEY (species_id) REFERENCES PetSpecies (species_id)
            ON UPDATE CASCADE ON DELETE restrict
);


CREATE TABLE IF NOT EXISTS OwnerFriends
(
    user_id        int            NOT NULL,
    friend_num     INTEGER UNIQUE NOT NULL,
    friend_user_id int            NOT NULL,
    start_date     datetime DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_friend_userID
        FOREIGN KEY (user_id) REFERENCES PetOwner (user_id)
            ON UPDATE CASCADE ON DELETE restrict

);

CREATE TABLE IF NOT EXISTS OwnerPets
(
    user_id INTEGER NOT NULL,
    pet_num INTEGER NOT NULL,
    pet_id  INTEGER NOT NULL,
    CONSTRAINT fk_owner_userID
        FOREIGN KEY (user_id) REFERENCES PetOwner (user_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_petID
        FOREIGN KEY (pet_id) REFERENCES Pet (pet_id)
            ON UPDATE CASCADE ON DELETE restrict
);

CREATE TABLE IF NOT EXISTS Event
(
    description text,
    event_date  date,
    city        varchar(50),
    state       varchar(50),
    zip         varchar(50),
    event_id    int PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS OwnerEvents
(
    user_id  int,
    event_id int,
    CONSTRAINT fk_eventID
        FOREIGN KEY (event_id) REFERENCES Event (event_id)
            ON UPDATE CASCADE ON DELETE restrict,
    CONSTRAINT fk_userID1
        FOREIGN KEY (user_id) REFERENCES PetOwner (user_id)
);

CREATE TABLE IF NOT EXISTS Borrower
(
    first_name   varchar(50) NOT NULL,
    last_name    varchar(50) NOT NULL,
    availability varchar(50),
    occupation   varchar(50),
    age          int,
    description  text,
    city         varchar(50),
    state        varchar(50),
    zip          int,
    borrower_id  int PRIMARY KEY,
    review_id   INTEGER
);

CREATE TABLE IF NOT EXISTS BorrowerReview
(
    review_text varchar(100),
    pet_id      int,
    borrower_id INTEGER PRIMARY KEY,
    CONSTRAINT fk_review
        FOREIGN KEY (borrower_id) REFERENCES Borrower (borrower_id)
);



CREATE TABLE IF NOT EXISTS BorrowerPetPreferences
(
    species_id  int,
    type_id     int,
    habit_id    int,
    borrower_id int,
    PRIMARY KEY(habit_id, borrower_id),
    CONSTRAINT fk_borrowerid
        FOREIGN KEY (borrower_id) REFERENCES Borrower (borrower_id)
);


CREATE TABLE IF NOT EXISTS Habits
(
    habit_id    int PRIMARY KEY ,
    borrower_id int UNIQUE,
    description text,
    CONSTRAINT fk_habbit_id
        FOREIGN KEY (habit_id) REFERENCES BorrowerPetPreferences (habit_id),
    CONSTRAINT fk_borrower_id
        FOREIGN KEY (borrower_id) REFERENCES BorrowerPetPreferences (borrower_id)
);


CREATE TABLE IF NOT EXISTS BorrowerBorrow
(
    borrower_id int,
    pet_id      int,
    PRIMARY KEY (borrower_id, pet_id),
    CONSTRAINT fk_borrowerID_1
        FOREIGN KEY (borrower_id) REFERENCES Borrower (borrower_id),
    CONSTRAINT fk_petid_2
        FOREIGN KEY (pet_id) REFERENCES Pet (pet_id)
);
