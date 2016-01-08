#!/bin/bash

db=vet-clinic

dropdb $db
createdb $db
psql $db -f create-schema.sql
psql $db -f seeds.sql
./print.sh
