CREATE DATABASE bookstore;
USE bookstore;
/* Create the tables - Part (b) */
CREATE TABLE customer
(email VARCHAR(20) NOT NULL, 
 name VARCHAR(40) NOT NULL, 
 address VARCHAR(20) NOT NULL, 
 phone INT NOT NULL, 
 CONSTRAINT customerPK PRIMARY KEY (email)); 

CREATE TABLE shopping_cart
(cEmail VARCHAR(20) NOT NULL, 
cartSequence INT NOT NULL, 
CONSTRAINT cartPK PRIMARY KEY (cEmail,cartSequence),
CONSTRAINT cartCustomerFK FOREIGN KEY (cEmail) REFERENCES customer(email)
  ON DELETE CASCADE ON UPDATE CASCADE); 

CREATE TABLE publisher
(name VARCHAR(30) NOT NULL, 
address VARCHAR(20) NOT NULL, 
phone INT NOT NULL, 
URL VARCHAR(30) NOT NULL, 
CONSTRAINT publisherPK PRIMARY KEY (name)); 

CREATE TABLE book
(ISBN INT NOT NULL, 
title VARCHAR(30) NOT NULL,
year INT NOT NULL,
price DOUBLE NOT NULL,
publiName VARCHAR(30) NOT NULL,
CONSTRAINT bookPK PRIMARY KEY (ISBN),
CONSTRAINT bookPublisherFK FOREIGN KEY (publiName) REFERENCES publisher(name)
    ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE item_cart
(cEmail VARCHAR(20) NOT NULL, 
cartSequence INT NOT NULL, 
ISBN INT NOT NULL,
CONSTRAINT itemPK PRIMARY KEY (cEmail,cartSequence, ISBN),
CONSTRAINT itemCartFK FOREIGN KEY (cEmail, cartSequence) REFERENCES shopping_cart(cEmail, cartSequence)
    ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT itemBookFK FOREIGN KEY (ISBN) REFERENCES Book(ISBN)
    ON DELETE CASCADE ON UPDATE CASCADE); 

CREATE TABLE author
(aID INT NOT NULL, 
URL VARCHAR(30) NOT NULL, 
address VARCHAR(30) NOT NULL,
phone INT NOT NULL,
CONSTRAINT authorPK PRIMARY KEY (aID)); 

CREATE TABLE author_book
(ISBN INT NOT NULL, 
aID INT NOT NULL, 
CONSTRAINT abPK PRIMARY KEY (ISBN,aID),
CONSTRAINT abBookFK FOREIGN KEY (ISBN) REFERENCES book(ISBN)
    ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT abAuthorPK FOREIGN KEY (aID) REFERENCES author(aID)
    ON DELETE CASCADE ON UPDATE CASCADE); 

/* Insert 3 records in each of the tables - PART C*/
INSERT INTO customer 
(email,
 name,
 address,
 phone)
VALUES 
('cvalder@emory.edu',
 'Camilo Valderrama',
 'Street 1',
  123 );

INSERT INTO customer 
(email,
 name,
 address,
 phone)
VALUES 
('joyce.c.ho@emory.edu',
 'Joyce Ho',
 'Street 2',
  345);

INSERT INTO customer 
(email,
 name,
 address,
 phone)
VALUES 
('sam@emory.edu',
 'Sam Simons',
 'Street 3',
  678 );

INSERT INTO publisher
(name,
 address,
 phone,
 URL)
VALUES 
('Pearson',
 'Street 4',
 123,
 'www.pearson.com' );

INSERT INTO publisher
(name,
 address,
 phone,
 URL)
VALUES 
('Elsevier',
 'Street 5',
 123,
 'www.elsevier.com' );

INSERT INTO publisher
(name,
 address,
 phone,
 URL)
VALUES 
('McGraw-Hill',
 'Street 6',
 123,
 'www.mcgrawhill.com' );

INSERT INTO book
(ISBN,
 title,
 year,
 price,
 publiName)
VALUES 
(1234,
 'Book 1',
 2015,
 30,
 'McGraw-Hill');

INSERT INTO book
(ISBN,
 title,
 year,
 price,
 publiName)
VALUES 
(4321,
 'Book 2',
 2016,
 45,
 'McGraw-Hill');

INSERT INTO book
(ISBN,
 title,
 year,
 price,
 publiName)
VALUES 
(2589,
 'Book 3',
 2014,
 32,
 'Elsevier');

INSERT INTO shopping_cart
(cEmail,
 cartSequence)
VALUES 
('cvalder@emory.edu',
 1);

INSERT INTO shopping_cart
(cEmail,
 cartSequence)
VALUES 
('joyce.c.ho@emory.edu',
 1);

INSERT INTO shopping_cart
(cEmail,
 cartSequence)
VALUES 
('joyce.c.ho@emory.edu',
 2);

INSERT INTO item_cart
(cEmail,
 cartSequence,
 ISBN)
VALUES 
('cvalder@emory.edu',
 1,
 1234);

INSERT INTO item_cart
(cEmail,
 cartSequence,
 ISBN)
VALUES 
('joyce.c.ho@emory.edu',
 1,
 1234);

INSERT INTO item_cart
(cEmail,
 cartSequence,
 ISBN)
VALUES 
('joyce.c.ho@emory.edu',
 2,
 4321);

INSERT INTO author 
(aID,
 URL,
 address,
 phone)
VALUES 
(789,
 'www.a1.com',
 'Street 28',
  348);

INSERT INTO author 
(aID,
 URL,
 address,
 phone)
VALUES 
(456,
 'www.a2.com',
 'Street 98',
  378);

INSERT INTO author 
(aID,
 URL,
 address,
 phone)
VALUES 
(654,
 'www.a3.com',
 'Street 94',
  648);

INSERT INTO author_book 
(ISBN,
 aID)
VALUES 
(4321,
 654);

INSERT INTO author_book 
(ISBN,
 aID)
VALUES 
(2589,
 789);

INSERT INTO author_book 
(ISBN,
 aID)
VALUES 
(1234,
 789);

/* Part D */
SELECT c.name, b.title, p.name, p.address
FROM customer c, shopping_cart s, item_cart ic, book b, publisher p
WHERE c.email = s.cemail
AND ic.cEmail=s.cEmail
AND ic.cartSequence=s.cartSequence
AND ic.ISBN = b.ISBN
AND b.publiname = p.name
ORDER BY c.name;
