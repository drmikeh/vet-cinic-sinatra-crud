DROP TABLE IF EXISTS pets;
DROP TABLE IF EXISTS owners;

CREATE TABLE owners(
  id serial PRIMARY KEY,
  first_name varchar(50) NOT NULL,
  last_name varchar(50) NOT NULL
);

CREATE TABLE pets(
  id         serial8     primary key,
  name       varchar(20) not null,
  type       varchar(20) not null,
  age        integer     not null  CHECK (age >= 0),
  owner_id   integer references owners(id)
);
