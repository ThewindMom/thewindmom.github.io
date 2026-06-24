---
title: "Going Model-Agnostic: Five Months of Multi-Harness Chaos"
date: 2026-06-22T18:00:00Z
draft: false
description: "After Anthropic locked Claude Code to their own harness, I went all-in on Codex and spent five months iterating through Droid, Amp, OpenCode, Pi, and a pile of token-saving libraries. Here's where I landed, and what I ripped out."
tags: ["development", "codex", "tooling", "pi", "opencode", "droid", "model-agnostic", "token-saving"]
---

Five months. That's how long it's been since my [last post](/posts/2026-01-12-focusing-the-toolstack/). Five months of tool-hopping, token-chasing, harness-building, and a lot of opinions piling up. This post is long, so I've divided it into clear sections. Skip to whatever interests you:

- **The Harness Journey**: why I left Claude Code, what I tried (OpenCode, Factory Droid, Amp, Conductor), and why Herdr won
- **Mobile and On-the-Go**: the Codex app, Litter, and working from a phone
- **Going Deep on Pi**: the harness that changed everything, RLM, and the Pi flavors (omp, senpi, gajae-code)
- **The Token-Saving Rabbit Hole**: what I tried, what failed, what I kept (only magic-context)
- **Where I Landed: The June Stack**: subscriptions, current stack, and what I still miss from Claude Code
- **Why Factory Keeps My Attention**: Missions, model independence, and the software factory vision
- **Why I'm Optimistic**: what Satya Nadella and Eno Reyes got right about building and businesses

This obviously doesn't cover everything from five months of learnings, but whatever I forgot to mention here is probably not relevant anymore anyway.

## The Harness Journey: January → June

In January, Anthropic and Google stopped letting users run the Claude Code and Antigravity subscriptions in other harnesses.
I wanted to be model-agnostic. So I switched back to **Codex** as my primary subscription and committed to it.

The upside: **Codex burned through usage far slower than Claude Code ever did.** With Claude Code Max, hitting the weekly limit was trivially easy: a couple of long sessions and you were done. Codex was more forgiving, which meant I could actually work without constantly watching a quota meter.

The downside: Codex alone wasn't enough for everything. Which is where the last five months of chaos began, and only recently started to settle.

I'm not going to pretend this was a clean progression. It was a mess. Here's the actual path:

1. **OpenCode + Oh-my-Opencode**: My entry point back into the model-agnostic world. Oh-my-Opencode (now renamed **Oh-my-openagent**) gave me hooks, skills, and agent orchestration on top of OpenCode. This is where I first started treating the harness as something I could shape rather than just use.

2. **Factory Droid**: I set up Droid with Claude-style hooks and skills, bring-your-own-key style. On Linux I ran my Codex subscription through **CLIProxyAPI**; on macOS through **Vibeproxy**. Both expose your existing subscriptions as a local OpenAI-compatible endpoint, so Droid could call GPT-5.5 through one proxy. It worked, but setup was fiddly. Nearly every update broke something, whether on the Factory Droid side, the CLIProxyAPI side, or OpenAI having issues, but I didn't mind that one bit, because Tibo kept pushing the reset button right afterwards.

3. **Amp Code**: Same story: I used CLIProxyAPI Plus to hook my OpenAI Codex sub into Amp. These days Amp ships native subscription support, so the proxy dance is unnecessary. I still use Amp for frontend tasks; its `smart` mode routes through Claude Opus.

4. **Conductor**: I dropped it. It only supported Claude Code and Codex, and I was already moving toward harnesses that could swap models freely. No point in a tool that locks you back into two providers.

 For the interface layer (the thing I actually stare at), I bounced through **emdash**, **cmux**, **Superset**, **Supacode**, and **Kaku**. They're all trying to solve the same problem: how do you manage multiple agent sessions without losing your mind? They're all decent. None of them stuck, except perhaps Kaku, a terminal by Tw93: Tw93 always delivers aesthetic projects with clean features and that Asian minimalism I love.

<figure>
<img src="/images/260622_tibo_reset.png" alt="Saint Tibo: Giver of Tokens, Resetter of Limits" />
<figcaption>Saint Tibo, patron saint of Codex rate limits. <a href="https://x.com/sama/status/2056804900017947046">If this tweet gets 1 like, Tibo will reset Codex rate limits.</a></figcaption>
</figure>

### Where I Landed: Herdr

Nowadays I only use **[Herdr](https://github.com/ogulcancelik/herdr)**. It's a tmux-like multiplexer built for coding agents. I don't want to think about my terminal multiplexer. I want to think about my code.
Herdr tracks agent state (working / blocked / done / idle) across sessions and survives detach/reattach over SSH. That's the whole feature set I need.

## Mobile and On-the-Go

Before this month, my mobile workflow was **Tailscale + Herdr + Moshi** on my phone. SSH into my machine, drive a session from the phone. I still do this for general tasks and for harnesses where mobile support is poor: OpenCode, the different Pi flavors, and so on. **Factory Droid's** mobile experience isn't there yet either.

But this month that changed.

### The Codex App Got Good

I've been using the **Codex desktop app** more and more. The turning point was when **SIGkitten** (the developer behind **[Litter](https://github.com/dnakov/litter)** / KittyLitter, the native iOS/Android Codex client) joined OpenAI. Since then the app has gotten noticeably better and more intuitive.

The mobile integration is the killer feature for me. The Codex app on my phone connects to sessions running on my PC, so I can kick off work at my desk, walk away, check on it from my phone, and steer if needed. Working on the go went from "tolerable" to "actually pleasant." It's a joy to use now.

## Going Deep on Pi

The biggest shift in my stack was going all-in on **Pi**, the minimal terminal coding-agent harness with a TypeScript extension system. I installed a *ton* of extensions and wrote some of my own, mostly to save tokens and to work around **Kimi's tendency to doom-loop** (endlessly cycling without making progress).

Pi's flexibility is what sold me. OpenCode has plugins. Factory Droid (and later Codex) has hooks. But both are limited compared to what Pi's extension model allows. When you control the tools, the prompt fragments, the hooks, and the model routing, you can save a lot of tokens by being surgical about what enters context.

 What it could unlock, for example, was **RLM**, [Recursive Language Models](https://alexzhang13.github.io/blog/2025/rlm/). Instead of stuffing everything into one giant, stale context window, the model treats long inputs as an external environment it can inspect and decompose recursively. It's a fundamentally different approach to context rot: the gradual degradation where a long session accumulates noise until the model loses the thread. RLM solves this at the architecture level, not by compressing or summarizing (which degrades quality), but by letting the model navigate the context on demand.

 This is the kind of thing that could only be implemented in Pi. OpenCode, Claude Code, Codex: none of them are flexible enough to restructure how context enters the model. Pi's extension system gives you access to the tool surface, the prompt pipeline, and the model loop itself, so you can wire in an RLM-style approach without fighting the harness. It's revolutionary for long-running autonomous sessions, and it's one of the biggest reasons I'm not going back.

### Pi Flavors: omp, senpi, gajae-code

Pi's extensibility means people build distributions on top of it. I went through three:

- **[Oh My Pi (omp)](https://github.com/can1357/oh-my-pi)**: The "batteries-included" fork. This is currently my daily driver. Two features keep me here: **Mnemopi** (persistent long-term memory across sessions) and **session-learning** (the harness learns from completed sessions and adjusts). The model routing is granular. In my config, GLM 5.2 handles default/slow/plan/advisor roles, Kimi K2.7 handles vision and task delegation, and GPT 5.5 handles code review. That split alone saves tokens because I'm not burning a frontier model on every subtask.

- **[Senpi](https://github.com/code-yeongyu/senpi)**: code-yeongyu's opinionated fork. Two things I love: **prompt presets per model** (different models need different system prompt strategies) and **verifiables for every single todo task** (each task has a concrete verification step). The built-in LSP, ast-grep, and goal-tracking extensions are excellent.

- **[Gajae-Code](https://github.com/Yeachan-Heo/gajae-code)**: A more experimental flavor, by the creator of OmX and OmC. I ran it with GLM 5.2 at max reasoning across all roles.

## The Token-Saving Rabbit Hole (and Why I Climbed Out)

Since Codex wasn't enough on its own, I spent the last five months chasing token efficiency. The thesis: if the harness is flexible enough, I can compress context aggressively and squeeze more out of every subscription.

I went through the full library gauntlet:

- **rtk** (Rust Token Killer): compresses shell command output before it hits context
- **vcc**: VIP-token-centric context compression
- **caveman**: reduces agent verbosity, short replies
- **condensed-milk**: Pi-specific token compression
- **magic-context**: manages conversation history, prunes irrelevant turns, writes memories in intervals
- **aft**: context optimization
- **tldr**: token-efficient code analysis (AST, call graphs)
- **headroom**: compresses everything the agent reads

Did I save tokens? **Yes, definitely.** I was hitting my weekly limits a few days earlier before all this; afterward, I stretched them further.

But last week I was chatting with **YeonGyu Kim**, the maintainer of Oh-my-openagent, and something clicked. I asked him whether it made sense to install headroom and rtk to save tokens. His answer was blunt: *"If you try to reduce token usage, it will hurt the model's intelligence, because those token usages don't lie."*

I pushed back: surely there's a way to be more efficient. He agreed that code exploration could be optimized, but pointed out where OmO actually burns tokens: *"QA and work verification, which is what lets you delegate your work. It won't make dramatic changes."*

He was right. I'd been so focused on compressing tokens that I missed the real bottleneck. **Generating code is easy. Validation is the bottleneck.** Writing, implementing, shipping: that's the cheap part. The expensive part is verifying the agent actually did it right. Unit and integration tests aren't enough: the agent can hallucinate tests, or when tests fail, quietly edit the tests to make them pass instead of fixing the code. And how do you validate frontend? You need a browser (Playwright, agent-browser), and even then you have to check it looks right across all the resolutions your app targets. That's a genuinely hard problem, and no token compression library solves it.

Another voice in the conversation was even more direct: *"Any compression tool is straight up bull. They will heavily lower your performance. And it doesn't matter anyway since a lot of your tokens are just cached."*

I'd seen this myself. I tried caveman, rtk, headroom, condensed-milk, tldr, and until now I also noticed that the agent heavily struggled and did more turns when using those tools. The calls themselves cost fewer tokens, but the iterations took longer. Sometimes it failed entirely.

Here's the failure mode: when a library overrides tool calls or rewrites context, the model gets confused. It can't find what it's searching for as easily. The individual calls cost fewer tokens, but the **iterations took longer**: more turns to accomplish the same thing, sometimes outright failure.

And the deeper problem: **these models are RL-trained on none of these interventions.** They've been trained to work with raw tool outputs and full context. When you mangle that, you're fighting the model's training distribution. You save tokens per call but spend tokens on retries and confusion.

### What I Kept

Last week I uninstalled everything. Even rtk, which was the hardest to let go of.

The one thing I still use is **magic-context**. It's different from the others: it only deletes history that's no longer relevant to the current task, and it writes memories at intervals of what it learned during the session. It doesn't override tool calls or rewrite outputs; it manages the conversation window itself. That's a surgical intervention that works *with* the model instead of against it.

## Where I Landed: The June Stack

Since Codex alone wasn't enough, I started delegating different task types to different providers and bought into multiple plans over the last months to test that out, and to make use of the cheap models that were available (since then they either reduced the limits, increased the prices, or the performance just got worse in terms of TTFT and token/s price ratio):

- **Minimax plans**: for exploring and librarian tasks
- **Kimi plans**: for execution
- **OpenCode Go**: to try out different open-source models and see the limits

In the end I unsubscribed from all of those. They weren't enough. I hit the limits too fast.

 A few weeks ago I was still on **Firepass v1 and v2** because it included unlimited Kimi K2.5 / K2.6 usage. A few days ago they sunsetted that plan as it was not feasible for those. That's understandable.

Now I'm testing a plan that gives me **GLM 5.2 at a reasonable price**. GLM 5.2 is my workhorse for most coding nowadays: it's comparable to GPT-5.5 medium in both price and quality efficiency. I offset the multimodality gap by delegating **vision tasks to Kimi K2.7**, which is also in the plan. So it's GLM 5.2 for everything except vision (Kimi K2.7) and small review tasks (GPT 5.5). For bigger tasks I stay with GPT 5.5.

My daily stack as of June 2026:

| Tool | Role | Model(s) |
|------|------|----------|
| **omp (Oh My Pi)** | Primary harness, most work | GLM 5.2 (default), Kimi K2.7 (vision/tasks), GPT 5.5 (review) |
| **Factory Droid + Missions** | Multi-agent orchestration, large projects | GLM 5.2 (workers), GPT 5.5 (orchestrator) |
| **Amp Code** | Frontend tasks | Claude Opus (`smart` mode) |
| **OpenCode + OmO** | QA, review, testing workflows | GLM 5.2, Kimi K2.7, GPT 5.5 (team mode) |
| **Codex + OmO** | Primary subscription, visual QA | GPT 5.5 |
| **Herdr** | Interface / multiplexer | - |
| **Codex App** | Mobile + desktop sync | GPT 5.5 |

I love how **Oh-my-openagent** focuses heavily on QA, reviewing, and testing. Now that **Codex added Browser Use** (full CDP access to drive a real Chromium instance), visual QA feels genuinely good. The agent can open a browser, navigate, screenshot, and verify that what it built actually looks right. That closes a loop I used to do manually.

### What I Still Miss From Claude Code

One thing: **frontend work.** For frontend tasks, I go back to **GLM 5.2** because GPT 5.5 and its earlier iterations genuinely suck at frontend. GLM 5.2 handles CSS, component layout, and visual coherence far better.

This isn't just a feeling. GLM 5.2 actually tops the **[Design Arena](https://evals.report/benchmarks/design-arena?tab=scores)** leaderboard (a crowdsourced benchmark where users vote head-to-head on anonymized frontend/design outputs) with **1360 Elo**, making it the highest-ranked open-weight model for frontend generation. On Arena.ai's WebDev leaderboard it holds **1595 Elo** in the snapshot I checked, second only to Claude Fable 5. For landing pages, dashboard mockups, React/Tailwind prototypes, and design-to-code prompts, it's genuinely strong. GPT 5.5 can't compete on visual coherence and frontend aesthetics. ([Some context on this here.](https://x.com/Designarena/status/2069166634976371084))

That's the one gap I felt since switching from Claude Code, but it's okay.

## Why Factory Keeps My Attention

Factory Droid earned more than a table row above. Beyond the practical "it works," I keep coming back to Factory because of how the company thinks, and honestly, because of the aesthetics. Factory has a coherent design language across their terminal, desktop app, and web: restrained, dark, technical without being sterile. The Droid CLI doesn't feel like a research project someone slapped a TUI on. It feels like a product. It has that Asian minimalism I keep gravitating toward, the same thing I love about Kaku and everything Tw93 ships.

But aesthetics only get you so far. What actually keeps me paying attention is their stance on model independence, which is also the whole thesis of this post.

### Model Independence (and Why It Mattered This Month)

On June 12, 2026, Anthropic [suspended access to Claude Fable 5](https://www.anthropic.com/news/fable-mythos-access) for all customers after a US government export-control directive citing national security. Fable 5 had launched three days earlier and was briefly available inside Droid (and everywhere else Claude models run). If you were a shop locked to one provider and Fable was your workhorse, that was a bad week.

Three days after the suspension, Factory announced [Factory 2.0: From coding agents to software factories](https://factory.ai/news/software-factory). The timing wasn't subtle. Their post laid out three pillars, and the first one is the one I care about:

> **Model Independence.** Every model has a different trade-off of cost, performance, and speed. No one model fits every need within an enterprise. Your software factory must allow your organization to deliberately choose different models, or rely on a Router to automatically (or rule-based) select the best model for any given task. As models commoditize, costs decrease while speed and performance increase.

That's the whole point of going model-agnostic. Not because it's trendy, but because models get pulled. Providers make deals with governments. A model that was available today gets disabled tomorrow. When your harness is model-agnostic, a model disappearing is an inconvenience. When it isn't, it's a work stoppage.

The other two pillars matter too. **Sovereign Intelligence**: you control where the system runs and it learns from itself, air-gapped if you need it. **Continual Learning and Self-Improvement**: every stage of the SDLC is instrumented, so a security finding informs the next code review, a deployment triggers a documentation update, an incident correlates with the PR that caused it. This is the part that actually matters most. Compounding knowledge, where a harness genuinely learns from sessions and gets better over time, has not been done in a stable way yet. The harness that cracks this, where session traces feed back into the system and the learning persists across model swaps, that would be revolutionary in the current timeframe we are in. The architecture is right, and I'm already seeing early versions of this with Mnemopi and session-learning in omp. The gap between "early version" and "stable compounding" is where the real work still lies.

### Missions: The Harness Thinking I Actually Use

I've been using Factory's [Missions](https://factory.ai/news/missions) feature since it was announced in February 2025. Missions is what made me respect how Factory thinks about agent architecture, not just product surface.

The premise: a single agent session hits limits. Context fills up, attention degrades, the agent starts re-reading files and losing the thread. The instinct is to run agents in parallel, but they conflict, duplicate work, and drift without structure. Missions takes a different approach. Instead of fighting the limits of a single agent, it works with them. The architecture is three roles:

| Role | Job |
|------|-----|
| **Orchestrator** | Planning, scoping, re-scoping |
| **Workers** | Feature implementation, clean context per feature |
| **Validators** | Adversarial verification, QA, computer use |

The key insight, [from Luke Alvoeiro's talk on Factory's multi-agent architecture](https://www.youtube.com/watch?v=ow1we5PzK-o), is that validation must be written before the code, not after. Tests written after implementation don't catch bugs. They confirm decisions. Missions uses a "validation contract" defined during planning that specifies what "done" means independently of how the code is written. For a complex project that's hundreds of assertions, and each feature must satisfy its assigned assertions. The sum of all features must mean every assertion is covered.

That resonated because it's the exact conclusion I reached independently in the token-saving section above. Generating code is easy. Validation is the bottleneck. Factory built a whole architecture around that insight, and the validators are adversarial by design: they haven't seen the code before, they're not invested in the implementation. This is the "measure twice, cut once" philosophy [Eno Reyes described in his demo](https://www.youtube.com/watch?v=j7CaMx2c56M): most agents measure once, cut once, measure again, cut again. Factory validates iteratively.

They also run features serially rather than in parallel, because agents step on each other's changes and make inconsistent architectural decisions. It seems slower on paper, but the error rate drops dramatically, and for multi-day tasks that correctness compounds.

And then there's the architecture's relationship to model improvement. Every multi-agent builder has this fear of the next model release making their architecture obsolete overnight. Factory's answer: almost all orchestration logic lives in prompts and skills, not a hard-coded state machine. About 700 lines of text define how the system decomposes features and handles failures. Four sentences of this can alter the execution strategy dramatically. The only deterministic logic is thin bookkeeping: running validation, blocking progress on unaddressed handoff issues. The models provide the intelligence; the system provides the discipline. So when models improve, the system gets better, not obsolete. That's a model-agnostic architecture done right.

### What I'm Excited About

The [Software Factory announcement](https://factory.ai/news/software-factory) is the thing I'm most excited about right now. Factory is building toward a system where: signals (bug reports, customer feedback, business requirements) get triaged and turned into planned changes, those changes get built, tested, reviewed, secured, shipped, and monitored, and the monitoring generates more signals. A continuous feedback loop. Almost no one has meaningfully instrumented this loop to be fully AI-driven yet, but Factory is laying the track.

That's the Factory I keep coming back to. Not because Droid is perfect (it isn't; setup is fiddly, updates break things). But because the company thinks about the right problems: model independence, validation as a first-class concern, architecture that survives model churn. The aesthetics are the hook. The philosophy is why I stay. Long Factory.

## Why I'm Optimistic

Two things I read this month made me genuinely optimistic about where this is heading.

**Eno Reyes** wrote [something](https://x.com/EnoReyes/status/2066354320199864710) that cuts against the common assumption that model labs have an inherent advantage in building harnesses:

> The harness informs the model. As task complexity increases, you need to develop specific strategies, workflows, and capabilities to solve increasingly difficult tasks. These get built into the harness. Then the harness traces get introduced into the model's post-training pipeline. The model learns the workflow and behavior, and gets better at completing the task directly. This means great harnesses set the direction of models.

The causality runs the *other direction* from what most people assume. The harness shapes the model, not the other way around. At the limit, great harness traces get injected into every model through post-training convergence, because post-training datasets converge. Model labs have talented teams and money, but those are "very different from a durable advantage or moat." The people building the best harnesses today are setting the direction of the models of tomorrow.

**Satya Nadella** made the case for why this matters beyond tools, [for businesses and the broader economy](https://x.com/satyanadella/status/2066182223213293753):

> Importantly, human capital does not become less valuable as token capital grows. It only becomes more valuable! I believe human agency will be the driver of token capital growth. Humans will set ambitious goals, connect dots across domains, build relationships, and recognize patterns that matter most. Without human direction, you have compute running in circles.

There's a lot of doom talk about AI taking jobs. Satya's framing is the counterargument that actually holds up. The jobs don't disappear. They shift from execution to direction: setting ambitious goals, connecting dots across domains, recognizing patterns that matter.


> The last thing any of us want is a world where every company across every sector is ceding value to a few models that eat everything they see. If all the value is accrued by only a few models, the political economy will simply not tolerate it. There is no societal permission for an AI future that hollows out entire industries.

Entire industrial economies were hollowed out by outsourcing. The GDP numbers looked fine on the surface, but the displacement was real. He's saying: don't let that happen again with AI. The answer isn't to stop building. It's to build your own learning loop. Turn your workflows, domain knowledge, and accumulated judgment into AI systems that improve with each use. Private evals that measure whether a model is actually getting better at *your* outcomes, not just external benchmarks. Private RL environments that let models grow stronger on real traces from inside *your* organization. That loop becomes the new IP of the firm.

Both of them are pointing at the same thing from different angles. The model is replaceable. The system you build around it is not. That's why I'm optimistic, and it's also why I spend so much time engineering my harness. The harness is the asset, not the model. That's all there is to it.

---

*In the end I keep coming back to Naval Ravikant's framing: [waste tokens, save time](https://nav.al/tokens). Better to spend tokens to save time.*
