# Code & Design

The idea is to bring [HackerNews](https://news.ycombinator.com/) and [DesignNews](https://www.designernews.co/) together. I wanted a place where I could view these feeds at the same time.

It's using Sinatra as it's nice and lightweight.

Oh, and I've added some simple tweet button which kind of prefils a tweet ready to post.

I've also added a Pocket button for each article to make it easier for
those who use Pocket.

You can find codendesign running at [cnd.jdun.co](https://cnd.jdun.co).

## Build & Run

Note: This relies on [Docker](https://www.docker.com/) to start [Memcached](https://www.memcached.org/) in the background on port 11211.

To build, clone the repo then just run `bundle install` to install the required gems.

I'm using [Foreman](https://github.com/ddollar/foreman) to run it locally hence the `Procfile`. Check [this link](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) for getting started instructions on Foreman.

So, once Foreman is installed, you just need to run `foreman start` in your terminal.

This will start the webserver and also start up the Docker container running Memcached (the Docker container is started with `--rm` to remove it once you stop Foreman).

Browse to `http://localhost:9292` and you should be golden.

If you'd like to run this without Memcached, you can, just start the webserver manually with: `rackup`.

Please feel free to fork it and improve :)
