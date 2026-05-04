# CRM Scoring & Ticketing Master Plan

> **Source of Truth** — synthesized from `scoring.txt`, `ticketing system desugn.txt`, `final_ticketing_and_scoring_plan.md`

---

## Core Principle: Controlled, Additive, Capped Scoring

The AI classifier returns a raw intent score. **It is never used directly.** Instead, the server maps it into a controlled contribution (one of 6 criteria), each with a hard ceiling. The final ticket score is the sum of all contributions. This means:
- The AI cannot inflate scores by being overconfident.
- You can tune any single criterion without touching the rest.
- Every score is fully auditable — you always know *why* a ticket is at 70.

---

## Part 1 — Sales Ticket Scoring

### 1A. Score Ceiling Per Ticket Type

| Ticket Type | Auto Max | Reserved (Human) | Grand Max |
|---|:---:|:---:|:---:|
| `PERSONAL_ONLINE_COURSES` | **85** | 15 | 100 |
| `PERSONAL_OFFLINE_COURSES` | **85** | 15 | 100 |
| `CORPORATION_*` | N/A — immediate human transfer | — | — |

> [!IMPORTANT]
> The maximum score a ticket can reach is the **natural sum of all criteria maximums**. There is no artificial 100 ceiling, and no reserved points for humans. A sale can complete fully automatically — human handover only happens in the 4 specific cases defined in Part 5.

---

### 1B. The 6 Criteria — Hard Cap Per Criterion

#### Criterion 1 — Platform & Message Type (Max: 25)

| Platform | Comment/Reaction | Direct Message |
|---|:---:|:---:|
| TikTok | +10 | +15 |
| Instagram | +10 | +15 |
| Facebook | +10 | +15 |
| WhatsApp | N/A | **+25** |
| Telegram | N/A | **+25** |
| PSTN Call | N/A | **+25** (from ticketing design) |

Rule: Only the **highest applicable** platform score is taken per message. Not cumulative across messages.

---

#### Criterion 2 — Intent & Curiosity Signals (Max: 50)

The AI classifies the message into one of these intent tiers. The **highest tier detected wins** (not additive within the same message):

| Intent Tier | Example Phrases | Points |
|---|---|:---:|
| **Logistics Curiosity** | "متى يبدأ؟"، "كم المدة؟"، "حضوري أم أونلاين؟"، "منو المدرب" | +5 |
| **General Inquiry** | "بكم؟"، "متى؟"، "أين؟" | +10 |
| **Validation / Approval** | "طيب جميل"، "ممتاز"، "واضح" | +15 |
| **Registration Interest** | ذكر "الرابط" أو "التسجيل" | +15 |
| **Price & Payment Mode** | "بكم"، "السعر"، "خصم"، "تقسيط"، "طرق الدفع" | +25 |
| **Confirmation** | "خلاص تمام"، "اعتمد"، "سجلني" | +25 |
| **Buying Signal (Close)** | "ادفع كيف"، "رقم الحساب"، "بنكك"، "رابط التسجيل"، "خلاص سجلني" | **+50** |

> [!NOTE]
> The 50-point cap on this criterion IS the max for Criterion 2. If the intent score is "Buying Signal", Criterion 2 contributes 50. Combined with Platform (max 25), the score reaches 75 before any other criteria — correctly reflecting an extremely hot lead.

---

#### Criterion 3 — Response Velocity / Timing (Max: 25, Min: -10)

Applied when the **lead responds** to an AI message we sent (timer followup or regular reply):

| Response Time | Inquiry Content | Buying Intent Content |
|---|:---:|:---:|
| < 10 minutes | +10 | +25 |
| < 1 hour | +5 | +15 |
| 1–6 hours | +2 | +5 |
| 6–12 hours | 0 | +2 |
| > 24 hours (cumulative per day) | -10 | -10 |

**Implementation:** This is calculated by comparing `NOW()` vs `last_interaction_time` on the `crm_leads` table when a new message arrives.

---

#### Criterion 4 — Historical Data Baseline (Max: +60, Min: -50)

Applied **once** at ticket creation as a baseline modifier. Queried from `crm_leads` + sales history:

| Customer Type | Detection Logic | Modifier |
|---|---|:---:|
| **Loyal VIP** (1 past purchase) | SQL join on `course_reg` / `transactions` where lead_id has ≥1 successful sale | +40 |
| **Loyal VIP** (3+ past purchases) | Same, but count ≥ 3 | +60 |
| **Discount Seeker** | Last 3 closed tickets all had "خصم" keyword OR all orders had a discount applied | -15 |
| **Chronic Window Shopper** | Count of tickets with `closed=1` and no linked sale > 5 | -30 |
| **High-Maintenance / Refunder** | `course_reg.canceled` field has a refund request | -50 |
| **Cold Lead** (first contact) | No record found | 0 |

> [!WARNING]
> Historical modifier is **not** re-applied on every message. It is applied once at ticket open and stored in the ticket. If a new sale is completed, the modifier is recalculated for the NEXT ticket only.

---

#### Criterion 5 — Reaction Signals (Max: +5, Min: -5)

| Reaction | Score |
|---|:---:|
| ❤️ 👍 😲 😍 | +5 |
| 😡 😢 👎 😠 | -5 |

Rule: Reactions are **capped at one per ticket** (not cumulative). Negative reaction does NOT trigger human handover — it just deducts.

---

#### Criterion 6 — Deductions (No Cap on Deductions, Floor = 0)

| Trigger | Deduction | Follow-up Action |
|---|:---:|---|
| "غالي"، "أرخص عند غيركم"، "ما عندي ميزانية" | -15 | Send installment/discount info from KB |
| "سأرد لاحقاً"، "بشوف" | -30 | Start decay timer, low priority |
| "لا أريد"، "غير مهتم"، "احذف رقمي" | **Reset to 0** | Close ticket immediately |

---

### 1C. Score Ceiling Summary for Sales

| Criterion | Max Contribution |
|---|:---:|
| Platform & Message Type | **25** |
| Intent & Curiosity | **50** |
| Timing / Velocity | **25** |
| Historical Baseline | **60** |
| Reaction | **5** |
| **Natural Total Max** | **165** |

> [!NOTE]
> The ticket score ceiling is **165** — the honest sum of what every criterion can contribute at its peak. There is no artificial cap at 100. No human points reserved. A lead scoring 165 means every signal fired at maximum. A lead at 80 is Warm. A lead at 120+ is extremely hot. Thresholds in Part 2 are updated accordingly.

**Code rule:** Each criterion is individually capped at its own max (Platform cannot exceed 25, Intent cannot exceed 50, etc.). The server enforces per-criterion caps, not a total ceiling.
`finalScore = Math.max(platform_pts + intent_pts + timing_pts + history_pts + reaction_pts + deductions, 0)`



---

## Part 2 — Lead Status Thresholds & AI Behavior

The **lead score** (on `crm_leads` table) is a lifetime aggregate across all tickets. The **ticket score** is per-ticket. Both feed the status.

| Status | Ticket Score Range | AI Behavior |
|---|:---:|---|
| 🧊 **Cool** | 0 – 49 | Answer questions factually. Do NOT push. Do NOT mention payment. Gather info. |
| 🌡️ **Warm** | 50 – 99 | Be more engaging. Highlight course benefits. Mention enrollment deadline if available. |
| 🔥 **Hot** | 100 – 164 | Actively and nicely encourage payment. Provide payment methods (Bankak/Fawry). Ask for WhatsApp number to send direct payment link. |
| ✅ **Confirmed** | 165 | All signals fired. Trigger POST_SALE flow automatically. |

### Hot Lead WhatsApp Capture (from ticketing design)
When ticket score ≥ 100 (Hot):
1. AI asks for WhatsApp number naturally within the conversation — NO announcement of transfer or AI identity.
2. If WhatsApp number received → merge with lead profile → update `platform_user_id` for WhatsApp channel.
3. Send a direct WhatsApp payment link.

---

---

## Part 3 — Support & Complaint Tickets (NO SCORING)

As per the revised core principle, **Support and Complaint tickets do not use a scoring model**. 

- **Purpose:** These tickets are for issue resolution and service quality tracking, not purchase intent measurement.
- **Score Value:** Always remains **0**.
- **AI Behavior:** Driven entirely by the Knowledge Base (`crm_support_kb`) and the specific intent detection, not by a numerical score.
- **Human Handover:** Only triggered by the explicit cases defined in Part 4.
- **Close Condition:**
    - **Support:** Resolved by AI or Human.
    - **Complaint:** Customer explicitly satisfied or silence for 8h (assumed resolved).

---

## Part 4 — Human Handover (EXACTLY 4 Cases — No More)

Human handover is triggered **only** when one of these is detected. In all other cases, the AI handles autonomously.

| # | Case | Detection Logic |
|---|---|---|
| 1 | **Trust Loss / Anger** | AI detects phrases like "أنت روبوت؟"، "كلامك ده محفوظ"، "أديني زول أتفاهم معاهو" |
| 2 | **B2B / Corporation Sale** | Ticket code is `CORPORATION_*` OR text contains "شركتنا"، "موظفين"، "عرض سعر رسمي"، "مقر شركتنا" |
| 3 | **Fallback Loop Limit** | Same user sends 3+ messages that the AI could not answer meaningfully (detected via fallback counter per ticket) |
| 4 | **Instructor Join Request** | Ticket code `TRAINER_APPLICATION` OR text like "أنا مدرب". **Flow:** 1. AI asks for ability/qualifications. 2. Upon response, AI confirms review and then sets `transfer_to_human = 1`. |

**Action:** Set `transfer_to_human = 1` on the ticket. Log reason internally. The AI sends **no message announcing the transfer** — the customer must never feel they are being handed off to another team or that they were talking to a bot. The AI simply goes silent after its last natural reply, and a human agent picks up the conversation seamlessly from the ticket queue.

---

## Part 5 — Post-Sale Follow-up (NO SCORE)

This is a **pure scheduled automation**. No scoring involved. Three timed messages only:

| Message | Timing | Content |
|---|---|---|
| 1 | Course start day | Welcome + reminder of platform access |
| 2 | Course midpoint | Check-in: "كيف سير الكورس؟" |
| 3 | Course end | Satisfaction survey + certificate info |

**Stop condition:** If customer says they could not complete, or requests postponement, cancel ALL future timers for this lead immediately.

**Satisfaction signal** from these messages → update a `satisfaction_flag` on `crm_leads` (not the ticket). This feeds historical scoring for their NEXT ticket.

---

## Part 6 — Timer & Score Decay

| Ticket Type | Timer Interval | Decay on No Response |
|---|:---:|---|
| Sales (`PRE_SALE`) | 24h | -10 per 24h of silence. Zero → close as "lost". |
| Support | 4h | No decay. |
| Complaint | None | No decay. |
| Post-Sale | Scheduled (3 total) | No decay. Cancel on rejection signal. |

---

## Part 7 — Implementation Gaps to Fill (Priority Order)

| Priority | Gap | Action Needed |
|:---:|---|---|
| 🔴 1 | Each criterion is not individually capped in code | Enforce per-criterion max in server: `Math.min(platform_raw, 25)`, `Math.min(intent_raw, 50)`, `Math.min(timing_raw, 25)`, `Math.min(history_raw, 60)`, `Math.min(reaction_raw, 5)` — then sum them |
| 🔴 2 | Historical data not queried at ticket creation | Add SQL join to `course_reg` + `transactions` on ticket open |
| 🔴 3 | Timing/velocity criterion not implemented | Compare `NOW()` vs `last_interaction_time` on each incoming message |
| 🟡 4 | Hot Lead WhatsApp number capture not wired | Add detection + reply template when score ≥ 100 |
| 🟡 5 | Fallback loop counter not tracked | Add `fallback_count` column to `crm_tickets` |
| 🟢 6 | Instructor join request detection | Add keyword list to human-handover check |
| 🟢 7 | Duplicate profile merge (FB → WhatsApp) | Match by phone/name, merge `crm_lead_social_profiles` |
