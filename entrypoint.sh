#!/bin/bash -e

bin/rails db:migrate
bin/rails server -b 0.0.0.0 -p $PORT
