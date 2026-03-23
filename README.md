# Imperial Astro-Chronicle

An on-chain registry of cosmic events and user interpretations, inspired by the Warhammer 40,000 universe.  
Each event is a text-only description of a stellar, warp, or astral phenomenon.  
Any user may also add interpretations to previously recorded events, creating a collaborative astro‑lore archive.

This project is purely textual and non-financial.

---

## Contract Address and Verification

The contract is deployed and verified on BaseScan:

**https://basescan.org/address/0x4a7874d8d319fef03993cabebd9e4c81705917fc#code**

From this page you can:

- Inspect the verified source code  
- Read all recorded events in `events`  
- Read all interpretations in `interpretations`  
- Call `recordEvent` to register new cosmic phenomena  
- Call `interpretEvent` to add interpretations  
- Track `EventRecorded` and `InterpretationAdded` events  

---

## Contract Overview

Main file: `contracts/ImperialAstroChronicle.sol`

The contract exposes:

- `Event[] public events` – full list of cosmic events  
- `Interpretation[] public interpretations` – all interpretations ever added  
- `recordEvent(string name, string description, string eventType, uint256 importance)`  
- `interpretEvent(uint256 eventId, string text)`  
- `totalEvents()`  
- `totalInterpretations()`  

Each **Event** contains:

- `name` – name of the cosmic event  
- `description` – narrative description  
- `eventType` – Astronomican, Warp-Star, Eclipse, Rift-Signal, Unknown  
- `importance` – 1 to 5  
- `recorder` – address that created the event  
- `timestamp` – block timestamp  

Each **Interpretation** contains:

- `eventId` – which event it refers to  
- `text` – interpretation text  
- `interpreter` – address that added it  
- `timestamp` – block timestamp  

---

## Safety

This contract is intentionally minimal and safe:

- No `payable` functions  
- No ETH transfers  
- No external calls  
- No owner or admin  
- No token logic  
- No selfdestruct  

Users only pay gas to write text on-chain.

---

## How to Use (Remix)

```solidity
recordEvent(
  "The Silent Beacon",
  "A dimming of the Astronomican lasting exactly 13.13 seconds.",
  "Astronomican",
  5
);

interpretEvent(
  0,
  "The pulse matches the resonance of a dying star. A warning, perhaps."
);
