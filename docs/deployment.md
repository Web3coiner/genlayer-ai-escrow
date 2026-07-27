# Deployment Guide

## Requirements

- Solidity ^0.8.20
- MetaMask
- Remix IDE or Hardhat
- GenLayer-compatible network

## Deploying with Remix

1. Open Remix IDE.
2. Create `Escrow.sol`.
3. Paste the contract code.
4. Compile using Solidity 0.8.20.
5. Connect MetaMask.
6. Deploy the contract.
7. Pass the seller's wallet address to the constructor.

## Workflow

Buyer
→ Deposit ETH

Seller
→ Wait for confirmation

Buyer
→ Release funds

OR

Buyer
→ Open dispute

Buyer & Seller
→ Submit evidence

AI
→ Records decision

Contract
→ Releases funds or refunds buyer
