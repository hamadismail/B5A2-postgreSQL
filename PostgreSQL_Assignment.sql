-- Create Database
CREATE DATABASE conservation_db;

-- Create Tables
CREATE TABLE rangers (
    ranger_id INT PRIMARY KEY,
    name VARCHAR(50),
    region VARCHAR(50)
);

CREATE TABLE species (
    species_id INT PRIMARY KEY,
    common_name VARCHAR(50),
    scientific_name VARCHAR(50),
    discovery_date DATE,
    conservation_status VARCHAR(50)
);

CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY,
    species_id INT,
    ranger_id INT,
    location VARCHAR(50),
    sighting_time DATE,
    notes TEXT,
    FOREIGN KEY (species_id) REFERENCES species(species_id),
    FOREIGN KEY (ranger_id) REFERENCES rangers(ranger_id)
);
