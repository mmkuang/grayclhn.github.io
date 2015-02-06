---
layout: blog
title: Some thoughts on the Reinhart and Rogoff debate
author: Gray Calhoun
---

(Update from February 6th, 2015: I've turned this post into a short
paper, “[Causality in the Reinhart-Rogoff dataset, the plots
thicken]({{ site.main }}/dl/calhoun-rr-graphics.pdf)”)

I’ve linked to some of the debate over [Reinhart and Rogoff’s][RR]
[suddenly suspect results on debt and economic growth] [umass] (the
links are on my old blog, but you can find all the articles you want
for yourself on the internet) but haven’t said much other than that
and was happy to leave it that way. But... I’m teaching a PhD time
series class this semester and we just spent about a week on
identification in SVARs (structural vector autoregressions) and then a
student asked me about [this follow-up “time series” analysis by
Deepankar Basu] [Basu] that tries to get at causality (i.e. whether
high debt causes low growth or low growth causes high debt) and
there’s also [this statistical analysis by Arindrajit Dube] [Dube]
and... damn it, I probably need to actually have a professional
opinion on this whole mess now.

Here’s a really short summary of Basu’s results (since that’s what my
student asked about).  He looks at the annual growth rate of real GDP
and the annual debt/GDP ratio and tries to forecast them with past
values of both variables.  He finds that the growth rate of GDP seems
to have predictive power for the debt/GDP ratio and that the debt/GDP
ratio doesn’t have statistically significant predictability for GDP
growth.  Taken at face value, this would be moderately convincing.
It’s a bland truism that “correlation isn’t causation,” but sequential
timing can help and unless you believe that the growth rate of GDP
moves down in anticipation of high future values of the debt/GDP ratio
then this suggests that the low GDP growth is causing the rise in the
debt/GDP ratio.  It’s not hard to tell stories where that sort of
anticipation happens, though, since Macro and financial variables are
often forward looking: if households save in anticipation of a high
debt/GDP ratio, that would cause aggregate demand to fall, causing
lower GDP growth.  Note that that’s more or less the story that
pro-Austerity politicians and pundits have been telling (essentially
Paul Krugman’s [confidence fairy][]), and it’s completely consistent
with Basu’s model and statistical results.

That’s probably worth repeating: since investors and other economic
actors act try to anticipate the future state of the economy, events
are as good as caused by future events all the time.

So, for that reason alone, you shouldn’t take Basu’s result at face
value.  There are other reasons too: the debt/GDP ratio is highly
persistent and has extreme starting points (I’ll have pictures later
in the post) either of these can cause problems for these test
statistics (this issue is discussed in [Elliott and Stock’s 1994
paper][ES94] and [Cavanagh, Elliott, and Stock’s 1996 paper][CES96]).
The same persistence issue raises statistical problems with the rest
of the analysis too.  There are other more conceptual problems, so you
can basically ignore the Impulse Response Functions (IRFs); the idea
behind presenting IRFs is to show the effect of an economic shock, but
as conducted here, it doesn’t tell you any more than the tests of
predictability.  (It’s hard to give an accessible explanation for
that. but here’s where “correlation is not causation” is somewhat
helpful.  The data can only tell us about correlation, and you need to
have extra knowledge about the system, maybe that the data come from a
controlled experiment, to infer causation from that correlation.  Basu
estimates correlations from the data, then tries to get the data to
identify the causal structure too without making any other explicit
assumptions.  This task is literally impossible).

The same issues are present to a lesser extent in Dube’s analysis, but
I think his main analysis (his Figure 2) is less affected by the
persistence issues; the timing issues are still there, though.  If you
wanted to, you could probably reconcile his Figure 2 with a confidence
fairy argument, meaning that it doesn’t establish causality either.

So, what would I do?  Well, remember:

> The combination of some data and an aching desire for an answer does
> not ensure that a reasonable answer can be extracted from a given
> body of data. — [John Tukey][Tukey].

We have annual data on economic growth and debt for 20 countries;
without a lot of more nuanced data and information, we’re never going
to have a bulletproof analysis, so don’t hold that up as the goal.
Accept that with this data set, you’re not going to disprove the
confidence fairy (ironically, if you want to understand the
debt/growth relationship and how it should affect policy, you’d
probably want to do a deep qualitative analysis of different periods
of debt, as exemplified by... Reinhart and Rogoff’s *This time is
different*).

A first step, and I’m going to argue that for my purposes (writing a
blog post) this is a sufficient step, is to look at the data.  I
downloaded the dataset and Herndon, Ash, and Polin’s code
[here][HAP_code], plus see [their readme.txt][HAP_readme], and
generated some very basic plots.  First we plot the GDP
growth rate over time for each country, but using line color to show
the years in which debt was higher than 90% of GDP (those years are
red).

The inline graph plots the data for all of the countries. There are
graphs that plot GDP growth for each country individually at the end
of the post → [here](#growth).

![GDP Growth, all countries](pictures/2013_RR/growth_01.png =540x)

And, look.  For countries where the 90% threshold is exceeded, it
happens at the very beginning of the sample (i.e. WWII deescalation
and rebuilding) or the towards the end.  For some countries (Italy and
Japan for example) there’s a clear downward trend over the last 50
years; so of course if the high debt is at the end of the sample, it’s
going to be correlated with lower growth.  Literally nothing in these
pictures makes me especially concerned about debt over 90% of GDP
(obviously I’ve played around with other thresholds too and found
similar results).  The R code used to generate these plots is
straightforward and is [available here][code gist].

Now we can flip the roles of growth and debt and plot the debt/GDP
ratio for each country and uses red to indicate years where GDP growth
was below 1%. A graph with all countries' data is presented inline,
and individual graphs are availabe at the end of the post → [here](#debt).

![Debt/GDP, all countries](pictures/2013_RR/debt_01.png =540x)

Unlike before, the low growth periods are scattered through the
series.  We also see results that are at least suggestive: for many
countries (Denmark, Canada, Belgium, the US, Sweden, and others), low
growth in the early 80s was followed by an increase in the debt/GDP
ratio.  Same thing with Sweden, Finland, and Japan in the 90s.  But,
again, this doesn’t disprove the confidence fairy.  [The R code for
these plots is here as well][code gist].

But we actually can learn something new from these plots.  Notice that
GDP growth moves in broadly the same direction across different
countries.  You can see that there’s some systematic comovement in the
GDP plots, and you can also see that the red lines are pretty
clustered in the debt ratio graph.  And, this is the key, you see
clustering at the same point in time, but not at the same level of
debt.  If the lower level of GDP growth anticipated a higher level of
debt, we’d see more red lines before the higher debt levels.  Instead,
we see that the red lines happen before an increase in the debt level,
but it doesn’t matter whether it’s an increase to a high level of debt
or to a low level of debt.

So, those are the two key things that jump out of the graphs,
particularly the “All countries” panel.

* Low growth periods happen at roughly the same time in different
  countries, suggesting that there’s a common element that’s at least
  partially responsible.  The debt/GDP ratio has common patterns
  across countries, but at very long horizons, so it seems unlikely to
  be that common element.
  
* The low growth periods happen before an increase in the debt/GDP
  ratio, but it doesn’t appear to matter whether it’s an increase to a
  low or high level of debt/GDP.  Confidence fairy stories seem like
  they’d imply that low growth should happen before a change to a high
  level of debt/GDP and not be as likely before a change to a low
  level of debt/GDP, which we don’t see at all in the data.

It might be possible to formalize either of those observations into an
academically rigorous identification strategy; the second bullet
especially lines up with statistical tools for empirical macro,
although you’d need to actually write down a model that pins down the
change vs. level distinction.  Right now, this is just somewhat
informed speculation.  Of course, since there’s been a lot of
structural change in the last 70 years, if we really want to
understand our policy options, it’s probably best to look in detail at
the last 20 years or so and draw conclusions from that.  The aggregate
statistical evidence is probably best as supporting, not primary,
evidence.

Please let me know when you find errors. Other comments and
suggestions would be great too.

[RR]: http://ideas.repec.org/a/aea/aecrev/v100y2010i2p573-78.html
[umass]: http://www.peri.umass.edu/236/hash/31e2ff374b6377b2ddec04deaa6388b1/publication/566/
[Basu]: http://www.nextnewdeal.net/rortybomb/guest-post-time-series-high-debt-and-growth-italy-japan-and-united-states
[Dube]: http://www.nextnewdeal.net/rortybomb/guest-post-reinhartrogoff-and-growth-time-debt
[Salmon]: http://blogs.reuters.com/felix-salmon/2013/04/17/chart-of-the-day-reverse-causality-edition/
[Wolfers]: https://twitter.com/justinwolfers/status/326415306421592064
[confidence fairy]: http://www.nytimes.com/2010/07/02/opinion/02krugman.html
[ES94]: http://ideas.repec.org/a/cup/etheor/v10y1994i3-4p672-700_00.html
[CES96]: http://ideas.repec.org/a/cup/etheor/v11y1995i05p1131-1147_00.html
[Tukey]: https://en.wikiquote.org/wiki/John_Tukey
[HAP_code]: http://www.peri.umass.edu/fileadmin/pdf/working_papers/working_papers_301-350/HAP-RR-GITD-code.zip
[HAP_readme]: http://www.peri.umass.edu/fileadmin/pdf/working_papers/working_papers_301-350/PERI_WP322_readme.txt
[code gist]: https://gist.github.com/grayclhn/5446956#file-reinhart_rogoff_plot_growth-r

Addendum (on April 29, 2013)
----------------------------

A student made the following comment about the conclusion of this
post: “Looking at the data in order to determine your identification
strategy seems pretty suspicious to me.”

So I have a few thoughts on this.  First, I’m sympathetic to the
general idea; choosing a model after you’ve seen the data is a good
way to fit your model to noise and spurious artifacts of the dataset,
and well-run experiments try to minimize this sort of contamination
(through double-blind, etc).  But that’s not really an option in Macro
because there’s only one dataset (even if you view the individual
countries as different datasets, they’re highly interdependent: there
was only one Great Depression; there’s been only one global financial
crisis; and so on).

One consequence is that formal statistical tests, the kind that I
devote an enormous amount of time studying and teaching, have very
little influence on Macro theory.  You can see this throughout the
development of the RBC-style microfoundation literature, for example.
Macro develops in phases: there are relatively calm periods where
people tinker with and build on whatever models are established and in
fashion; and there are periods of crisis or near-crisis that highlight
the shortcomings of those models: the Great Depression; the Great
Inflation; Japan’s lost decade; the global financial crisis; etc.  A
lot of existing models get thrown out when the crisis reveals that
they’re missing important aspects of the economy (or are just fragile)
and then new models get proposed and developed following the crisis.
So you should view almost all of Macro as exploratory analysis and the
behavior during a new crisis as potentially confirmatory analysis.
It’s unfortunate that most journals require a veneer of statistical
inference before they’ll publish this exploratory analysis, but that
doesn’t change it’s fundamental nature.

It would be interesting to try to formalize this approach as an actual
experimental strategy, but I have almost no idea how you’d do it.

And remember, it’s usually not the established researchers that are
going to develop this new theory, it’s the current grad students,
future grad students, and a few professors at various stages in their
careers.  So this process doesn’t require any established economist to
change his or her mind (thank god).

<hr />
<a id="growth"> </a>

Full set of GDP growth plots
----------------------------

Remember, each plot shows annual GDP growth for the listed country,
with red indicating years where the debt/GDP ratio is greater than 90%.

![GDP Growth, Australia](pictures/2013_RR/growth_02.png =540x)

![GDP Growth, Austria](pictures/2013_RR/growth_03.png =540x)

![GDP Growth, Belgium](pictures/2013_RR/growth_04.png =540x)

![GDP Growth, Canada](pictures/2013_RR/growth_05.png =540x)

![GDP Growth, Denmark](pictures/2013_RR/growth_06.png =540x)

![GDP Growth, Finland](pictures/2013_RR/growth_07.png =540x)

![GDP Growth, France](pictures/2013_RR/growth_08.png =540x)

![GDP Growth, Germany](pictures/2013_RR/growth_09.png =540x)

![GDP Growth, Greece](pictures/2013_RR/growth_10.png =540x)

![GDP Growth, Ireland](pictures/2013_RR/growth_11.png =540x)

![GDP Growth, Italy](pictures/2013_RR/growth_12.png =540x)

![GDP Growth, Japan](pictures/2013_RR/growth_13.png =540x)

![GDP Growth, Netherlands](pictures/2013_RR/growth_14.png =540x)

![GDP Growth, New Zealand](pictures/2013_RR/growth_15.png =540x)

![GDP Growth, Norway](pictures/2013_RR/growth_16.png =540x)

![GDP Growth, Portugal](pictures/2013_RR/growth_17.png =540x)

![GDP Growth, Spain](pictures/2013_RR/growth_18.png =540x)

![GDP Growth, Sweden](pictures/2013_RR/growth_19.png =540x)

![GDP Growth, UK](pictures/2013_RR/growth_20.png =540x)

![GDP Growth, US](pictures/2013_RR/growth_21.png =540x)

<hr />
<a id="debt"> </a>

Full set of Debt/GDP ratio plots
--------------------------------

The red line indicates the low growth periods.  

![Debt/GDP, Australia](pictures/2013_RR/debt_02.png =540x)

![Debt/GDP, Austria](pictures/2013_RR/debt_03.png =540x)

![Debt/GDP, Belgium](pictures/2013_RR/debt_04.png =540x)

![Debt/GDP, Canada](pictures/2013_RR/debt_05.png =540x)

![Debt/GDP, Denmark](pictures/2013_RR/debt_06.png =540x)

![Debt/GDP, Finland](pictures/2013_RR/debt_07.png =540x)

![Debt/GDP, France](pictures/2013_RR/debt_08.png =540x)

![Debt/GDP, Germany](pictures/2013_RR/debt_09.png =540x)

![Debt/GDP, Greece](pictures/2013_RR/debt_10.png =540x)

![Debt/GDP, Ireland](pictures/2013_RR/debt_11.png =540x)

![Debt/GDP, Italy](pictures/2013_RR/debt_12.png =540x)

![Debt/GDP, Japan](pictures/2013_RR/debt_13.png =540x)

![Debt/GDP, Netherlands](pictures/2013_RR/debt_14.png =540x)

![Debt/GDP, New Zealand](pictures/2013_RR/debt_15.png =540x)

![Debt/GDP, Norway](pictures/2013_RR/debt_16.png =540x)

![Debt/GDP, Portugal](pictures/2013_RR/debt_17.png =540x)

![Debt/GDP, Spain](pictures/2013_RR/debt_18.png =540x)

![Debt/GDP, Sweden](pictures/2013_RR/debt_19.png =540x)

![Debt/GDP, UK](pictures/2013_RR/debt_20.png =540x)

![Debt/GDP, US](pictures/2013_RR/debt_21.png =540x)
