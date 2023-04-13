


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





INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ursa','Oels',88,'Knoxville','Tennessee',37995,'vestibulum sit','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',1);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cordula','Cassedy',77,'Sacramento','California',95813,'curae nulla dapibus dolor vel','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',2);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Madonna','Davisson',26,'New Brunswick','New Jersey',08922,'duis mattis egestas metus','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.',3);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Clara','Fallon',32,'Anchorage','Alaska',99507,'in sapien iaculis','In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.',4);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cristen','Laurisch',34,'Portland','Oregon',97216,'donec odio','Sed ante. Vivamus tortor. Duis mattis egestas metus.',5);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Allyn','Rambaut',38,'Lexington','Kentucky',40524,'ultrices phasellus id sapien','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',6);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Earl','Impey',44,'Birmingham','Alabama',35231,'at turpis donec posuere','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.',7);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Marjie','Gavrielli',58,'Waco','Texas',76796,'dis parturient montes nascetur ridiculus','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',8);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Allie','Schoular',36,'Davenport','Iowa',52809,'at lorem integer','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',9);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ingeberg','Minger',82,'San Jose','California',95118,'placerat ante nulla justo','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',10);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Moria','Kurth',48,'Des Moines','Iowa',50335,'imperdiet sapien','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.',11);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Aguste','Lashley',40,'Philadelphia','Pennsylvania',19151,'turpis sed ante vivamus','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',12);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Baxy','Petroff',27,'Phoenix','Arizona',85035,'donec posuere metus vitae','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',13);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cinderella','Vere',34,'Seattle','Washington',98127,'ligula in lacus curabitur','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',14);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Roderich','Adlam',23,'Grand Rapids','Michigan',49505,'morbi ut','Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.',15);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lauren','Whitington',64,'Boise','Idaho',83722,'dui vel nisl duis ac','Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.',16);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Kaylyn','Bursell',83,'Jamaica','New York',11480,'turpis enim blandit mi','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',17);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Nan','Platfoot',83,'Phoenix','Arizona',85010,'quisque erat eros','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',18);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Jakob','Pickworth',31,'San Antonio','Texas',78265,'nulla nisl nunc','Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.',19);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Oby','Beverley',67,'Sacramento','California',94280,'neque aenean auctor','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',20);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Rosabelle','Flippen',56,'Las Vegas','Nevada',89166,'massa quis','In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.',21);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Maddie','Theze',67,'Roanoke','Virginia',24048,'parturient montes nascetur','Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.',22);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lexie','de Castelain',74,'El Paso','Texas',88574,'duis at velit eu','Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.',23);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Luciano','Gilleon',19,'Oklahoma City','Oklahoma',73119,'nisl venenatis','Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.',24);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Arty','Robbie',33,'Wichita','Kansas',67236,'congue eget semper rutrum nulla','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',25);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ryon','Joscelin',40,'San Diego','California',92105,'id mauris','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.',26);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Maison','Stell',81,'Saginaw','Michigan',48609,'sapien in','Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.',27);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Uriel','Widdison',87,'Denver','Colorado',80270,'scelerisque mauris sit amet eros','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',28);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Gayleen','Mowne',63,'Louisville','Kentucky',40225,'amet sem fusce','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',29);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Jobina','Bullivent',80,'Knoxville','Tennessee',37931,'laoreet ut','Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.',30);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Ferrel','Marcum',42,'Bellevue','Washington',98008,'nibh in lectus','Fusce consequat. Nulla nisl. Nunc nisl.',31);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Francisca','O''Shaughnessy',39,'Kansas City','Missouri',64160,'ultrices aliquet','Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.',32);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Violante','Atlee',73,'Wilmington','North Carolina',28410,'ut mauris','In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.',33);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Christos','Vidineev',71,'Austin','Texas',78769,'dolor sit amet consectetuer adipiscing','Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.',34);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Madlen','Berthouloume',70,'Colorado Springs','Colorado',80951,'ultricies eu','Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.',35);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Benjie','Gurry',25,'Tulsa','Oklahoma',74156,'habitasse platea dictumst etiam','Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.',36);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Melicent','Biss',44,'Manassas','Virginia',22111,'lectus aliquam sit amet','Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.',37);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Julie','Burn',38,'Saint Paul','Minnesota',55103,'in consequat ut nulla','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.',38);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Aleen','Mawne',35,'Birmingham','Alabama',35285,'laoreet ut rhoncus aliquet','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',39);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Kirstin','Audibert',17,'Springfield','Massachusetts',01105,'congue vivamus','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',40);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Liz','Barnson',49,'Mobile','Alabama',36628,'suspendisse ornare consequat','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',41);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cybill','Smaridge',83,'Saint Petersburg','Florida',33731,'porta volutpat erat quisque','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',42);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cicely','Dinnington',77,'Kalamazoo','Michigan',49048,'mauris sit amet eros','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',43);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Larissa','Westmerland',49,'Salt Lake City','Utah',84152,'nisl ut','Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.',44);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Sawyer','Bothram',56,'Fort Worth','Texas',76105,'nascetur ridiculus mus etiam vel','Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.',45);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lewie','Lacrouts',70,'Homestead','Florida',33034,'id justo sit','Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.',46);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Livvy','Oppy',85,'Austin','Texas',78764,'nulla suspendisse potenti cras in','Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.',47);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Leila','Tooher',56,'Littleton','Colorado',80126,'dolor vel est donec','Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.',48);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Lynelle','Walasik',44,'San Antonio','Texas',78291,'vestibulum ante ipsum','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',49);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Susana','Riddle',19,'Torrance','California',90510,'lorem vitae mattis nibh ligula','Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.',50);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Everett','Rarity',89,'Baltimore','Maryland',21239,'vestibulum ante ipsum primis in','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',51);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Billy','Biggadyke',16,'Roanoke','Virginia',24048,'platea dictumst','Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.',52);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Rodney','Klaes',44,'Salt Lake City','Utah',84140,'a libero','Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.',53);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Cornie','O''Gavin',51,'Boulder','Colorado',80310,'sem duis aliquam convallis nunc','Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.',54);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Caz','Durante',88,'New Orleans','Louisiana',70116,'parturient montes nascetur','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.',55);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Dolorita','Baskeyfied',18,'Oklahoma City','Oklahoma',73173,'mus etiam vel augue','Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.',56);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Kristos','Wall',52,'Raleigh','North Carolina',27690,'sapien in','Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.',57);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Laurie','McQuarter',48,'Hattiesburg','Mississippi',39404,'curae mauris viverra diam','Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.',58);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Portia','Zimmermeister',44,'Eugene','Oregon',97405,'congue eget semper','Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.',59);
INSERT INTO PetOwner(first_name,last_name,age,city,state,zip,occupation,description,user_id) VALUES ('Norene','Thomassen',80,'Fort Wayne','Indiana',46805,'sem duis aliquam','Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.',60);



INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy','2022-10-25','Louisville','Kentucky',40280,1);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mi pede malesuada in imperdiet et commodo vulputate justo in','2022-10-26','New Haven','Connecticut',06520,2);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed','2023-02-22','Honolulu','Hawaii',96825,3);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi','2023-02-25','Tampa','Florida',33610,4);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ut erat id mauris vulputate elementum nullam varius nulla facilisi cras','2022-04-21','Phoenix','Arizona',85053,5);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus','2022-09-24','New York City','New York',10184,6);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id','2023-01-15','Pittsburgh','Pennsylvania',15210,7);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit','2022-04-26','Lakewood','Washington',98498,8);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula','2023-03-29','Bradenton','Florida',34210,9);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum','2022-08-18','Stockton','California',95205,10);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat','2022-10-24','San Francisco','California',94110,11);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui','2022-09-09','Akron','Ohio',44321,12);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi','2022-07-30','Cape Coral','Florida',33915,13);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in','2022-11-03','Toledo','Ohio',43699,14);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus','2022-09-10','Evansville','Indiana',47719,15);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non','2022-06-03','Lincoln','Nebraska',68583,16);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus','2022-05-29','Columbus','Ohio',43220,17);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt','2022-05-10','Portland','Oregon',97296,18);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet','2023-01-11','Fort Wayne','Indiana',46857,19);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue','2022-07-17','Charleston','South Carolina',29403,20);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie','2022-05-12','Greensboro','North Carolina',27409,21);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum','2022-07-06','Bronx','New York',10454,22);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec','2022-12-31','New York City','New York',10110,23);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam','2023-03-06','Aurora','Illinois',60505,24);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id','2022-11-25','Tucson','Arizona',85705,25);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum','2022-09-03','Washington','District of Columbia',20580,26);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros','2023-03-10','Dayton','Ohio',45419,27);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor','2022-08-03','Orlando','Florida',32891,28);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis','2023-03-08','Charleston','South Carolina',29424,29);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate','2022-04-29','Fredericksburg','Virginia',22405,30);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit','2022-11-06','Farmington','Michigan',48335,31);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id','2022-10-31','New York City','New York',10079,32);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante','2023-03-08','Omaha','Nebraska',68110,33);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis','2023-01-31','Kansas City','Missouri',64142,34);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis','2022-12-12','Houston','Texas',77234,35);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis','2022-12-25','Las Vegas','Nevada',89145,36);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu','2022-10-12','Austin','Texas',78710,37);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus','2022-05-11','Grand Forks','North Dakota',58207,38);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices','2022-11-13','Grand Rapids','Michigan',49518,39);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris','2022-12-10','Athens','Georgia',30610,40);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec','2023-01-02','Cleveland','Ohio',44125,41);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet','2023-01-30','Utica','New York',13505,42);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at','2022-10-19','Scottsdale','Arizona',85255,43);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam','2022-07-25','Lincoln','Nebraska',68583,44);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa','2022-12-31','Huntington','West Virginia',25716,45);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit','2023-01-16','Appleton','Wisconsin',54915,46);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt','2022-05-12','Akron','Ohio',44315,47);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat','2023-02-02','Baton Rouge','Louisiana',70805,48);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis','2022-10-18','Denver','Colorado',80209,49);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa','2022-08-31','Marietta','Georgia',30066,50);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget','2023-01-07','Miami','Florida',33233,51);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa','2023-01-04','Pittsburgh','Pennsylvania',15230,52);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est','2022-10-18','Farmington','Michigan',48335,53);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla','2022-12-02','Maple Plain','Minnesota',55572,54);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque','2023-03-08','El Paso','Texas',79968,55);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in','2023-03-20','New Haven','Connecticut',06538,56);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante','2022-10-10','Washington','District of Columbia',20062,57);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus','2022-10-29','Indianapolis','Indiana',46247,58);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend','2022-05-14','Saint Louis','Missouri',63150,59);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam','2023-01-20','Phoenix','Arizona',85015,60);



INSERT INTO OwnerEvents(user_id,event_id) VALUES (7,24);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (4,5);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (12,21);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (46,42);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (1,2);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (18,11);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (47,36);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (38,48);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (3,47);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (40,44);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (57,52);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (14,39);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (39,1);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (28,26);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (11,17);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (26,54);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (53,15);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (52,28);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (44,13);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (51,25);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (35,9);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (9,57);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (32,8);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (19,41);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (48,51);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (55,14);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (59,18);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (37,29);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (24,40);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (41,38);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (31,59);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (34,46);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (27,19);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (17,22);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (6,30);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (30,4);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (10,7);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (45,49);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (54,37);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (2,16);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (8,34);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (50,23);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (22,55);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (43,45);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (29,35);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (16,32);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (23,53);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (58,31);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (36,20);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (15,56);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (21,33);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (20,3);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (56,60);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (13,6);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (5,58);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (25,43);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (42,50);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (49,10);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (33,27);
INSERT INTO OwnerEvents(user_id,event_id) VALUES (60,12);



INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (54,718,'2022-11-26');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (46,391,'2022-04-30');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (32,480,'2023-02-14');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (30,652,'2022-12-21');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (27,661,'2022-06-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (34,170,'2022-07-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (48,439,'2023-03-18');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (49,99,'2023-03-17');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (3,561,'2023-02-13');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (2,857,'2022-05-11');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (59,83,'2022-12-29');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (20,199,'2022-04-07');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (14,680,'2023-01-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (1,465,'2022-07-16');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (35,247,'2022-05-24');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (10,101,'2022-09-07');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (21,159,'2022-04-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (60,409,'2023-02-24');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (5,833,'2022-06-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (47,85,'2023-01-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (36,230,'2022-07-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (43,434,'2022-07-22');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (50,880,'2023-04-01');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (41,63,'2023-03-12');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (29,176,'2022-06-17');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (55,372,'2022-04-13');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (45,856,'2022-06-17');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (51,204,'2022-10-12');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (16,977,'2022-05-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (33,659,'2022-07-12');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (8,637,'2022-06-18');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (12,695,'2023-02-15');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (37,95,'2022-08-03');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (53,575,'2022-04-13');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (17,276,'2022-08-01');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (39,131,'2022-11-02');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (57,664,'2023-03-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (44,708,'2022-09-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (6,90,'2022-07-06');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (9,691,'2022-04-25');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (23,583,'2023-03-11');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (38,972,'2023-03-15');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (22,809,'2022-11-27');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (56,465,'2022-05-20');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (4,778,'2022-12-02');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (19,255,'2022-11-26');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (7,460,'2023-01-08');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (11,876,'2022-11-14');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (31,483,'2022-05-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (40,593,'2022-09-16');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (26,310,'2022-10-26');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (25,337,'2022-10-14');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (52,772,'2022-07-19');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (18,302,'2023-01-24');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (42,59,'2023-01-15');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (24,196,'2023-03-28');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (58,408,'2022-04-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (28,970,'2022-06-09');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (15,374,'2022-06-27');
INSERT INTO OwnerFriends(user_id,friend_user_id,start_date) VALUES (13,702,'2022-11-27');



INSERT INTO PetSpecies(species_id,species_name) VALUES (1,'Yellow-headed caracara');
INSERT INTO PetSpecies(species_id,species_name) VALUES (2,'Suricate');
INSERT INTO PetSpecies(species_id,species_name) VALUES (3,'Oribi');
INSERT INTO PetSpecies(species_id,species_name) VALUES (4,'Corella, long-billed');
INSERT INTO PetSpecies(species_id,species_name) VALUES (5,'Tern, royal');
INSERT INTO PetSpecies(species_id,species_name) VALUES (6,'Eagle, golden');
INSERT INTO PetSpecies(species_id,species_name) VALUES (7,'Crane, sarus');
INSERT INTO PetSpecies(species_id,species_name) VALUES (8,'Rat, arboral spiny');
INSERT INTO PetSpecies(species_id,species_name) VALUES (9,'Eagle, bateleur');
INSERT INTO PetSpecies(species_id,species_name) VALUES (10,'Southern lapwing');
INSERT INTO PetSpecies(species_id,species_name) VALUES (11,'Fox, savanna');
INSERT INTO PetSpecies(species_id,species_name) VALUES (12,'Long-crested hawk eagle');
INSERT INTO PetSpecies(species_id,species_name) VALUES (13,'European red squirrel');
INSERT INTO PetSpecies(species_id,species_name) VALUES (14,'Shrike, common boubou');
INSERT INTO PetSpecies(species_id,species_name) VALUES (15,'Tammar wallaby');
INSERT INTO PetSpecies(species_id,species_name) VALUES (16,'Coqui partridge');
INSERT INTO PetSpecies(species_id,species_name) VALUES (17,'American bighorn sheep');
INSERT INTO PetSpecies(species_id,species_name) VALUES (18,'Australian spiny anteater');
INSERT INTO PetSpecies(species_id,species_name) VALUES (19,'Jackal, asiatic');
INSERT INTO PetSpecies(species_id,species_name) VALUES (20,'Wallaby, tammar');
INSERT INTO PetSpecies(species_id,species_name) VALUES (21,'Wallaby, red-necked');
INSERT INTO PetSpecies(species_id,species_name) VALUES (22,'Stork, marabou');
INSERT INTO PetSpecies(species_id,species_name) VALUES (23,'Trumpeter swan');
INSERT INTO PetSpecies(species_id,species_name) VALUES (24,'Swan, trumpeter');
INSERT INTO PetSpecies(species_id,species_name) VALUES (25,'Snowy sheathbill');
INSERT INTO PetSpecies(species_id,species_name) VALUES (26,'Springbok');
INSERT INTO PetSpecies(species_id,species_name) VALUES (27,'Bear, american black');
INSERT INTO PetSpecies(species_id,species_name) VALUES (28,'Lemur, sportive');
INSERT INTO PetSpecies(species_id,species_name) VALUES (29,'Dragon, asian water');
INSERT INTO PetSpecies(species_id,species_name) VALUES (30,'Lemming, arctic');
INSERT INTO PetSpecies(species_id,species_name) VALUES (31,'Turkey, common');
INSERT INTO PetSpecies(species_id,species_name) VALUES (32,'Cobra, cape');
INSERT INTO PetSpecies(species_id,species_name) VALUES (33,'Thirteen-lined squirrel');
INSERT INTO PetSpecies(species_id,species_name) VALUES (34,'American beaver');
INSERT INTO PetSpecies(species_id,species_name) VALUES (35,'Finch, common melba');
INSERT INTO PetSpecies(species_id,species_name) VALUES (36,'Pronghorn');
INSERT INTO PetSpecies(species_id,species_name) VALUES (37,'Rat, arboral spiny');
INSERT INTO PetSpecies(species_id,species_name) VALUES (38,'Tortoise, desert');
INSERT INTO PetSpecies(species_id,species_name) VALUES (39,'Wolf spider');
INSERT INTO PetSpecies(species_id,species_name) VALUES (40,'Tarantula');
INSERT INTO PetSpecies(species_id,species_name) VALUES (41,'Black-capped capuchin');
INSERT INTO PetSpecies(species_id,species_name) VALUES (42,'Wallaby, red-necked');
INSERT INTO PetSpecies(species_id,species_name) VALUES (43,'Pigeon, wood');
INSERT INTO PetSpecies(species_id,species_name) VALUES (44,'Robin, white-throated');
INSERT INTO PetSpecies(species_id,species_name) VALUES (45,'Galapagos penguin');
INSERT INTO PetSpecies(species_id,species_name) VALUES (46,'Duiker, common');
INSERT INTO PetSpecies(species_id,species_name) VALUES (47,'Bandicoot, short-nosed');
INSERT INTO PetSpecies(species_id,species_name) VALUES (48,'South African hedgehog');
INSERT INTO PetSpecies(species_id,species_name) VALUES (49,'Quoll, spotted-tailed');
INSERT INTO PetSpecies(species_id,species_name) VALUES (50,'Eagle, bateleur');
INSERT INTO PetSpecies(species_id,species_name) VALUES (51,'Crane, sarus');
INSERT INTO PetSpecies(species_id,species_name) VALUES (52,'Owl, snowy');
INSERT INTO PetSpecies(species_id,species_name) VALUES (53,'Raven, cape');
INSERT INTO PetSpecies(species_id,species_name) VALUES (54,'Vulture, bengal');
INSERT INTO PetSpecies(species_id,species_name) VALUES (55,'Rufous-collared sparrow');
INSERT INTO PetSpecies(species_id,species_name) VALUES (56,'Currasow (unidentified)');
INSERT INTO PetSpecies(species_id,species_name) VALUES (57,'Bee-eater, nubian');
INSERT INTO PetSpecies(species_id,species_name) VALUES (58,'Fairy penguin');
INSERT INTO PetSpecies(species_id,species_name) VALUES (59,'White-tailed jackrabbit');
INSERT INTO PetSpecies(species_id,species_name) VALUES (60,'Goliath heron');

SELECT *
FROM PetOwner;
