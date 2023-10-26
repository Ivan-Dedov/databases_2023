create table Station
(
  StatNr bigint primary key,
  Name   text
);

create table StationsPersonnel
(
  PersNr bigint primary key,
  Name   text,
  StatNr bigint references Station (StatNr)
);

/*
create table Doctor
(
  Area text,
  Rank text
) inherits (StationsPersonnel);

create table Caregiver
(
  Qualification text
) inherits (StationsPersonnel);
*/

create table Doctor
(
  PersNr bigint primary key references StationsPersonnel (PersNr),
  Area   text,
  Rank   text
);

create table Caregiver
(
  PersNr        bigint primary key references StationsPersonnel (PersNr),
  Qualification text
);

create table Room
(
  StatNr  bigint references Station (StatNr),
  RoomNr  bigint primary key,
  NumBeds int
);

create table Patient
(
  PatientNr bigint primary key,
  Name      text,
  Disease   text,
  RoomNr    bigint references Room (RoomNr),
  "From"    timestamp with time zone,
  "To"      timestamp with time zone
);

create table Treats
(
  PatientNr bigint references Patient (PatientNr),
  PersNr    bigint references StationsPersonnel (PersNr)
);
