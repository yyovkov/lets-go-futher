package data

import "time"

type Movie struct {
	ID        int       `json:"id"`
	CreatedAt time.Time `json:"create_at"`
	Title     string    `json:"title"`
	Year      int       `json:"year,omitzero"`
	Runtime   int       `json:"runtime,omitzero"`
	Genres    []string  `json:"genres,omitzero"`
	Version   int       `json:"version"`
}
