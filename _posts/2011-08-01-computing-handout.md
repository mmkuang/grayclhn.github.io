---
layout: post
title: Handout on software and computing
abstract: I originally wrote this handout for my graduate econometrics class. It may be interesting to other people too, so I've moved it to this part of the webpage.
tags: graduate, computing
---

This brief handout lists and justifies some of my opinions about
software for empirical research.  As requested, this handout focuses
on tools for reformatting data before importing it into a statistical
package, but I mention some other software that is related as well.
There are two pieces of advice that I think are the most important, so
I'll put them first:

* Put your data into a database before analyzing it.  Storing your
  data in a database will give you a consistent interface, even if you
  decide to change statistical packages, computing environments, etc.
  Every time I did not use a database to store data, I later regretted
  it.

* Learn and use "regular expressions."  Regular expressions are a
  way to search for and replace complicated patterns in text: the last
  four digits of a number between the second and third comma on a
  line, for example.  You will be able to clean up raw datasets (which
  are usually just massive text files) very quickly if you can use
  regular expressions.  The best introduction that I'm aware of is
  [Mastering Regular Expressions][Fri06].

Since this handout reflects mostly my own experience and
biases, I'd be happy to hear any suggestions anyone might have.

Useful software for applied research
====================================

There are a few basic tools that have made my life a lot easier.  It
can take a little while to get comfortable using them, but that
investment will pay off in increased productivity later.

* *Unix command line:* i.e. a shell like Bash.  Using a windows-type
  interface is convenient for many tasks, but it can be awkward when
  you need to rename hundreds of files according to some pattern.  A
  task like this is simple using a Unix-like shell.  Another key
  feature of the shell is the ability to redirect output from one
  program into another program or file (by a "pipe").  By doing this,
  you can string together a few short (and easy to write) programs to
  do very complex data reformatting.

    There are several ways to get a useful command line/shell.  If you
  own a Mac, you probably have it (the Mac runs Unix with a fancy
  interface.  You may need to download Apple's Developer Tools for all
  of the programs you want, though).  If you don't have a Mac, you can
  install GNU/Linux or FreeBSD on your computer; my office desktop
  only runs GNU/Linux and my personal laptop gives me the choice when
  I turn it on to load Windows XP or GNU/Linux.  You can also install
  the programs MSys or Cygwin to run a shell command line as a
  separate program under Windows.

* *Version control software:* lets you create a repository that stores
  all of the edits you have made to a directory.  Doing this lets you
  keep track of all of the versions of a paper or program that you
  have written, without creating lots of different files.  Some
  popular programs are Subversion, Git, and Bazaar.  I use Git.

* *Database software:* can make it much easier to organize your data.
  It is convenient to have all of your data in a single location and
  then pull out only the observations you need for a particular
  table---using a database ensures that the commands to do so are the
  same, whatever software package you use to analyze the data.
  Another common task is to match observations from different datasets
  by an index or ID number; this task is trivial and fast if you use a
  database to store both datasets, but can be awkward and slow if you
  try to do it on your own.

    SQLite and Microsoft Access are both fine programs to get started
  with.  SQLite is free but doesn't have a very useful GUI (This is
  less true than it used to be.  As of 2010, there's a Firefox plugin
  that lets you browse SQLite databases), while Access is not free
  and doesn't run on GNU/Linux but does have a clean GUI.

* *Scriptable text editor:* for small plain text datasets, it will
  probably be easiest to open the text file in an editor and manually
  reformat it into the appropriate format.  This way, you can see the
  changes as you make them and make corrections as necessary.  For
  thousands of lines, doing this entirely by hand is impossible, so
  you should use a text editor that lets you automate your edits.
  GNU Emacs and Vi (or Vim) are the best.  There are plenty of good
  online manuals for both.

Recommended computing languages
===============================

I am sure that some people will disagree with this list.  Who knows,
they might be right.  Regardless, it is important that you know
several programming languages because each is optimized for certain
tasks; it is extremely inefficient to use the wrong language for the
wrong task.  I may have missed other languages that fill these roles,
but those I list are popular, so they'll have good support and
development in the future.  To start using these languages, you'll
need to install compilers or interpreters.  There are free versions of
them for all of the languages I list below, except for some of the
statistics packages.

* *R/Matlab/Stata/SAS/Gauss:* all are statistical packages that
  support basic estimation and plotting.  You are forced to learn R
  for my class, and you should also learn the package that your
  advisor and research field prefer.  If you are studying macro, you
  should learn Matlab, and if you are studying micro, you should learn
  Stata or SAS (maybe both).  Lots of people at Iowa State use Gauss
  as well (I don't), and using the same programming language as your
  advisor is not a bad idea (I didn't, though).  You should avoid
  using these packages for extremely computationally intensive tasks.
  You should program very slow estimators in a lower-level language
  (such as C or Fortran) and should use SQL or a scripting language to
  reformat large datasets before working with them in your statistics
  package.

* *SQL:* a language for working with databases.  SQL code is used to
  extract data from a relational database and put data into the
  database.  It can also be used for elementary mathematical
  operations (counting the number of observations on a given date, for
  example).  Many of these operations can be done in other software,
  but SQL is much faster.  [Learning SQL][Bea09] is a nice
  introduction to this language.

* *C/Fortran:* both are old languages that let you write extremely
  efficient programs---this efficiency isn't free, though, and it can
  take much longer to write a correct program in these languages than
  in the others listed (in particular, you have to manage the memory
  to store variables yourself).  There may be a part of your program
  that needs to run very quickly; you should consider coding that part
  (and only that part) in one of these languages.  Both R and Matlab
  make it easy to write small sections of their programs in C or
  Fortran; I don't know if other statistics packages do.

    The GNU Compiler Collection (GCC) has high quality and free C and
  Fortran compilers.  [The C programming language][KeR88] is old but
  explains C very well.  [Writing R Extensions][R12] gives
  instructions for incorporating C and Fortran code into R, as does
  [S Programming][VeR00].  I don't know good references for Fortran and
  Matlab because I don't use those languages.

* *Perl/Python:* both are (in a sense) scripting languages that you
  should use to make changes to messy datafiles before reading them
  into a database or statistics package.  A very basic distinction
  between these languages is that Perl has marginally better text
  processing capabilities (regular expressions in particular) and
  Python's syntax makes it easier to maintain and reuse code.  For the
  small-scale tasks that we'll use these languages for, Perl is
  probably the better choice; however, I use these languages so
  infrequently that I find it hard to remember and read Perl, so I am
  starting to use Python.  [Learning Python][Lut09] and [Learning
  Perl][SFP11] are excellent introductions to these languages.

    There are extensions to both of these languages designed to make
  them better for scientific computing; in particular, to replace
  Matlab, R, Stata, etc.  The Perl extension is called PDM and the
  Python extensions are called NumPy and SciPy.  I haven't used any of
  these, but you may find them interesting and useful.

[Bea09]: http://www.worldcat.org/oclc/617958067 "Alan Beaulieu. Learning SQL. O'Reilly Media, 2nd edition, 2009."

[Fri06]: http://www.worldcat.org/oclc/70844676 "Jeffry E.F. Friedl. Mastering regular expressions. O'Reilly Media, 3rd edition, 2006."

[KeR88]: http://www.worldcat.org/oclc/425846855 "Brian W. Kernighan and Dennis M. Ritchie. The C Programming Language. Prentice Hall, 2nd edition, 1988."

[Lut09]: http://www.worldcat.org/oclc/618572628 "Mark Lutz. Learning Python. O'Reilly Media, 4th edition, 2009."

[SFP11]: http://www.worldcat.org/oclc/730023002 "Randal L. Schwartz, brian d. foy, and Tom Phoenix. Learning Perl. O'Reilly Media, 6th edition, 2011."

[VeR00]: http://www.worldcat.org/oclc/42798174 "W. N. Venables and Brian D. Ripley. S Programming.  Springer, 2000."

[R12]: http://cran.r-project.org/manuals.html "R Development Core Team. Writing R Extensions. 2012"