# World Wide Sires DBA Assignment

I decided to take an out of the box approach to this and use a functional programming language with a document store DB. I felt transforming data with a functional language had a pretty good fit. I am using [Elixir](http://elixir-lang.org/) which is a fairly new language that runs on the [Erlang VM](http://www.erlang.org/) and [RethinkDB](http://rethinkdb.com/) for the DB.

## Instructions

To make it easier I have a temporary server setup on my Digital Ocean account. Using the SSH credentials that were provided.

```
cd code/dba_assignment

iex -S mix
