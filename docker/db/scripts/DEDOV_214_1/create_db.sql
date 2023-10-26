CREATE TABLE Reader
(
  ID        bigint primary key,
  LastName  text,
  FirstName text,
  Address   text,
  BirthDate date
);
insert into Reader (id, firstname, lastname, address, birthdate)
values (1, 'Иван', 'Иванов', 'Москва', '1991-01-01'),
       (2, 'Петр', 'Петров', 'Москва', '1992-01-01'),
       (3, 'Сидр', 'Сидоров', 'Санкт-Петербург', '1993-01-01'),
       (4, 'Николай', 'Николаев', 'Ржев', '1994-01-01'),
       (5, 'Андрей', 'Андреев', 'Москва', '1995-01-01');

create table Publisher
(
  PubName    text primary key,
  PubAddress text
);
insert into Publisher (PubName, PubAddress)
values ('Издательство', 'Москва');

create table Book
(
  ISBN     text primary key,
  Title    text,
  Author   text,
  PagesNum int,
  PubYear  int,
  PubName  text references Publisher (PubName)
);
insert into Book (ISBN, Title, Author, PagesNum, PubYear, PubName)
values ('1', 'Книга1', 'Автор Авторович 1', 100, 1999, 'Издательство'),
       ('12', 'Книга2', 'Автор Авторович 2', 650, 1999, 'Издательство'),
       ('123', 'Книга3', 'Автор Авторович 3', 10, 1800, 'Издательство'),
       ('1234', 'Книга4', 'Автор Авторович 4', 120, 2014, 'Издательство'),
       ('12345', 'Книга5', 'Автор Авторович 5', 3440, 1700, 'Издательство'),
       ('123456', 'Книга6', 'Автор Авторович 6', 700, 1959, 'Издательство'),
       ('1234567', 'Книга7', 'Автор Авторович 7', 800, 1959, 'Издательство'),
       ('12345678', 'Книга8', 'Автор Авторович 8', 800, 2003, 'Издательство');

create table Category
(
  CategoryName text primary key,
  ParentCat    text references Category (CategoryName)
);
insert into Category (CategoryName, ParentCat)
values ('Естесствознание', null)
     , ('Природа', 'Естесствознание')
     , ('Путешествия', 'Естесствознание')
     , ('Горы', 'Природа')
;

create table Copy
(
  ISBN          text references Book (ISBN),
  CopyNumber    int,
  ShelfPosition int,
  unique (ISBN, CopyNumber)
);
insert into Copy (ISBN, CopyNumber, ShelfPosition)
values ('1', 1, 1),
       ('1', 2, 12),
       ('12', 1, 13),
       ('12', 2, 12),
       ('12', 3, 14),
       ('123', 1, 13),
       ('123', 2, 71),
       ('123', 3, 881),
       ('123', 4, 71),
       ('1234', 1, 16),
       ('1234', 2, 15),
       ('12345', 1, 33),
       ('123456', 1, 12),
       ('123456', 2, 11),
       ('123456', 3, 16),
       ('1234567', 1, 71),
       ('1234567', 2, 16),
       ('12345678', 1, 15),
       ('12345678', 2, 24),
       ('12345678', 3, 33);

create table Borrowing
(
  ReaderNr   bigint references Reader (ID),
  ISBN       text,
  CopyNumber int,
  ReturnDate date,
  unique (ReaderNr, ISBN, CopyNumber, ReturnDate),
  foreign key (ISBN, CopyNumber) references Copy (ISBN, CopyNumber)
);
insert into Borrowing (ReaderNr, ISBN, CopyNumber, ReturnDate)
values (1, '123', 1, '2023-01-08'),
       (1, '12345', 1, '2023-01-07'),
       (2, '123', 2, '2023-01-06'),
       (2, '1234567', 1, null),
       (3, '12345678', 3, null),
       (4, '1234', 1, '2023-01-03'),
       (4, '123', 1, null),
       (4, '123456', 2, '2023-01-02');

create table BookCat
(
  ISBN         text references Book (ISBN),
  CategoryName text references Category (CategoryName),
  unique (ISBN, CategoryName)
);
insert into BookCat (ISBN, CategoryName)
values ('12', 'Горы'),
       ('123', 'Горы'),
       ('123', 'Путешествия'),
       ('1234', 'Горы'),
       ('12345', 'Горы'),
       ('12345', 'Путешествия'),
       ('12345678', 'Естесствознание'),
       ('12345678', 'Горы');
