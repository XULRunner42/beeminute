beeminute
=========

A really simple project to use Ruby and Curl with
the Beeminder API's JSON to update a small graph.

Manifest:
* `README.md` (this file)
* `README` (not this file -- a BASH script with mode +x)
* `beedata.rb` - a big function and some "constants"
* `beegraph.sqlite` (see README for the schema)
* `Gemfile` (this project uses bundler)
* `20graph.rb` (requires ./beedata, runs a single method)

From the top down:

`README` is what you'll be running in your crontab a few times a day (it saves
you from having to dirty up your crontab to invoke this code in the proper gem
context inside of RVM), with an entry like this:

    32    10,16,18,22 * * * cd ~/go-work/beeminute; ./README

`beedata.rb` contains the local database adapter, your Beeminder `AUTH_TOKEN`,
and the code that calls `beemind` with it.  That `beemind` is the command-line
app that comes with the `beeminder` gem.  This code is meant to have verbose
output, and uses the `sequel` gem to avoid writing any SQL statements.

Hopefully I've remembered to clear my `AUTH_TOKEN` before I posted this code.

Go back to `README` if you want to see the schema for `beegraph.sqlite`, you'll
need it since this code does not have any way to generate its own local tables.
The local tables are used to remember what data points are already posted.
This code naïvely insists that nobody else could modify the data points at the
Beehive, and balks when it sees that's not the case.  If someone else *adds* a
data point that is newer than the last point we saw or knew, that should be
handled here slightly more gracefully.

Finally if today's date is greater than the date on the newest data point, it
creates a new point with the `beemind` tool, and quits.  It would be silently
recorded in the local sqlite on the next execution.

`20graph.rb` glues the `beedata` method to some entries from the JSON data.  It
was meant to actually pull the JSON using native ruby `net/https` but that is
now done in the `README` using Curl; that implementation is left as exercise
for the reader.  Some example code is here which I could not make work; it was
just easier to use Curl.

