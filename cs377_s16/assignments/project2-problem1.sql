/* Part a */
SELECT c.name, b.publiName, count(b.ISBN)
FROM customer c, shopping_cart s, item_cart ic, book b
WHERE c.email = s.cemail
AND ic.cEmail=s.cEmail
AND ic.cartSequence=s.cartSequence
AND ic.ISBN = b.ISBN
GROUP BY c.name, b.publiName;

/* Part b */
UPDATE customer
SET  email = 'joyce@emory.edu'
WHERE email = 'joyce.c.ho@emory.edu';
/* verify update to email gets pushed through */
SELECT *
FROM   item_cart;
SELECT *
FROM   shopping_cart;

UPDATE book
SET    ISBN = '5789'
WHERE  ISBN = '1234';
/* verify the update to the book isbn is good */
SELECT *
FROM author_book;
SELECT *
FROM item_cart;

/* Part c */
DELETE FROM book
WHERE publiName = 'Elsevier';

/* Part d */
CREATE VIEW sales_director
AS (SELECT c.name, c.email, c.phone, COUNT(ic.ISBN), SUM(b.price)
FROM customer c, item_cart ic, book b
WHERE c.email = ic.cEmail AND b.ISBN = ic.ISBN
GROUP BY c.email);