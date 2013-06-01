---
layout: blog
title: Git workflow and links
author: Gray Calhoun
---

I’m setting up a real. honest-to-goodness public opensource project, which is an opportunity to learn more about the software that I kind of take for granted.  I use Git for version control, you should use it too, and store a lot of files on [GitHub](https://github.com/gcalhoun).  Apparently people really like "no fast-forward" merges and I’ve never really understood it so I looked into it some more and decided that I’m quite happy with rebasing heavily (it seems like you can get the apparent benefits of *no-ff* just by tagging a lot, so I’m still a little mystified by its attraction).

* If none of that made sense, [this seems to be a dominant git workflow, and it helped me get started](http://nvie.com/posts/a-successful-git-branching-model).  But, again, I don’t like no-ff merges and like to rebase before merging back into the main branches (this preference is not necessarily apparent if you go to my GitHub page...)

* These two posts, by [Benjamin Sandofsky](https://sandofsky.com/blog/git-workflow.html) and [Isaac Schlueter](http://blog.izs.me/post/37650663670/git-rebase), describe rebase well and make me really think that I need to start using git-bisect.

* [Linus Torvald’s email on git workflow for the Linux Kernel is really helpful too](http://www.mail-archive.com/dri-devel@lists.sourceforge.net/msg39091.html).

This post is really an excuse for me to have a place to put these links, obviously.

