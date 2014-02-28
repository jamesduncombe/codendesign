# Code & Design

The idea is to bring [HackerNews](https://news.ycombinator.com/) and [DesignNews](https://news.layervault.com) together. I wanted a place where I could view these feeds at the same time.

It's using Sinatra as it's nice and lightweight.

Oh, and I've added some simple tweet button which kind of prefils a tweet ready to post.

I've also added a Pocket button for each article to make it easier for
those who use Pocket.

You can find codendesign running at [www.codendesign.co](http://www.codendesign.co).

## Build

To build, clone the repo then just run `bundle install` to install the required gems.

I'm using [Foreman](https://github.com/ddollar/foreman) to run it locally hence the `Procfile`. Check [this link](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) for getting started instructions on Foreman.

So, once Foreman is installed, you just need to run `foreman start` in your terminal.

…and it will find the `Procfile` and start the web server (which is currently [Puma](http://puma.io/) - no special reason, I was just playing!).

Browse to `http://localhost:5000` and you should be golden.

Please feel free to fork it and improve :)
