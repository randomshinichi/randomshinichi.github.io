---
title: "I'm hiring and firing these agents like my boss fired me"
date: 2026-10-23T02:20:00+09:00
draft: false
description: "What happened when I asked AI agents to port Golang to 32-bit PowerPC Macs, knowing nothing about what sits beneath the compiler."
tags: ["PowerPC", "Go", "AI agents", "compiler port"]
categories: ["projects"]
ShowToc: false
---

One Wednesday, trying to escape from overthinking a bad trade, I hit upon a great idea: what about porting Golang to PowerPC?

Better yet, what if I could do it like [Steve Yegge](https://yegge.ai/essays/the-shape-of-things-to-come/) — he doesn't even know what happens anymore, he just offloads the understanding to the AI swarm?

Better yet, I don't know anything about what goes on beneath the compiler — what if I could learn something from this?

Better yet, I can now use my PowerPC Macs for something truly useful! I'm not stuck with C/C++ anymore, which I don't know about and everybody says has terrible buffer overflow dangers that I better tiptoe around. And once Go is ported, how about getting Rust ported so the TenFourFox/Powerfox folks have an easier job of keeping up with upstream? yeah!

```text
iBook-G4:attempt-fullmake3b-20261020T102712Z shinichi$ tail -f make.bash.log
Building Go cmd/dist using /Users/shinichi/ppc32-bootstrap-prep-d3c2b5fa/goroot. (go1.26.8 darwin/ppc)
Building Go toolchain1 using /Users/shinichi/ppc32-bootstrap-prep-d3c2b5fa/goroot.
Building Go bootstrap cmd/go (go_bootstrap) using Go toolchain1.
Building Go toolchain2 using go_bootstrap and Go toolchain1.
Building Go toolchain3 using go_bootstrap and Go toolchain2.
Building packages and commands for darwin/ppc.
---
Installed Go for darwin/ppc in /Users/shinichi/nzgl-07c748ef-queueC-20261020b/goroot
Installed commands in /Users/shinichi/nzgl-07c748ef-queueC-20261020b/goroot/bin
*** You need to add /Users/shinichi/nzgl-07c748ef-queueC-20261020b/goroot/bin to your PATH.

iBook-G4:bin shinichi$ ./go version
go version go1.26.8 darwin/ppc
```

I had no idea of what had to be done though, and what I quickly found out was that even if the AI tells me, knowing is still different from really feeling the terrain. But no matter, let's spin up my Powermac G5 Quad!

Yeah that is one sexy beast. Picked up for a measly 100EURs because the owner hated it, because it was crashing from bad RAM. The owner hated it so much he didn't even care when a nail gashed the side of the beautiful case. And this was a unit where the LCS never leaked! The fans spin up — yes, the LCS needs servicing. But doesn't it sound awesome in the meantime? Must be like revving up your Lamborghini Countach or Miura. Not the fastest these days but you don't care. It even warmed the room slightly.

A week passed, and I found that the agents weren't using it most of the time. In fact, the AI swarm was using QEMU on my Thinkpad (a bright idea of mine, sped up troubleshooting immensely) to emulate a PowerPC Mac running Linux and wasting most of its time on distinctly unsexy stuff, the validation harness! Because apparently there are many problems there? Meanwhile the G5 Quad was in full airplane mode, CPU B hits 80, 90C whenever it's slightly loaded (but CPU A is well cooled), and it crashes every ~2.5 days. I thought I changed the RAM already? whatever, I found 10x1GB sticks of DDR2 unbuffered ECC RAM on eBay. cleaned out the seller.

`darwin/ppc64` [self-hosts and passes the test suite](https://github.com/randomshinichi/go/commit/6674697ab9ec671a5c9350b0ab15c1974f37a0f5). Little did I know that somehow 32bit support for G3, G4 CPUs was going to be a whole lot of pain.

I hooked up my precious iBook G4 1.2GHz I had had since 2015 for a mere 50EUR. The most reliable Mac I've had, its battery still holds a charge! It's just plain white, you'd never think it looks beautiful in the photos, but in person? the white looks somehow translucent. One day I'll repack the battery with new 18650s.

Somehow progress had slowed, and the AI swarm was using the ibook a lot more often to test. Why? Surely there was a better way to do things like on the ppc64 port, where most bugs were fixed on QEMU PPC64? wait, what is this long running subagent? it's still using CPU? I try to use the iBook, but the GUI is acting funny. What's going on? I stop the subagent. It was apparently testing some `os.whateverthefucksomethingtodowithremovingfiles`. it was testing that on my actual iBook? fuck... I really can't leave these agents to their own! The install was trashed.

Luckily I had a system backup that I didn't even know about.

I really can't leave these agents to their own.

---

`qwen3.8-flash-next` does amazing things, like writing its own HFS+ parser and PPC assembly, but also forgets important things (yes, they forget things!) while orchestrating a fleet of agents and generally just can't decide its way into autonomously achieving a goal. All of them. All of them do that with a project this messy. At one point, they weren't even working on the port anymore — they were working on everything around it, all my credits were going to producing reams and reams of documentation and 'pinned artifacts' required by a 'census', sprawled all over my computer and its tmpfs, and no you can't just delete them because 'x beads cite these files'. I'm going to cut the Gordian Knot very soon, I swear, I'm going to fire all of them, give them lobotomies, fresh contexts, start `/new`. It's not the model's fault. it's the environment, their previous contexts that made them develop a habit instead of following that instruction in AGENTS.md.

Well, I was like that too, going down rabbit holes, losing the bigger picture, striving to get more done — AI agents are very good at getting more done — and maybe that's why I was fired too.

Back in the GPT-2 days those models remembered every single thing. But we wanted longer context, and we'd already learned to live with people who forget.
