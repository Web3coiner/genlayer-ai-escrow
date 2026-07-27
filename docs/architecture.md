# GenLayer AI Escrow Architecture

```text
               Buyer
                 │
                 ▼
          Deposit Funds
                 │
                 ▼
        Escrow Smart Contract
                 │
      ┌──────────┴──────────┐
      │                     │
      ▼                     ▼
 Release Funds         Open Dispute
      │                     │
      ▼                     ▼
 Seller Paid      Buyer & Seller Submit Evidence
                              │
                              ▼
                    AI Decision Recorded
                              │
                  ┌───────────┴───────────┐
                  ▼                       ▼
            Release Funds            Refund Buyer
```

## Components

- **Buyer** deposits funds into escrow.
- **Seller** receives payment after buyer confirmation.
- Either party can initiate a dispute.
- Both parties can submit evidence.
- An AI decision determines whether to release or refund the funds.
