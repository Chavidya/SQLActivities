#Q2 – 321433225 – s92073225
#Q2(i) – 321433225 – s92073225

create database BOOKSTORE;
use BOOKSTORE; 

Create table Books(
BookID int primary key not null,
Title varchar (50) not null,
Author varchar (50) not null,
Genre varchar (50),
PublicationYear year );

Create table Members(
MemberID int primary key not null);
INSERT INTO Members (MemberID)
VALUES (3316),(3317),(3318),(3319),(3320);

Create table BorrowRecords(
BorrowID int primary key not null,
BookID int not null,
BorrowDate datetime not null,
ReturnDate datetime not null,
MemberID int not null,
FOREIGN KEY (BookID) REFERENCES Books(BookID),
FOREIGN KEY (MemberID) REFERENCES Members(MemberID));


#Q2(ii) – 321433225 – s92073225
LOAD XML 
INFILE "C:\\Program Files\\MySQL\\bookstore.xml"
INTO TABLE BOOKSTORE.Books
ROWS IDENTIFIED BY '<Book>';

LOAD XML 
INFILE "C:\\Program Files\\MySQL\\borrowrecord.xml"
INTO TABLE BOOKSTORE.BorrowRecords
ROWS IDENTIFIED BY '<BorrowRecord>';

select * from BorrowRecords;

#Q2(iii) – 321433225 – s92073225
CREATE VIEW BorrowedBooksView AS
SELECT 
    B.Title, 
    B.Author, 
    BR.BorrowDate, 
    BR.ReturnDate
FROM 
    Books B
INNER JOIN 
    BorrowRecords BR
ON 
    B.BookID = BR.BookID;

select * from Books;



#Q2(v) – 321433225 – s92073225

CREATE TABLE ReturnRecords (
    BorrowID INT PRIMARY KEY,
    ReturnDate DATETIME NOT NULL,
    FOREIGN KEY (BorrowID) REFERENCES BorrowRecords(BorrowID)
);
DELIMITER $$

CREATE TRIGGER AfterReturnDateUpdate
AFTER UPDATE ON BorrowRecords
FOR EACH ROW
BEGIN
    -- Check if the ReturnDate was updated
    IF OLD.ReturnDate <> NEW.ReturnDate THEN
        -- Insert the updated data into ReturnRecords
        INSERT INTO ReturnRecords (BorrowID, ReturnDate)
        VALUES (NEW.BorrowID, NEW.ReturnDate)
        ON DUPLICATE KEY UPDATE
        ReturnDate = NEW.ReturnDate;
    END IF;
END $$

DELIMITER ;


