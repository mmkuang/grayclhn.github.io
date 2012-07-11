---
layout: tweet
title: Untitled sports (micro-) blog
---

I run a few R scripts to estimate statistical charts for baseball, and
I plan to add other sports and statistics soon. They get posted on Twitter
through [@_unsprt](https://twitter.com/intent/user?screen_name=_unsprt),
so go there if you want to see the actual charts. This page tries to explain
what's going on in the charts.

### Baseball season summary

You should be able to pull up all of these charts by 
[searching Twitter for @_unsprt #mlb #wins](https://twitter.com/#!/search/realtime/%40_unsprt%20%23mlb%20%23wins).

Here's an example (you may need to follow the links if they're not embedded):
<blockquote class="twitter-tweet"><p>Example of the baseball graphs I'll post. I'm not 100% sure these data are correct so WATCH OUT. <a href="http://t.co/mRiXSsYh" title="http://twitter.com/_unsprt/status/223067400361345024/photo/1">twitter.com/_unsprt/status…</a></p>&mdash; untitled sports blog (@_unsprt) <a href="https://twitter.com/_unsprt/status/223067400361345024" data-datetime="2012-07-11T14:53:07+00:00">July 11, 2012</a></blockquote>

These charts try show us a rough measure of each team's performance.
Winning percentage is a flawed measure of team performance, since
teams have different opponents and some opponents are better than
others. We can address that by fitting a "fixed effects" regression
model, so we assume that there are unknown constants
<i>a<sub>i</sub></i> and <i>b<sub>j</sub></i> (<i>i</i> and <i>j</i>
index each of the 30 teams) such that

Prob(<i>home team wins</i> given <i>team i is home</i> and <i>team j is away</i>) = <i>a<sub>i</sub></i> + <i>b<sub>j</sub></i>

and then we estimate each <i>a<sub>i</sub></i> and
<i>b<sub>j</sub></i> using data from the current baseball season (this
is called <i>linear regression</i> or <i>OLS</i> and generalizes
taking the average). If we include only the <i>a<sub>i</sub></i> terms
we'd estimate each team's winning percentage at home, and if we
include only the <i>b<sub>j</sub></i> terms we'd estimate each team's
road winning percentage. Including both terms lets us account for both
teams. Once we estimate these coefficients, we can derive an estimate
of the probability that any team will beat any other team, taking home
field advantage into account.

Now look at the table (embedded in the tweet above as a picture). 

* The red column, labeled "Pred." (for "prediction") uses this model
  to predict how many wins each team will have at the end of the
  season, based on the team's wins and its schedule of unplayed games.

* The blue column, labeled "Bal." (for "balanced schedule") uses this
  model to estimate how many wins each team would have if it played
  every other team the same number of times in a 162 game season, half
  of the games at home and half away (the math works fine even though
  162 can't be evenly divided by 29). This column is a reasonable
  (but simplistic) estimate of the team's overall performance, and the 
  column labeled "Rank" ranks the teams by this value.

* The column labeled "Raw" just looks at the raw winning percentage
  and multiplies it by 162 (the number of games in the season).

* The column labeled "Projected wins" plots each of those three
  columns for each team to make it easier to compare them.

* The last column, "Season summary..." gives a time series plot for
  each team with two regions. The first region plots the team's
  win/loss record for the overall season, with wins coded as one and
  losses as zero. The second region plots the predicted win
  probability for each of the remaining games in the season, using the
  fixed effects model discussed above.
  
One last point. This fixed effects model is not true, and isn't
necessarily a good model. But it is better than naively looking at
winning percentages and ignoring differences in divisions and
opponents. Please let me know if you have questions or suggestions,
but I already know that the model is "wrong" and "simplistic" and even
"stupid."