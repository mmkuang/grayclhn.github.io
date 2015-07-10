---
layout: blog
title: LaTeX CV template
author: Gray Calhoun
---

I recently read Karen Kelsky's ("Dr. Karen's") excellent [academic CV
rules][1] and tried to follow her advice and revise [my CV][2]. It
seems like other people could find it useful too, so I wrote up
most of the changes as a LaTeX document class (the `safecv` document
class) and put it [on GitHub][3].

The repository gives you a document class that sets up formatting for
section headers, etc. and also gives you two empty-ish templates to
use for your own CV. One is tailored a bit towards grad students
entering the academic job market for the first time, and one is more
generic. I'm not a graphic designer, and you're probably not either,
so the CV uses Times New Roman. It is the default, conservative,
"professional" font for those of us who predate Office 2007, which is
essentially everyone who will be in a position to hire you. (Since I
have no impulse control, I took this opportunity to [buy the Lucida
TeX fonts][4] and could not be happier with how they look. But my wife
still insists that my CV looks better in Times.)

Is it a great CV template? Nope. Is it better than most of the other
CV templates I've seen? Yep. Almost entirely because, as Dr. Karen
suggests, all of the important dates are flush left and the text is
relentlessly left-aligned. Most of the other CV templates I've seen
are much slicker looking, but they put key information in different
random spots in different sections of the document. Don't do that.

Please open an issue on [GitHub][5] if you find errors. Pull requests
are welcome too. And read [Dr. Karen's advice][1] most of all.

[1]: http://theprofessorisin.com/2012/01/12/dr-karens-rules-of-the-academic-cv/
[2]: http://gray.clhn.org/dl/calhoun-cv.pdf
[3]: https://github.com/grayclhn/safecv
[4]: https://tug.org/store/lucida/
[5]: https://github.com/grayclhn/safecv/issues