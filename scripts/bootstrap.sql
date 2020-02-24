CREATE SCHEMA api;

SET search_path TO api;

drop table if exists api.amenity;
drop table if exists api.review;

-- Ratings enum instead of asking user to type in
create type rating as enum ('positive', 'neutral', 'negative');

create table api.amenity (
    amenity_id serial primary key,
    amenity_name text not null,
    amenity_address text not null,
    created_on timestamptz not null default now()
);

create table api.review (
    review_id serial primary key,
    review_rating rating,
    review_text text,
    created_on timestamptz not null default now(),
    amenity_id integer not null references api.amenity(amenity_id)
);

-- Create users

CREATE ROLE api_user nologin;
CREATE ROLE api_anon nologin;

GRANT USAGE on SCHEMA api to api_anon;
GRANT SELECT on api.amenity to api_anon;
GRANT SELECT on api.review to api_anon;

grant usage on schema api to api_user;
grant all on api.amenity to api_user;
grant all on api.review to api_user;