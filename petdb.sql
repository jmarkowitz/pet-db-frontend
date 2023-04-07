


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
    occupation   varchar(150),
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




INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Franciska','Revens','consequat','sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede',2,'turpis adipiscing lorem vitae mattis nibh ligula nec sem duis','Denver','Colorado',80204,57,32);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Margette','Alves','at','nisl venenatis lacinia aenean sit amet justo morbi ut odio',3,'metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris','Monticello','Minnesota',55585,76,85);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Guthry','Bummfrey','mattis','dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet',3,'morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed','Palm Bay','Florida',32909,77,31);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Nicky','Birkwood','nibh','sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui',2,'dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque','Frankfort','Kentucky',40618,32,81);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Davida','Hannis','morbi','sed interdum venenatis turpis enim blandit mi in porttitor pede justo',2,'condimentum neque sapien placerat ante nulla justo aliquam quis turpis','San Diego','California',92121,79,26);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Antonino','Danielski','diam','venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat',3,'lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu','Toledo','Ohio',43635,20,70);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Benton','Gwin','consequat','tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus',3,'nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla','Miami','Florida',33261,65,3);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Vinnie','Huetson','sed','etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non',1,'phasellus in felis donec semper sapien a libero nam dui proin leo odio','San Francisco','California',94142,50,79);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Kennett','Tomaszek','proin','ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit',3,'nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit','Newark','New Jersey',07195,10,38);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Ozzie','Mayo','velit','primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio',1,'varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci','San Francisco','California',94142,11,32);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Jessica','Ashwood','cubilia','urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis',1,'turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam','Portland','Oregon',97296,38,41);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Evanne','Node','nisi','non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc',2,'integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus','Providence','Rhode Island',02912,67,11);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Cello','Tewelson','sem','sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer',2,'ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis','Fort Lauderdale','Florida',33330,18,44);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Philipa','Brewood','rutrum','lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa',1,'donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id','Pasadena','California',91117,95,99);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Harmonia','Dabel','bibendum','fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue',1,'pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra','Washington','District of Columbia',20036,52,16);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Ainslie','Lynthal','pharetra','rutrum neque aenean auctor gravida sem praesent id massa id',1,'sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus','New York City','New York',10009,2,23);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Dorita','Quantick','potenti','vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim',2,'id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque','Waterbury','Connecticut',06726,40,47);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Karly','Comusso','tempor','posuere cubilia curae nulla dapibus dolor vel est donec odio justo',3,'consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus','Fairfax','Virginia',22036,39,87);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Obediah','Wegenen','pellentesque','lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum',1,'a libero nam dui proin leo odio porttitor id consequat in consequat ut','Duluth','Georgia',30096,9,14);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,borrower_id,review_id) VALUES ('Yetta','Fetterplace','in','nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec',1,'pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet','San Jose','California',95194,36,66);

SELECT *
FROM Borrower;

#Pet provider
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (8,'Atlanta','Georgia',30311);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (83,'Berkeley','California',94705);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (56,'Chicago','Illinois',60609);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (98,'Kansas City','Missouri',64160);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (32,'Lincoln','Nebraska',68531);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (22,'Cincinnati','Ohio',45218);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (39,'Glendale','Arizona',85305);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (82,'Bonita Springs','Florida',34135);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (48,'Panama City','Florida',32412);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (86,'Philadelphia','Pennsylvania',19115);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (44,'Irvine','California',92619);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (38,'Cincinnati','Ohio',45208);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (21,'Rochester','New York',14639);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (72,'New York City','New York',10110);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (30,'Pittsburgh','Pennsylvania',15240);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (63,'Charlotte','North Carolina',28235);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (49,'Tulsa','Oklahoma',74126);
INSERT INTO PetServiceProviders(user_id,city,state,zip) VALUES (29,'Portsmouth','Virginia',23705);

SELECT *
FROM PetServiceProviders;
