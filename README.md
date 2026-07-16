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

## Chapter 05; Database setup and configuration

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

* Login to database as greenlight user

``` bash
PGPASSWORD=pa55word psql -h 127.0.0.1 -p 5432 -U greenlight -w greenlight
```

### Chapter 05.02: Connecting to PosgreSQL

* Install Golang packages

``` bash
go get github.com/lib/pq@v1
```

