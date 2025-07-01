#!/bin/bash

# Define environment variable
export FLASK_APP="run.py"
export FLASK_DB_TYPE="postgres"
export FLASK_DB_USER="postgres"
export FLASK_DB_NAME="postgres"
export FLASK_DB_PASSWORD="password"
export FLASK_DB_HOST="192.168.0.206"
export FLASK_DB_PORT="5232"

# Run app.py when the container launches
flask run --host=0.0.0.0 --port=3000