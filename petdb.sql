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
    review_text text,
    pet_id      int,
    borrower_id INTEGER,
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


INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Amery','Raggles','habitasse','nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa',2,'sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','Richmond','Virginia',23293,1,1);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Kakalina','Wootton','eu','tortor id nulla ultrices aliquet maecenas leo odio condimentum id',1,'dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor','Stamford','Connecticut',06912,2,2);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Hardy','Airlie','at','amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu',3,'a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla','Tulsa','Oklahoma',74141,3,3);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Giusto','Simpole','odio','ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel',2,'pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus','Bridgeport','Connecticut',06606,4,4);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Carlina','Canadine','lectus','integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus',3,'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse','Fort Smith','Arkansas',72905,5,5);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Jordana','Wishkar','sagittis','nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla',2,'sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et','Laurel','Maryland',20709,6,6);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Micah','Phillips','est','nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae',1,'dolor vel est donec odio justo sollicitudin ut suscipit a feugiat','Fresno','California',93721,7,7);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Tremain','Egdell','suscipit','pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus',3,'felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis','Erie','Pennsylvania',16522,8,8);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Catie','Grieswood','faucibus','blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer',2,'amet cursus id turpis integer aliquet massa id lobortis convallis tortor','Memphis','Tennessee',38109,9,9);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nell','Dobeson','ultrices','purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam',3,'luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis','Columbus','Ohio',43210,10,10);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Micaela','Insoll','congue','amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in',3,'pede ullamcorper augue a suscipit nulla elit ac nulla sed','Washington','District of Columbia',20268,11,11);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Diannne','Krout','ac','aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec',3,'faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis','New York City','New York',10019,12,12);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Anni','Jancik','vel','ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula',1,'tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas','Beaumont','Texas',77705,13,13);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Lammond','Hathway','nisi','ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat',3,'quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor','Wichita','Kansas',67220,14,14);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Hussein','Wozencroft','consequat','libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis',3,'morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque','Huntington','West Virginia',25721,15,15);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Minetta','Guare','magnis','fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies',3,'imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo','San Diego','California',92137,16,16);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Barclay','Cicero','vitae','ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est',3,'ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus','Pueblo','Colorado',81005,17,17);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Demetris','Odgers','nulla','nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam',3,'imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit','Akron','Ohio',44321,18,18);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Gherardo','Murfett','in','nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac',3,'in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut','Jeffersonville','Indiana',47134,19,19);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Adah','Harradine','arcu','mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc rhoncus dui vel sem',1,'integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante','New Orleans','Louisiana',70183,20,20);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Seward','Spry','praesent','sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis',3,'quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus','Portsmouth','New Hampshire',00214,21,21);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Clemmy','Kilsby','aliquet','eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero',1,'sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh','El Paso','Texas',79945,22,22);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Fidelia','Adame','tortor','quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris',1,'suscipit nulla elit ac nulla sed vel enim sit amet','Racine','Wisconsin',53405,23,23);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Dominick','Maving','ornare','potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus',2,'sapien a libero nam dui proin leo odio porttitor id consequat in','Battle Creek','Michigan',49018,24,24);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Rayshell','Oolahan','condimentum','varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper',3,'elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas','Escondido','California',92030,25,25);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Ashla','Commuzzo','platea','felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut',2,'posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit','Cleveland','Ohio',44118,26,26);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Onfroi','Marre','eu','mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum',2,'primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio','Arlington','Virginia',22244,27,27);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Madlin','De Antoni','nulla','molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae',1,'nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec','Orange','California',92867,28,28);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Lyman','Postlethwaite','at','sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec',2,'ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus','Atlanta','Georgia',30306,29,29);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Diannne','Govey','primis','iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus',3,'volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum','San Francisco','California',94105,30,30);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Giraldo','Delacroux','suspendisse','parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes',1,'nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam','Washington','District of Columbia',20062,31,31);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nanci','Timpany','consequat','eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien',3,'eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue','Trenton','New Jersey',08695,32,32);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Stacia','Churm','iaculis','quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis',2,'nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','Seattle','Washington',98185,33,33);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Clerissa','Shurman','risus','ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras',3,'aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum','Colorado Springs','Colorado',80995,34,34);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Mirabel','McClarence','quisque','mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed',1,'a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel','Pensacola','Florida',32526,35,35);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Othilie','Fydo','blandit','ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus',3,'enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem','Norfolk','Virginia',23504,36,36);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Rosalyn','Connaughton','morbi','proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut',2,'sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in','Charleston','West Virginia',25321,37,37);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Eryn','Jesteco','nibh','in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis',1,'etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut','Detroit','Michigan',48258,38,38);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Gaby','Ness','ipsum','vehicula consequat morbi a ipsum integer a nibh in quis',3,'aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis','Baltimore','Maryland',21281,39,39);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Maddalena','Toke','mattis','vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non',1,'nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris','San Luis Obispo','California',93407,40,40);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Fina','Hyett','ultrices','sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel',1,'a libero nam dui proin leo odio porttitor id consequat in','Aurora','Illinois',60505,41,41);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Ethelyn','Engley','est','aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem',2,'parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient','Boise','Idaho',83716,42,42);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Willie','Gayle','habitasse','augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit',1,'id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam','Fresno','California',93778,43,43);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Traver','Bellchamber','vestibulum','ut suscipit a feugiat et eros vestibulum ac est lacinia',1,'lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis','Charlottesville','Virginia',22908,44,44);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Claire','Call','quam','gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo',3,'mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a','Mc Keesport','Pennsylvania',15134,45,45);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Legra','Arrigucci','magnis','nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit',3,'augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc','Salt Lake City','Utah',84152,46,46);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Catrina','Daveley','donec','dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper',1,'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non','Birmingham','Alabama',35236,47,47);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nikolas','De Malchar','consequat','eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante',2,'a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices','San Diego','California',92170,48,48);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Julio','Shortin','nunc','sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum',1,'nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate','Amarillo','Texas',79118,49,49);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Anatola','Cappel','eu','ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac',1,'sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede','Springfield','Massachusetts',01129,50,50);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Lulu','Shute','semper','luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat',3,'id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget','Provo','Utah',84605,51,51);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Walsh','Seeley','congue','curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum',3,'est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum','Oklahoma City','Oklahoma',73147,52,52);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Henderson','Richie','nisl','euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem',2,'ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero rutrum ac lobortis','Corpus Christi','Texas',78415,53,53);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Brucie','Ferminger','massa','morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus',3,'rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin','Fairfield','Connecticut',06825,54,54);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Nisse','Sprake','volutpat','sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae',3,'eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien','Atlanta','Georgia',31165,55,55);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Berti','Craiker','erat','in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius',3,'hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget','Springfield','Massachusetts',01114,56,56);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Enos','Frood','consequat','in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing',3,'vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','Las Vegas','Nevada',89155,57,57);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Pall','Reinbeck','neque','fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum',2,'donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue','Grand Forks','North Dakota',58207,58,58);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Clifford','Osmund','luctus','tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu',2,'iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla','Houston','Texas',77060,59,59);
INSERT INTO Borrower(first_name,last_name,availability,occupation,age,description,city,state,zip,review_id,borrower_id) VALUES ('Raff','Ponting','sapien','non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet',3,'dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis','Albuquerque','New Mexico',87115,60,60);

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


INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (1,1,1,58);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (2,2,2,35);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (3,3,3,11);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (4,4,4,39);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (5,5,5,30);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (6,6,6,1);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (7,7,7,4);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (8,8,8,59);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (9,9,9,55);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (10,10,10,27);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (11,11,11,48);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (12,12,12,35);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (13,13,13,2);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (14,14,14,40);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (15,15,15,60);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (16,16,16,5);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (17,17,17,36);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (18,18,18,51);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (19,19,19,44);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (20,20,20,29);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (21,21,21,50);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (22,22,22,33);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (23,23,23,35);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (24,24,24,37);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (25,25,25,7);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (26,26,26,56);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (27,27,27,41);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (28,28,28,13);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (29,29,29,24);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (30,30,30,17);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (31,31,31,42);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (32,32,32,9);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (33,33,33,33);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (34,34,34,7);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (35,35,35,8);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (36,36,36,25);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (37,37,37,53);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (38,38,38,27);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (39,39,39,10);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (40,40,40,11);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (41,41,41,4);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (42,42,42,49);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (43,43,43,7);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (44,44,44,57);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (45,45,45,24);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (46,46,46,58);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (47,47,47,33);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (48,48,48,20);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (49,49,49,23);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (50,50,50,3);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (51,51,51,44);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (52,52,52,28);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (53,53,53,23);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (54,54,54,17);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (55,55,55,10);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (56,56,56,34);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (57,57,57,58);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (58,58,58,11);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (59,59,59,50);
INSERT INTO BorrowerPetPreferences(species_id,type_id,habit_id,borrower_id) VALUES (60,60,60,31);

INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl',1,59);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin',2,30);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi sem mauris laoreet ut rhoncus',3,44);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in',4,6);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh',5,41);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien',6,20);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo',7,18);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla',8,48);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in',9,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id',10,2);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at',11,27);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in',12,46);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis',13,52);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('imperdiet sapien urna pretium nisl ut volutpat sapien',14,18);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate',15,41);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('morbi',16,38);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum',17,1);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id',18,33);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nec dui luctus rutrum',19,22);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor',20,11);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum',21,29);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris',22,21);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc',23,15);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo',24,36);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('suspendisse potenti cras in purus eu magna vulputate luctus cum sociis',25,43);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('condimentum curabitur in libero ut massa volutpat convallis morbi odio',26,42);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('imperdiet et commodo',27,22);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur',28,46);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti',29,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum',30,36);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea',31,5);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis',32,58);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis',33,39);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean fermentum donec',34,29);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('interdum mauris',35,9);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius',36,55);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque',37,33);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec',38,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis',39,39);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget',40,9);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('pede justo eu massa donec dapibus duis at velit eu est congue elementum in',41,6);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris',42,11);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu',43,30);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('a pede posuere',44,25);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('condimentum neque',45,59);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi',46,7);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio cras mi pede malesuada in imperdiet et commodo vulputate justo in blandit',47,4);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida',48,28);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('scelerisque quam turpis adipiscing lorem vitae mattis nibh',49,15);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet',50,4);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec',51,42);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien',52,54);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('quis',53,13);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet',54,51);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non',55,14);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue',56,19);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio',57,6);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim',58,52);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus ultricies eu nibh quisque id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia',59,35);
INSERT INTO BorrowerReview(review_text,pet_id,borrower_id) VALUES ('nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis',60,26);

INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat','2022-12-02','Minneapolis','Minnesota',55446,1);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla','2022-11-07','Richmond','California',94807,2);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer','2023-03-01','Charleston','South Carolina',29411,3);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel','2022-10-28','Winston Salem','North Carolina',27157,4);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor','2022-05-24','Memphis','Tennessee',38109,5);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci','2022-12-08','Spokane','Washington',99220,6);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in felis donec semper sapien a libero nam dui proin leo odio','2022-06-12','Moreno Valley','California',92555,7);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit','2022-04-28','Austin','Texas',78703,8);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mi pede malesuada in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet','2022-06-06','Paterson','New Jersey',07544,9);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo','2022-10-15','Newark','New Jersey',07104,10);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit','2022-10-22','Dallas','Texas',75358,11);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis','2023-04-06','Miami','Florida',33153,12);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('morbi sem mauris laoreet ut rhoncus aliquet pulvinar sed nisl nunc','2022-04-09','Elizabeth','New Jersey',07208,13);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam','2023-03-26','Shreveport','Louisiana',71161,14);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec','2022-09-02','Houston','Texas',77288,15);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tristique est et tempus semper est quam pharetra magna ac consequat','2022-07-08','Charlotte','North Carolina',28299,16);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('lorem ipsum dolor sit amet consectetuer adipiscing elit proin risus praesent','2022-12-20','Columbus','Mississippi',39705,17);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor','2022-05-05','Amarillo','Texas',79176,18);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('consequat in consequat ut nulla sed accumsan felis ut at dolor quis odio consequat varius','2022-07-27','Washington','District of Columbia',20210,19);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut','2023-02-15','Milwaukee','Wisconsin',53234,20);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor eu','2022-09-09','Fresno','California',93778,21);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula','2022-05-27','Miami','Florida',33153,22);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mattis egestas metus aenean fermentum donec ut mauris eget massa','2023-03-15','Oklahoma City','Oklahoma',73173,23);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum','2023-04-01','Madison','Wisconsin',53785,24);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus','2022-05-27','Bowie','Maryland',20719,25);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id','2023-01-23','Mesa','Arizona',85205,26);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ut tellus nulla ut erat id mauris vulputate elementum nullam','2022-11-16','Apache Junction','Arizona',85219,27);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('in felis eu sapien cursus vestibulum proin eu mi nulla','2022-12-29','Salem','Oregon',97312,28);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla','2022-10-17','Norfolk','Virginia',23520,29);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque','2022-10-15','Tulsa','Oklahoma',74141,30);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor','2022-11-01','Houston','Texas',77040,31);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit','2023-02-05','Lynn','Massachusetts',01905,32);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('mi in porttitor pede justo eu massa donec dapibus duis','2022-09-06','Chicago','Illinois',60624,33);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam','2022-05-16','Chicago','Illinois',60641,34);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices','2022-05-01','Roanoke','Virginia',24024,35);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel pede','2023-01-15','Los Angeles','California',90101,36);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('elit sodales scelerisque mauris sit amet eros suspendisse accumsan tortor quis','2022-08-17','Charleston','West Virginia',25326,37);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('tortor quis turpis sed ante vivamus tortor duis mattis egestas metus','2022-08-18','Santa Monica','California',90410,38);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('congue risus semper porta volutpat quam pede lobortis ligula sit','2022-10-31','Boise','Idaho',83757,39);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu','2022-06-07','Bridgeport','Connecticut',06673,40);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('aliquet pulvinar sed nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat','2022-11-08','Baton Rouge','Louisiana',70815,41);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et','2022-06-25','Phoenix','Arizona',85020,42);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus','2022-08-20','Fort Lauderdale','Florida',33310,43);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('auctor sed tristique in tempus sit amet sem fusce consequat nulla nisl nunc nisl','2022-05-17','Garden Grove','California',92645,44);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est','2022-12-08','Washington','District of Columbia',20036,45);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc','2022-09-30','San Diego','California',92170,46);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel','2023-04-04','Newark','Delaware',19714,47);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('dui nec nisi volutpat eleifend donec ut dolor morbi vel','2022-07-27','New Orleans','Louisiana',70116,48);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('pede ac diam cras pellentesque volutpat dui maecenas tristique est et','2022-11-09','Fredericksburg','Virginia',22405,49);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('justo in blandit ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula','2022-12-12','San Diego','California',92132,50);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh','2022-04-16','Nashville','Tennessee',37215,51);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('lacinia eget tincidunt eget tempus vel pede morbi porttitor lorem id ligula suspendisse ornare','2022-11-16','Boston','Massachusetts',02208,52);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros','2022-04-19','Lawrenceville','Georgia',30245,53);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('aenean sit amet justo morbi ut odio cras mi pede malesuada in','2023-02-19','Albany','New York',12242,54);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus','2023-04-03','Spokane','Washington',99215,55);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis','2022-07-22','Dallas','Texas',75387,56);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('quis augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur','2022-05-09','Birmingham','Alabama',35205,57);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at','2022-11-30','Miami','Florida',33164,58);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('sollicitudin mi sit amet lobortis sapien sapien non mi integer ac neque duis bibendum morbi non quam nec dui luctus','2023-03-16','Montgomery','Alabama',36119,59);
INSERT INTO Event(description,event_date,city,state,zip,event_id) VALUES ('lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra','2022-07-03','Houston','Texas',77060,60);



# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (58,48);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (23,44);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (33,5);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (4,26);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (54,13);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (57,28);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,32);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (9,16);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (52,21);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (31,43);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,50);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (50,38);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (13,12);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (22,25);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (46,40);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (9,26);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (48,3);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (12,58);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (20,49);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (28,41);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (34,23);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (1,59);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (2,30);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (31,42);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (3,57);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (54,5);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (24,23);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (39,16);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (12,44);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (47,4);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (56,60);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (5,52);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (28,8);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (54,9);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (12,26);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (8,2);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (59,34);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (1,7);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (2,42);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (57,14);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (59,22);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (29,56);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (60,9);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (39,12);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (32,50);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (48,53);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (7,37);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,58);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (53,49);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (36,29);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (41,15);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (26,50);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (27,15);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (18,6);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (46,31);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (14,49);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (16,41);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (43,41);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (18,28);
# INSERT INTO BorrowerBorrow(borrower_id,pet_id) VALUES (1,50);

