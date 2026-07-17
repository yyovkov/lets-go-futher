# Let's Go Further

## Chapter 01: Introduction

Building of an application calledGreenlight - a JSON API for retrieving and managing information about movies

| Method | URL Patter                | Action                                          |
|--------|---------------------------|-------------------------------------------------|
| GET    | /v1/healthcheck           | Show application health and version information |
| GET    | /v1/movies                | Show the details of all movies                  |
| POST   | /v1/movies                | Create a new movie                              |
| GET    | /v1/movies/:id            | Show the details of a specific movie            |
| PATCH  | /v1/movies/:id            | Update the details of a specific movie          |
| DELETE | /v1/movies/:id            | Delete a specific movie                         |
| POST   | /v1/users                 | Register a new user                             |
| PUT    | /v1/users/activated       | Activate a specific user                        |
| PUT    | /v1/users/password        | Update the password for a specific user         |
| POST   | /v1/tokens/authentication | Generate a new authentication token             |
| POST   | /v1/tokens/password-reset | Generate a new password-reset token             |
| GET    | /debug/vars               |Display application metrics                      |


## Chapter 02: Getting started

### Chapter 02.01: Project setup and skeleton structure

* Initialize go module

``` bash
go mod init greenlight.yyovkov.net
```

* Generating the skeleton directory structure

``` bash
mkdir -p bin cmd/api internal migrations remote
touch Makefile
touch cmd/api/main.go
```

### Chapter 02.02: A basic HTTP server

| Method | URL Patter                | Action                                          |
|--------|---------------------------|-------------------------------------------------|
| GET    | /v1/healthcheck           | Show application health and version information |

### Chapter 02.03: API endpoints and RESTful routing

| Method | URL Patter                | Action                                          |
|--------|---------------------------|-------------------------------------------------|
| GET    | /v1/healthcheck           | Show application health and version information |
| GET    | /v1/movies                | Show the details of all movies                  |
| POST   | /v1/movies                | Create a new movie                              |
| GET    | /v1/movies/:id            | Show the details of a specific movie            |
| PATCH  | /v1/movies/:id            | Update the details of a specific movie          |
| DELETE | /v1/movies/:id            | Delete a specific movie                         |

## Chapter 03: Sending JSON responses

### Chapter 03.01: Fixed-format JSON

### Chapter 03.02: JSON encoding

### Chapter 03.03: Encoding structs

### Chapter 03.04: Formatting and enveloping responses

Makes JSON output easier to read in terminal.
Adding structure to the JSON output, like, "movie":

``` JSON
{
	"movie": {
		"id": 123,
		"create_at": "2026-07-16T13:32:07.5195+03:00",
		"title": "Casablanca",
		"runtime": 102,
		"genres": [
			"drama",
			"romance",
			"war"
		],
		"version": 1
	}
}
  ```
```
```

### Chapter 03.05: Advanced JSON customization

### Chapter 03.06: Sending error messages

* Routing errors
* Panic recovery

## Chapter 04: Parting JSON requests

| Method | URL Patter                | Action                                          |
|--------|---------------------------|-------------------------------------------------|
| GET    | /v1/healthcheck           | Show application health and version information |
| **POST**   | **/v1/movies**        | **Create a new movie**                          |
| GET    | /v1/movies/:id            | Show the details of a specific movie            |

### Chapter 04.01: JSON decoding

### Chapter 04.02: Managing bad requests

### Chapter 04.03: Restricting inputs

### Chapter 04.04: Custom JSON decoding

### Chapter 04.05: Validating JSON input

## Chapter 05: Database setup and configuration

### Chapter 05.01: Setting up PostgreSQL

* Start Database

``` bash
make db-start
```

* Login to database as postgres user

``` bash
PGPASSWORD=password psql -h 127.0.0.1 -p 5432 -U postgres -w greenlight
```

* Create users and extensions

``` sql
CREATE ROLE greenlight WITH LOGIN PASSWORD 'pa55word';
CREATE EXTENSION IF NOT EXISTS citext;
```

* Grant access to greenlight database to greenlight user

``` sql
ALTER DATABASE greenlight OWNER TO greenlight;
GRANT CREATE ON DATABASE greenlight TO greenlight;
```

* Login to database as greenlight user

``` bash
PGPASSWORD=pa55word psql -h 127.0.0.1 -p 5432 -U greenlight -w greenlight
```

### Chapter 05.02: Connecting to PosgreSQL

* Install Golang packages

``` bash
go get github.com/lib/pq@v1
```

### Chapter 05.03: Configuring the database connection pool

* Create environmental variable with DSN

``` bash
echo 'export GREENLIGHT_DB_DSN=postgres://greenlight:pa55word@localhost/greenlight?sslmode=disable' >> .envrc
```

## Section 06: SQL migrations

### Section 06.01: An overview of SQL migrations

* Installing the migrate tool on mac

``` bash
brew install golang-migrate
```

* Installing the migrate tool on Linux and Windows

``` bash
cd /tmp
curl -L https://github.com/golang-migrate/migrate/releases/download/v4.19.1/migrate.linux-amd64.tar.gz | tar xvz
mv migrate ~/go/bin/
```

## Chapter 06.02: Working with SQL migrations

* Create migrations

``` bash
migrate create -seq -ext=.sql -dir=./migrations create_movies_table
```

* Execute migrations

``` bash
migrate -path=./migrations -database=$GREENLIGHT_DB_DSN up
```

* Look at the migrations with `migrate` tool

``` bash
$ migrate -path=./migrations -database=$EXAMPLE_DSN version
2
```

* Look at migrations tables with SQL

``` sql
SELECT * FROM schema_migrations;
```

* Execute down migrations (only informative, do not execute)

This command will roll back the **most recent migration** run

``` sql
migrate -path=./migrations -database =$EXAMPLE_DSN down 1
```

* Fixing failed migrations

Read how to fix migrations from the book, to save copy/paste here.

## Chapter 07: CRUD operations

| Method | URL Patter                | Action                                          |
|--------|---------------------------|-------------------------------------------------|
| GET    | /v1/healthcheck           | Show application information                    |
| POST   | /v1/movies                | Create a new movie                              |
| GET    | /v1/movies/:id            | Show the details of a specific movie            |
| PUT    | /v1/movies/:id            | Update the details of a specific movie          |
| DELETE | /v1/movies/:id            | Delete a specific movie                         |

### Chapter 07.01: Setting up the movie model

### Chapter 07.02: Creating a new movie

* Create database recovery

``` bash
BODY='{"title":"Moana","year":2016,"runtime":"107 mins", "genres":["animation","adventure"]}'
curl -i -d "$BODY" localhost:4000/v1/movies
BODY='{"title":"Black Panther","year":2018,"runtime":"134 mins","genres":["action","adventure"]}'
curl -d "$BODY" localhost:4000/v1/movies
BODY='{"title":"Deadpool","year":2016, "runtime":"108 mins","genres":["action","comedy"]}'
curl -d "$BODY" localhost:4000/v1/movies
BODY='{"title":"The Breakfast Club","year":1986, "runtime":"96 mins","genres":["drama"]}'
curl -d "$BODY" localhost:4000/v1/movies
```

### Chapter 07.03: Fetching a movie

### Chapter 07.04: Updating a movie

* Update movie

``` bash
curl localhost:4000/v1/movies/2
BODY='{"title":"Black Panther","year":2018,"runtime":"134 mins","genres":["sci-fi","action","adventure"]}'
curl -X PUT -d "$BODY" localhost:4000/v1/movies/2
curl localhost:4000/v1/movies/2
```

