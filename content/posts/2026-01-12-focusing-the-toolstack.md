---
title: "Refocusing the Toolstack: From Many Projects to Deep Mastery"
date: 2026-01-12
draft: false
description: "After starting too many projects at once, I'm taking a step back to focus on depth over breadth. Here's my refined approach to building with Claude Code, Conductor, and Gastown."
tags: ["development", "claude-code", "tooling", "productivity", "refocus"]
---

## The Realization

I made a classic mistake: trying to master too many tools at once without actually building anything. Droid, Antigravity, Takopi, Clawdbot, Gemini CLI—I jumped around learning and experimenting instead of shipping. Meanwhile, my actual projects got starved of attention: understanding Gastown and building the Imperator frontend—though I'm not even sure yet if it's truly useful, especially since I discovered Gastown has a dashboard command that I haven't tested yet.

Today marks a pivot. I'm stopping the tool-hopping cycle and committing to a focused, purposeful stack. These are the tools that actually work for my workflow—no more distractions.

## The Refined Toolstack

### 0. **Amp Code** - For Complex Tasks ($10 Daily Free Tier)
**Amp Code** is genuinely the best CLI tool I've used. It's expensive, but the **$10 daily free tier is more than enough** for my workflow. I use it strategically for complex, high-value tasks that need its power.

### 1. **Claude Code Max Plan** - The Core Engine
**Claude Code** remains my primary workhorse. The Max Plan gives me the best mix of speed and knowledge for actual implementation. This is where most of my real work happens.

### 2. **Codex CLI** - The Reviewer
For reviewing code that Opus/Sonnet generated, **Codex CLI** (powered by GPT 5.2 Codex and GPT 5.2) is still the best tool I've found. It catches what the others miss and provides solid critique. It's my quality control layer.

### 3. **GLM 4.7 + OpenCode** - The Economical Pair (When I Hit My Weekly Limit)
I hit my Claude Code weekly limit too fast, so **GLM 4.7** (from z.ai, surprisingly cheap and generous) paired with **OpenCode** became my cost-effective alternative. I'm watching closely as the maintainer of [Continuous-Claude-v3](https://github.com/parcadei/Continuous-Claude-v3) is forking into OpenCode with some impressive token-saving hooks, skills, and tools. That's where I'm interested in experimenting with context compression strategies.

I'm also looking forward to **GLM 5** and **Grok 4.2** releases coming soon—they could shift this dynamic.

### 4. **Clawdbot** - Remote Control via Phone
**Clawdbot** lets me remotely control an OpenCode/Codex/Claude Code instance from my phone. This is surprisingly powerful for managing long-running tasks or checking on automation while away from my desk.

### 5. **Conductor** - Serious Shipping
When it's time to ship real work, **Conductor** is my tool. The intuitive git worktree usage makes branching and deployment seamless. This is production-grade work.

### The Final Setup:
- **Amp Code** $10 daily free tier (complex CLI tasks)
- **Claude Code Max Plan** (primary implementation)
- **Codex CLI** (code review & critique)
- **GLM + OpenCode** (cost-effective + context compression experiments)
- **Clawdbot** (remote management via phone)
- **Conductor** (serious shipping & production work)

## A Note on Long-Running Tasks: The Ralph Wiggum Loop

There's buzz around the **Ralph Wiggum Loop**, but I'm skeptical. Here's the reality: it loops continuously while context gets progressively worse. The compression isn't effective—it's just summarized context that degrades the longer the task runs.

It *could* work if you have a really detailed spec or a well-defined todo markdown file, but even then, I think the method needs refinement. The problem it's trying to solve is real, but the solution feels incomplete.

I'm watching from the sidelines. When it works well, I'll reconsider. For now, I'm more interested in what the [Continuous-Claude-v3](https://github.com/parcadei/Continuous-Claude-v3) maintainer is building on OpenCode—real token-saving through hooks and tools feels more promising than aggressive looping.

## Model Strategy: Efficiency Over Luxury

To reduce token usage while maintaining quality:
- **Opus 4.5** for planning (thorough reasoning)
- **Sonnet 4.5** for implementation (fast execution)

This split gives me the best of both worlds: deep planning and rapid delivery.

## The 2nd Brain vs. CoWork

I had been thinking about building a second brain with **Obsidian + Claude Code**. But then **Claude CoWork** arrived—a game-changer that handles exactly what I was planning to build. There's no need to reinvent the wheel.

Instead, I'm refocusing on **finishing Imperator**. Once it's complete, I'll showcase it and publish it. Time is the real constraint now, not ideas or tools.

## The Path Forward

1. **Stop the tool-hopping cycle** — These six tools are my stack. Done exploring.
2. **Finish Imperator** — Get it shipped and published
3. **Check in on Gastown** — Steve Yegge and contributors have been actively working on it. I haven't touched it in a week, so I want to see how it's evolved and whether my frontend can work well with what they've built.
4. **Leverage Conductor** for serious shipping work
5. **Build with Claude Code Max** as the primary engine

Less breadth. More depth. Real shipping.

---

*The tools don't matter. Shipping matters. I'm finally ready to focus on that.*
