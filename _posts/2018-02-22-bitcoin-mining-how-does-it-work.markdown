---
author: admin
layout: post
slug: bitcoin-mining-how-does-it-work
title: Bitcoin mining - how does it work?
categories:
- Blockchains
---

# Economics Behind Mining
To understand how mining really works, let's first understand the economics behind it.

The network of computers running the coin software (let's say Bitcoin) wants history (of transactions) to be recorded in the form of blocks, and it rewards those who do so with 12.5 BTC.

Bitcoin wants history to be recorded in a new block every 10 minutes. Additionally, since anybody could record history in a new block, it has to make sure that those who invested the most (electricity, stake, capacity etc) have a better chance of recording a new block, because those who invested the most are probably more interested in seeing Bitcoin work properly, as opposed to those who are trying to spend their Bitcoin twice.

Since recording a new block has a reward associated with it, and a new block mustn't appear too often, and those who write history may have nefarious intents, there is a need to make recording a new block artificially difficult. This is mining/Proof of Work.

# Mining and the Nonce
A Bitcoin block contains:
* The size of the block (so the computer knows when is the start and end)
* The block header
    - block version
    - previous block hash
    - Merkle Root
    - Timestamp
    - Difficulty
    - Nonce
* Transaction count
* Transaction list

Difficulty vs target: The target could be a huuuuge number, which the hash of the block has to be less than. Expressing such a huge number everywhere would be inefficient. Therefore, it's usually better to express the target as a difficulty, from which the target can be calculated. The larger the difficulty, the smaller the target, and therefore the harder it is to find a hash which is lower than the target.

Every coin has a different target-difficulty equation.

```
CryptoNote/Monero is 2^256-1/target = difficulty.
Ethereum: 2^256 / target = difficulty
Bitcoin: target = coefficient * 2^(8*(exponent-3)), where target is the first two hexadecimal digits of the difficulty and exponent is the rest.
```

The Bitcoin network makes finding a new block hard by saying "find me a block whose fingerprint (a number, but expressed in hexadecimal) is less than this number (the target)". Only the blockheader is used to compute the block's hash. It changes the target to make it just hard enough so that on average, a new block should be found every 10 minutes.

The point of all hash functions (in this case SHA256) is that they are properly random, such that if a single bit is different, this makes the hash totally different. Thus, you can only use trial and error to find a solution, and what you can change is the nonce in the blockheader. So you just start hashing the blockheader with different numbers for the nonce and hope that one of them meets the target. This is mining.

Over time, Bitcoin's difficulty has grown so much that you could roll all possible values of the nonce and still not get a hash that meets the target. They started rolling timestamps then but you can only change the timestamp so much. Hence the extranonce, which is embedded in the coinbase transaction of each block.

# Mining Pools
The mining pool is a separate software like a web CMS application. In fact, it usually comes with a web frontend so miners can login, check their stats and initiate payouts. It also needs a database so that the pool can keep track of miners' balances.

```
node ------ pool ---- miner
                |---- miner
                |---- miner
                |---- miner
                |----- website frontend
```

The pool polls the node every second or so to check for new blocks or network stats, and maintains a bidirectional TCP connection with the miner (mostly stratum). When the node tells the pool about a new block, the poll pushes out the new block to the miners. When a miner finds a nonce that worked, it sends the nonce to the pool.

Stratum is an important part of how a miner and a pool communicate. Imagine doing pool-miner communication over HTTP. HTTP was designed for applications where if a client wants something, it asks the server, the server communicates, and the TCP channel is closed afterwards. The server cannot initiate the communication, and the TCP channel has to be recreated each time communication is needed. This costs time.

With Stratum, a miner connects to a pool with a TCP connection, and they talk JSON over it. Stratum is more of a way of doing things, and not a standard/specification, so the JSON messages can be different for each coin/miner.

# Mining Pools and different Difficulties
You might have noticed that the difficulty the pool gives you is not the difficulty that the coin's network is at. In fact it's way lower. What's up with that?

If you give a single miner the network's difficulty, he'd take such a long time to find a nonce that satisfies the difficulty that you might not hear from him at all. And when he does finally contact the pool, how does the pool know that he's been doing work the entire time?

Thus the pool gives the miner a lower difficulty, just enough so that the miner only contacts the pool perhaps 3 times a minute. If the difficulty is too low for the miner, it'll find nonces and message the pool too often which would be like a DDoS. So the pool varies the difficulty depending on the miner's performance.

OK, but it you set a miner on lower difficulty, how is it ever going to find a nonce that meets the network's difficulty?

Remember the larger the difficulty, the smaller the target. Thus:

```
|         |                                 |
network's          miner's target
target
```

If you randomly try nonces and it meets the miner's target, there's still a smaller chance that it happens to meet the network's target too right? It's like throwing darts, except you must imagine you can't learn how to aim a dart. Over time, you'd be bound to hit the network's target too.

If the miner finds a nonce that satisfies the lower difficulty that the pool assigned it, it sends it to the pool. The pool checks if the nonce also satisfies the network's difficulty. If not, it records "miner xxxx put some work in and tried, award him some Bitcoin next time we actually do find a block". This is the so-called share. If a share meets the network difficulty, it wouldn't be a share. It would be a block.