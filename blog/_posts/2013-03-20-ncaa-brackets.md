---
layout: blog
title: NCAA bracket
author: Gray Calhoun
---

Unfortunately, [my sports blog](http://visualscoreboard.com/), just by existing, forces me to pay way more attention to sports than is really sensible. Which is a way of saying, I filled out some brackets and estimated a bunch of regression models to do it. If you want to estimate your own regression models for your own bracket, [the data are here](https://gist.github.com/gcalhoun/5199478).  And I strongly encourage you to enter [Jim Hamilton’s pool](http://www.econbrowser.com/archives/2013/03/2013_econbrowse.html) since it’s fun.

I probably won’t have time to actually write up a detailed analysis of my picks, but I will if somehow they do surprisingly well. The one thing that’s kind of worth remembering is that you basically lose if your final four teams get bumped early, so, despite every article I’ve read about the tournament, it’s probably a mistake to look at Gonzaga and Pittsburg in the second round and only think about how Gonzaga matches up with Pittsburg. Gonzaga’s got about a 99.3% chance of making the second round (depending on the model) and Pittsburg’s got about a 60-70% chance (also, depending on the model), so picking Gonzaga to make the third round is a much safer choice even if you think Pittsburg’s the better team.

Formalizing this sort of argument is pretty straightforward. Implementing it is trickier but I wrote some R code that does it; if the picks actually do well, I’ll spend some time cleaning it up and share. If the picks do badly, I can’t imagine that even my limited but extremely passionate readership will care about how I made bad picks.

The unfortunate consequence of this argument is that making really safe picks is the dominant strategy, at least if you’re maximizing your bracket’s expected score (which I did more or less, allowing for some sentimental early round choices, because thinking of how to maximize “probability of winning” was more than I wanted to deal with thinking about, let alone implementing). And this is true even though the selection committee makes mistakes and some of the seeds were terrible, because an overseeded 2 seed still has a much easier set of opponents than an underseeded 5 seed.