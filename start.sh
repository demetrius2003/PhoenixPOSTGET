#!/bin/bash
echo "Starting Phoenix CRUD API..."
echo ""
echo "Installing dependencies..."
mix deps.get
echo ""
echo "Setting up database..."
mix ecto.setup
echo ""
echo "Running migrations..."
mix ecto.migrate
echo ""
echo "Starting server..."
echo "API will be available at: http://localhost:4000"
echo "CRUD endpoints: /api/users"
echo ""
mix phx.server
