@echo off
echo Starting Phoenix CRUD API...
echo.
echo Installing dependencies...
call mix deps.get
echo.
echo Setting up database...
call mix ecto.setup
echo.
echo Running migrations...
call mix ecto.migrate
echo.
echo Starting server...
echo API will be available at: http://localhost:4000
echo CRUD endpoints: /api/users
echo.
call mix phx.server
