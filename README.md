# World Wide Sires DBA Assignment

I decided to take an out of the box approach to this and use a functional programming language with a document store DB. I felt transforming data with a functional language had a pretty good fit. I am using [Elixir](http://elixir-lang.org/) which is a fairly new language that runs on the [Erlang VM](http://www.erlang.org/) and [RethinkDB](http://rethinkdb.com/) for the DB.

## Instructions

To make it easier I have a temporary server setup on my Digital Ocean account. Using the SSH credentials that were provided.

```
cd code/dba_assignment

iex -S mix

```
You should see the following print out.
```
Erlang/OTP 18 [erts-7.3] [source] [64-bit] [async-threads:10] [kernel-poll:false]

Compiling 6 files (.ex)
Generated api_server app
Interactive Elixir (1.3.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```
Run the following command in the Elixir REPL. You will recieve a response with :ok and a PID (Proccess ID) This is an Erlang process that runs in the VM.
```
APIServer.start()
{:ok, #PID<0.217.0>}
```
This will start the API server on port 3000, but before accessing this we need to import data into RethinkDB. Access the RethinkDB Dashbaord [here](http://dev.damkostudios.com:8080/). (dev.damkostudios.com:8080)

You can watch the realtime write performance on the 'bulls' table [here](http://dev.damkostudios.com:8080/#tables/6c04c0f7-adb1-41aa-b7c2-08895e8445f5).

Then run the following command in the Elixir REPL and watch the graph.
```
MergeData.merge_files(["bull-details.txt","bulls.json"])
```
You can see the writen results with the Data Explorer to run ReQL queries on the table [here](http://dev.damkostudios.com:8080/#dataexplorer). Run the following query in the Data Explorer panel.
```
r.db('sires').table('bulls')
```
You can change the view of that data from Tree View to Table View as well as Raw JSON data.

I am just spitting out JSON to the browser with the API Router. See api_router.ex under the lib/ folder.
There is a great [JSONView](https://chrome.google.com/webstore/detail/jsonview/chklaanhfefbnpoihckbnefhakgolnmc?hl=en-US) extension for Chrome. This way you can see the formatted JSON when you browse the API server.

First we need to restart the Elixir REPL. To exit hit Ctrl-C twice and then run the following.
```
iex -S mix
APIServer.start()
```
Now you can visit [dev.damkostudios.com:3000/api/active](http://dev.damkostudios.com:3000/api/active) to see the filter JSON with just active bulls.

You can filter by country with /api/country/USA or get all UIDs by /api/get_uids
