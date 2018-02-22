---
author: admin
comments: true
date: 2017-09-29 21:21:15+00:00
layout: post
link: http://chiwbaka.com/concept-state-blockchains/
slug: concept-state-blockchains
title: The Concept of State in Blockchains
wordpress_id: 140
categories:
- Blockchains
---

While working on the code that makes up an actual cryptocoin, I'd always come across a class or something that would refer to a 'State'. And I never really knew what that was.

Was that the state of the coin's network, on the latest block?
The state of that node perhaps - but how could the node have a valid state when it's still busy downloading the blockchain?

It wasn't until I read Ethereum's whitepaper that the concept of state was formalized: it's the state of the coin as your node sees it, with the blockchain data it has on your computer.

Should your node not have the latest blocks, well then your node's state is out of date, and it needs to download more blocks and recalculate the new state from that.

Bitcoin's state is very simple. It is simply which addresses have how many coins, or the Unspent Transaction Outputs (UTXOs). The blocks don't have any information about the state; the Bitcoin client must calculate its own state based on the private keys it has in its wallet, and from what it has downloaded of the blockchain.

Ethereum blocks include the state in them, in that each block header holds a hash of the state tree's root, as well as hashes of the transaction and storage trees' roots (you wouldn't want blocks to always have a full copy of the state. That would be a waste of space. So you store them in a tree structure, where the branches can point to data (leaves) in older blocks).
What's in an Ethereum state?
1. The account's nonce (each time you send a transaction from this account, the nonce increases by 1. This is to prevent double spending)
2. The account's balance
3. storageRoot (data and Solidity programs go in here)
4. codeHash (what is this?)

Remember when you had to download that huge Bitcoin blockchain and wait for it to be synced up to the latest block just to know how much Bitcoin you have? In Ethereum, because the state is always stored with the block in this manner, you can just get the latest block, traverse the state tree (which points you to other blocks in the history that are relevant to your account) and you can get your balance much faster.

It seems many people like the idea of storing the state in blocks, since QRL also stores the state. The State in QRL consists of (for each account):
1. The account's nonce (this is everywhere. I wonder if Bitcoin accounts also have this)
2. The account's balance
3. a list of public keys that this account used before, to prevent them from being used again (One Time Signatures are what protects us from quantum computers)
4. a list of staking accounts (this is a PoS coin)
