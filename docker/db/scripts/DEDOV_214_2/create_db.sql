CREATE TABLE City
(
  Name   text,
  Region text,
  unique (Name, Region)
);
insert into City(Name, Region)
values ('Москва', 'Москва')
     , ('Санкт-Петербург', 'Ленинградская обл.')
     , ('Тверь', 'Тверская обл.')
;

CREATE TABLE Station
(
  Name      text primary key,
  NumTracks int,
  CityName  text,
  Region    text,
  foreign key (CityName, Region) references City (Name, Region)
);
insert into Station (Name, NumTracks, CityName, Region)
values ('Москва-1', 4, 'Москва', 'Москва')
     , ('Москва-2', 8, 'Москва', 'Москва')
     , ('Тверь-1', 2, 'Тверь', 'Тверская обл.')
     , ('Санкт-Петербург-1', 6, 'Санкт-Петербург', 'Ленинградская обл.')
;

CREATE TABLE Train
(
  TrainNr          int primary key,
  Length           int,
  StartStationName text references Station (Name),
  EndStationName   text references Station (Name)
);
insert into Train(TrainNr, Length, StartStationName, EndStationName)
values (12, 12, 'Москва-1', 'Тверь-1')
     , (13, 14, 'Москва-1', 'Тверь-1')
     , (21, 20, 'Москва-1', 'Санкт-Петербург-1')
     , (51, 10, 'Москва-1', 'Санкт-Петербург-1')
     , (61, 10, 'Москва-1', 'Санкт-Петербург-1')
     , (41, 14, 'Тверь-1', 'Санкт-Петербург-1')
     , (19, 12, 'Тверь-1', 'Москва-1')
     , (14, 12, 'Санкт-Петербург-1', 'Тверь-1')
;

CREATE TABLE Connection
(
  FromStation text references Station (Name),
  ToStation   text references Station (Name),
  TrainNr     int references Train (TrainNr),
  Departure   timestamp with time zone,
  Arrival     timestamp with time zone,
  unique (FromStation, ToStation, TrainNr, Departure, Arrival)
);
insert into Connection (FromStation, ToStation, TrainNr, Departure, Arrival)
values ('Москва-1', 'Тверь-1', 21, '2023-01-01 19:00:00', '2023-01-01 23:00:00')
     , ('Тверь-1', 'Санкт-Петербург-1', 21, '2023-01-01 23:00:00', '2023-01-02 07:00:00')
     , ('Москва-1', 'Санкт-Петербург-1', 21, '2023-01-01 19:00:00', '2023-01-02 07:00:00')
     , ('Москва-1', 'Санкт-Петербург-1', 51, '2023-01-01 18:00:00', '2023-01-02 07:00:00')
     , ('Москва-1', 'Санкт-Петербург-1', 61, '2023-01-01 18:00:00', '2023-01-01 22:00:00')
     , ('Москва-1', 'Тверь-1', 13, '2023-01-01 18:00:00', '2023-01-01 22:00:00')
     , ('Тверь-1', 'Санкт-Петербург-1', 41, '2023-01-01 22:00:00', '2023-01-01 23:59:00')
;
