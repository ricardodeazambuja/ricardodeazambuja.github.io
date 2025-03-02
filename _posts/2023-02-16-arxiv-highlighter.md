---
layout: post
title: Annotating papers and sharing your thoughts, directly from your browser
category: deep_learning
draft: true
published: true
comments: true
---

In the last weeks I've been reading a lot of papers. Usually I open an online document (e.g. google docs) and write down my notes there while I read a paper. However, I also like to highlight a pdf as I read it, but that forces me to download the pdf and keep the final file. Therefore I was trying to find a way to annotate a pdf directly from my web browser... and that's the motivation that made me hack together my very own [`arxiv-highlighter`](https://github.com/ricardodeazambuja/arxiv-highlighter)!

<!--more-->

Keep in mind that I am a [Javascript dinosaur](https://peterxjang.com/blog/modern-javascript-explained-for-dinosaurs.html), hence the code is a hack :smiley:.

Here is an example from a multi-page pdf annotated directly from [arXiv](https://arxiv.org/):     

[https://ricardodeazambuja.com/arxiv-highlighter/#url=https://arxiv.org/abs/2103.04423&page=1&cdata=IwGg5iAMB0wBxWgZgCyIExpkgbCAQgKYA2A9gO4AE5AFgIYAulAzqQLaGUDGpArgHYMATgEtCzbqX7MRAE0JDKDGpzZ0AHiLa821QiLA0mAI0IAzUkM7LO-QoVmULi5gAdCXEXWKViIroTS4iCUhAxc0ABkoKSIAKzoiMAAnIgA7HGISJkAirx0sjyuDAqUvDL8YJR0lGwi6gy8VpSkZpSiYHLV-I5mxISaxv2UrnRCDMxRiUJJWNDomTDoaRgrACoqlMZ0bMakpJQAbgoyUpQiEoR0MqUMB8a8IsSyIQ9MIu8S-cwSQqQPzCYdDAdBE0iYXCE1xUk0iiQAnhg8EsVjAUKklghIkhwIhIKjoJBFtBkqAljiNuJOFpgeJqs0bO0rqx+EoaBcRrSlHQANZ0siVW4HKw9BQAQiAA](https://ricardodeazambuja.com/arxiv-highlighter/#url=https://arxiv.org/abs/2103.04423&page=1&cdata=IwGg5iAMB0wBxWgZgCyIExpkgbCAQgKYA2A9gO4AE5AFgIYAulAzqQLaGUDGpArgHYMATgEtCzbqX7MRAE0JDKDGpzZ0AHiLa821QiLA0mAI0IAzUkM7LO-QoVmULi5gAdCXEXWKViIroTS4iCUhAxc0ABkoKSIAKzoiMAAnIgA7HGISJkAirx0sjyuDAqUvDL8YJR0lGwi6gy8VpSkZpSiYHLV-I5mxISaxv2UrnRCDMxRiUJJWNDomTDoaRgrACoqlMZ0bMakpJQAbgoyUpQiEoR0MqUMB8a8IsSyIQ9MIu8S-cwSQqQPzCYdDAdBE0iYXCE1xUk0iiQAnhg8EsVjAUKklghIkhwIhIKjoJBFtBkqAljiNuJOFpgeJqs0bO0rqx+EoaBcRrSlHQANZ0siVW4HKw9BQAQiAA)

* `#url=https://arxiv.org/abs/2103.04423`: arxiv url
* `&page=1`: starts at page 1
* `&cdata=...`: compressed data in URI friendly format

You can find more details and source code directly in the repo: https://github.com/ricardodeazambuja/arxiv-highlighter

~~One problem I see with this approach is the fact I am sending this huge request to the server, even though the server isn't using it at all because everything happens inside the browser (Javascript). Maybe something using a URL with `javascript:` (kind of blocked by modern browsers when you cut and paste)? Another option would be to open a prompt where the user could paste the compressed data directly, but this way you would need to copy the data, click on a link and only after the page is loaded paste the compressed data... it seems annoying to me.~~ Solved by using a `#` instead of `?` (thanks to [stackoverflow](https://stackoverflow.com/a/68170088)).

**Note (2025/03/02)**
Apparently, something changed in regards to how the servers (arXiv and/or github) are configured and the cross-domain thing is blocked. Thus, arxiv-highlighter is no more :crying face:.