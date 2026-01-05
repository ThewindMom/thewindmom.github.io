---
title: "Imperator Update: A Terminal UI and Tooling Experiments"
date: 2026-01-05T12:00:00Z
draft: false
tags: ["imperator", "ui", "agents", "vibeproxy", "droid", "claude", "codex", "gemini"]
description: "A minimal terminal UI for Imperator, plus my latest experiments with Vibeproxy, Droid, and model access."
---

Today was a continuation of the Imperator build, but with a new direction: I turned it into a terminal UI.

## Imperator UI direction

I am keeping it minimal:

- The main terminal stays front and center
- Commands become UI buttons
- I removed the noisy activity panel below
- Beads live on the right
- Overall look is more modern and polished

## Model access and tooling updates

I hit Opus weekly usage, so I am back to Codex for now, but that is not enough.

I also started the Google AI plan after seeing that Opus 4.5 can be used through Antigravity.

I wanted to try Droid with Vibeproxy (so I can use Codex, Claude Code, and other subscriptions inside Factory.ai). I got it running after a post, but at the time I could only access Gemini Pro models there, and Codex only through a pull request.

Because Opus could also be used via Antigravity, I dug into the Vibeproxy repo, added the Anthropic extended-thinking beta header, forked it, updated the code, built the Swift app, and ran it. After multiple attempts, Vibeproxy worked with Droid.

Droid is still a bit bugged for me: it does not work well with Gemini 3 Pro, and it is only reliable with Codex and Claude models, so I am sticking to those for now.

I also saw Vibeproxy could be used for Amp Code, which I want to try next. I have heard Amp is better for large codebases and does more model routing behind the scenes, so I am curious how that feels in practice.

---

*Next up: test Amp Code through Vibeproxy and keep refining the Imperator terminal UX.*
