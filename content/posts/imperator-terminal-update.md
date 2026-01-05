---
title: "Imperator Update: Polishing the Terminal UI and Tooling Experiments"
date: 2026-01-05T12:00:00Z
draft: false
tags: ["imperator", "ui", "agents", "vibeproxy", "droid", "claude", "codex", "gemini"]
description: "A minimal terminal UI for Imperator, plus my latest experiments with Vibeproxy, Droid, and model access."
---

I spent most of today back in the Imperator codebase, and I made a decision: the UI is going full terminal.

I wasn't trying to create a new format from scratch. I just wanted to polish what was there. But as I cleaned it up, the terminal-first approach just clicked.

## The UI Is Changing

The new direction is minimal, fast, and focused.

- The terminal is the hero
- Commands become UI buttons
- The activity feed goes away
- Beads live on the right

It feels significantly more polished now. Less noise, more signal.

![Imperator Frontend](/images/260105_imperator_2.jpeg)

## The Subscription Maze

I hit my Opus weekly limit again. So I'm back to Codex for now, but frankly, it's not enough for what I'm trying to do.

Managing these model subscriptions is becoming a full-time job. To keep track of all the usage ceilings without losing my mind, I started using **CodexBar**.

![CodexBar Usage Tracking](/images/250105_CodexBar.png)

I also finally caved and started the **Google AI** plan today after seeing that Opus 4.5 can be routed through Antigravity.
Here's how I'm splitting my subscriptions right now to maximize throughput:

- **Antigravity** for a bit more Opus usage (plus the first month was free).
- **Claude Code** as my main driver for Opus 4.5.
- **OpenAI Plus** for GPT-5.2 / GPT-5.2-Codex Medium. I've found the scores are similar to High and xHigh, but I hit the limits way less often.
- **Qwen Code** because why not, it's free and I can use it for other things.


## Droid, Vibeproxy, and Reality

I really wanted to get **Droid** (by Factory.ai) working with **Vibeproxy**. The dream was to use my existing Codex and Claude Code subscriptions inside Droid without paying double.

It wasn't easy. At first, I could only access Gemini Pro models, and getting Codex to work required understanding the configuration codebase, reading through some issues, and [submitting a pull request](https://github.com/automazeio/vibeproxy/pull/145). But it was easy enough to get it working with Gemini 3 Pro.

![Vibeproxy Settings](/images/250105_VibeProxy.png)

But since I knew Opus could be used via Antigravity, I decided to go down the rabbit hole.

I dug into the Vibeproxy repo, added the Anthropic extended-thinking beta header, and forked it. I updated the code, built the Swift app, and ran it locally. It took multiple attempts and a lot of trial and error, but eventually, I got it: Vibeproxy finally talking to Droid.

It works, but it's not perfect. Droid is still a bit bugged for me. Gemini 3 Pro is unreliable, but the Codex and Claude models seem stable, so I'm sticking to those for now. However the Opus limit on Antigravity is really small, but atleast i can use it like 1-2 hours every 5 hours and there does not seem to be a weekly limit.

![Droid Setup](/images/250105_droid.png)

I also saw that Vibeproxy supports **Amp Code**, which is next on my list. I keep hearing Amp is better for large codebases because it handles model routing behind the scenes. I'm curious to see if that holds up in practice.

## A Future Idea

I saw this tweet today and it immediately sparked an idea for Gas Town:

[![Gas Town 3D Concept](/images/260105_X_post.png)](https://x.com/joshpuckett/status/2007926313726939452)

Maybe **Three.js + Gas Town** could get me there? A spatial view of my agents working? That's a problem for another day.

---

*Next up: test Amp Code through Vibeproxy and keep refining the Imperator terminal UX.*
