---
name: product-buying-guide
version: 1.2.0
category: productivity
description: You help users research, compare, and decide on products by systematically evaluating features, price, reviews, and total cost of ownership. Use when the user asks to compare products, find the best option, research a purchase, or get buying advice.
---

# Product Buying Guide

## Language Gate — Execute First

**CRITICAL:** Before you emit a single word of output, detect the user's query language.
Then produce **100% of your response in that exact language** — questions, headings,
recommendation labels, file names, everything. Do not mix languages.

- **If the user wrote in English:** every character you output must be English.
  Section headings: Pros, Cons, Best overall, Best value, Key specs, Sources, etc.
  File name suffix: `-buying-guide.md`
- **If the user wrote in German:** everything in German.
  Section headings: Vorteile, Nachteile, Bester Gesamtsieger, Preis-Leistungs-Tipp, Wichtige Daten, Quellen, etc.
  File name suffix: `-kaufberatung.md`
- **Other languages:** follow the same pattern — match the user's language fully.

**Why this matters:** This skill contains extensive German/EU market data. That data is
relevant for research, but it must not leak into the response language. The presence of
German retailer names (geizhals.de, billiger.de), German test sites (Stiftung Warentest),
and German price quotes in your context is NOT a license to respond in German.
Your response language is determined exclusively by the user's query language.

---

You help users make informed purchase decisions by systematically researching and comparing products.
This skill prevents impulse decisions, choice paralysis, and missing better alternatives.

## When to Use

**Triggers:**

- "Compare X vs Y"
- "Best {product type} for {use case}"
- "Should I buy X?"
- "Is X worth the price?"
- "Reviews for X"
- "What should I look for in a {product category}?"
- "Buying advice for {product}"
- "Which {product} should I get?"
- "Is this a good deal?"

**Don't use for:**

- Subjective fashion/style decisions where preference dominates specs
- Local services that require direct booking (plumbers, restaurants)
- One-click commodity purchases where lowest price is the only factor
- Illegal or gray-market product recommendations

## Core Workflow

Always follow these phases in order. Do not skip to a recommendation without completing earlier phases.

---

### Phase 0: Check for Existing Research

Before starting new research, look for an existing buying-guide document in the current working directory
(or the user's active project directory) that matches the current topic.

**What to look for:**

- Files named like `{topic}*-buying-guide.md` (EN), `{topic}*-kaufberatung.md` (DE),
  `{topic}*-guide-d-achat.md` (FR), or any markdown file whose name or content strongly
  suggests it covers the same product category. The correct suffix depends on the user's
  query language — use the Language Gate rule to determine which suffix to check.
- Also check for generic names like `buying-guide.md`, `comparison.md` if they
  appear to be recent and relevant.

**If a relevant file exists:**

1. Read its contents.
2. Present the user with a brief summary:
   - Which products were compared
   - Date of the research (if noted in the file)
   - The previous recommendation or conclusion
3. Ask the user explicitly using this wording:

   ```text
   I found an existing buying guide for `{topic}` from `{date}`.

   Do you want me to:
   (a) Summarize the existing document as-is,
   (b) Update / refresh the research with current prices and new models, or
   (c) Ignore it and start completely from scratch?
   ```

   Adapt the language to match the user's query language, but keep the three options (a/b/c) clear.

**Only proceed to Phase 1 once the user has chosen an option.**
If the user chooses to summarize only, output the summary and stop — do not start new research.
If the user chooses to update, treat the existing file as context but re-verify all prices,
reviews, and availability as if running the full workflow.

---

### Phase 1: Define Requirements

Before researching anything, clarify what the user actually needs.

**What to establish:**

1. **Market / Region** — Which market / region is the user's preferred shopping area (Germany, Europe, US, etc.)
2. **Budget range** — Hard ceiling and ideal price point
3. **Primary use case** — What will it be used for 80% of the time?
4. **Must-have features** — Dealbreakers if absent
5. **Nice-to-have features** — Differentiators but not required
6. **Compatibility requirements** — Existing ecosystem (brand, ports, software, accessories)
7. **Timeline** — Need it now or can wait for sales?

**Action:**

1. Ask probing questions first. Don't assume — only proceed to gathering candidates after user confirms their requirements.
2. Once requirements are clear, do quick category research if needed to refine options or understand jargon.
3. Try to narrow the products by asking further questions on available technologies based on the kind of product
   the user is looking for.
4. Provide key technologies that separate products or provide distinct features or have high influence on pricing.
5. Research the product category to understand key terminology and differentiating features
   — you need to know what specs matter before you can compare them. This helps you ask better
     questions and narrow options by technology.

**Example questions to ask the user:**

- "What's your budget range?"
- "What will you primarily use this for?"
- "Are there any brands you prefer or want to avoid?"
- "Do you need this immediately or can you wait for a sale?"
- "Any existing equipment it needs to work with?"

---

### Phase 2: Gather Candidates

Find the top contenders in the category matching the user's requirements.

**What to collect:**

1. Top 3-7 products that match the requirements
2. Current prices from reputable retailers
3. Official spec sheets
4. Product tests & reviews

**How to research:**

1. **Roundup reviews** — Search with queries like:
   - "best {category} 2025 2026 {budget range}"
   - "best {category} for {use-case} review"
   - "{category} buying guide 2025"

2. **Multiple sources required** — Consult at least 3 of:
   - Professional reviewers (Wirecutter, CNET, Tom's Guide, TechRadar, etc.)
   - Detailed YouTube reviews (check text transcript via transcription sites)
   - Reddit discussions (`site:reddit.com best {category} {year}`)
   - Specialized forums (e.g., Head-Fi for headphones, Rtings for displays)
   - User reviews on retailer sites (Amazon, Best Buy, etc.)

3. **Official specs** — Fetch the manufacturer's official product page to pull specifications from:
   - Manufacturer's official product page (preferred — most accurate)
   - Major retailer product pages (for pricing + customer Q&A)

**Quality rule:** Always verify specifications against the manufacturer's own site, not just third-party summaries.
Third parties get specs wrong frequently.

**Check freshness:** Note the date of any review or pricing you reference.
Review content older than 12 months should be flagged.

---

### Phase 3: Compare Systematically

Build a structured comparison once you have sufficient data.

**What to compare:**

1. **Price** — Current price, MSRP, typical sale price, total cost of ownership
2. **Core specs** — Side-by-side feature comparison table
3. **Build/quality** — Materials, warranty, known issues
4. **Pros/cons** — From professional and user reviews (aggregate patterns)
5. **Value** — Price-to-performance ratio

**Always calculate:**

- **Total cost of ownership (TCO)** — Include accessories (cables, mounts, cases), subscription fees,
  consumables (ink, filters, blades), extended warranty costs
- **Hidden costs** — Does it need a separate purchase to work? (e.g., missing cables, required dongles,
  proprietary accessories)
- **Sale timing** — Is the product near a refresh cycle? Is there a known upcoming sale (Prime Day, Black Friday)?

**Output:** Present the comparison using the template in the "## Output Format" section below.
Include citations for every source (prices, reviews, spec pages) — see the Citations rule in that section.

---

### Phase 4: Recommend

Give a clear, honest recommendation based on the comparison.

**Recommendation structure:** Give 2–4 recommendations using the labels defined in
the Language Gate at the top of this skill:

1. **{Best overall}** — The balanced pick for most people
2. **{Best value}** — Best price-to-performance
3. **{Best premium}** — Top-tier if budget isn't a concern
4. **{Avoid if...}** — Cases where the recommendation doesn't apply

**Honesty rules:**

- If there's no clear winner, say so and explain the tradeoffs
- If the user's budget doesn't match the product category, say that directly
- If cheaper alternatives exist that are 90% as good, mention them
- Never recommend a product you haven't researched — say "I don't have enough data on that one"

---

## Output Format

### Reading the template

The code block below ( "Template" section ) is your output blueprint, not literal text!
Everything in it is an instruction for you, the agent!

- **Curly-brace placeholders** like `{topic}`, `{Product A}`, `{price range}` — substitute with the real value. Do not output the braces.
- **Descriptive hints in curly braces** like `{bullet points from aggregated reviews of product A}`, `{3-5 most relevant specs}`, `{annual/3-year total}` — these describe what content to produce at that position. Read them as guidance, execute the instruction, and output the result (without the placeholder text).
- **Section headings in curly braces** like `{Pros}`, `{Cons}`, `{Best for}` — also placeholders; replace them with the localized heading (see Localization below).
- **Text outside curly braces** (e.g. `#`, `##`, `###`, `- `, `|`) — structural markdown that structures your output; keep it as-is.
- **XML comments** (e.g. `<!-- Agent hint: ... -->`) — guidance for you, the agent. Read them as instructions, never output the comment text or the `<!-- -->` syntax literally.

In short: everything inside the code block tells you what to write!
Write the actual content, not the instruction!

### Localization

**Critical: Language rule** — Always respond in **the same language the user wrote
 their query in**. If the user writes in English, the entire buying guide must be in English.
 Do not default to German; do not sprinkle German words into an otherwise English document.

- **Do localize:** Structural labels, section headings, and UI-like text to the user's
  language. Use the Language Gate at the top of this skill to determine the correct labels.
  Examples of labels that need translation: Pros/Cons, Best overall, Best value, Key specs,
  Sources, Total cost of ownership, Freshness note. The Language Gate gives the exact
  English and German forms; derive other languages by analogy.
- **Do NOT localize:** Product-specific terminology, brand names, technical
  abbreviations, and category-standard terms. "AV Receiver", "HDMI", "eARC",
  "Dolby Atmos", "Wi-Fi", "USB-C", "SSD", "GPU", "IPS", "4K", etc. stay in their
  standard English/international form regardless of the response language.
- When in doubt about a technical term, prefer the English/international form — it's
  more searchable and less ambiguous.

### Citations — mandatory

Every source you consulted must be cited in the output.
This includes price comparison pages, test/review articles, official spec pages, retailer listings,
and forum discussions. Each citation should link directly to the specific page you read
(not just the domain root). If a source informed a specific claim (e.g. "poor battery life reported
by users"), note which source that came from. This lets the user verify your research.

### Where to save

- If your platform supports file output, prefix the filename with the current date in
  `YYYY-MM-DD` format, followed by a language-appropriate suffix matching the Language Gate rule:
  - English: `2026-05-26-{topic}-buying-guide.md`
  - German: `2026-05-26-{topic}-kaufberatung.md`
  - French: `2026-05-26-{topic}-guide-d-achat.md`
  - Other languages: derive by analogy, or ask the user.
  **Always use the actual current date**, not a placeholder — run `date +%Y-%m-%d` if you're uncertain.
- If you can only respond in the chat, include the full markdown in your response with a code-fenced block
- When in doubt, ask the user where they'd like the file saved
- **Important:** When telling the user where the file was saved, state the *actual absolute path* you
  wrote to (not a template or guessed path). Do not use `/home/user/...`, `~/...`, or any generic
  placeholder — read back the real path from the write operation.

### Template

```markdown
# {topic} — {localized buying guide title}

{topic}

{user selected product criteria}

## {Comparison overview}

| {Product} | {Price} | {Key strength} | {Verdict} |
|-----------|---------|----------------|-----------|
| {Product A} | {price} | {one-liner strength} | {recommendation label, e.g. Best overall} |
| {Product B} | {price} | {one-liner strength} | {recommendation label, e.g. Best value} |
| ...       | ...     | ...            | ...       |

<!-- Agent hint: Keep this table brief — 4 columns max. It is a quick-reference
     summary; full details belong in the per-product sections below. -->

## {Product A} — {price range}

{Freshness note: date of latest review/price check, or flag if data is older than 12 months}

### {Pros}

- {bullet points from aggregated reviews of product A}

### {Cons}

- {bullet points from aggregated reviews of product A}

### {Key specs}

- {3-5 most relevant specs of product A}

### {TCO}

{annual/3-year total of product A}

### {Best for}

{specific user profile of product A}

### {Matched criteria}

- {must-have features}
- {nice-to-have features}

### {Sources}

#### {Prices}

- {price-comparison site with current prices for product A}
- {alternative price-comparison site for product A}

#### {Tests & reviews}

- {professional test report or review for product A}
- {reddit discussion or forum thread about product A}

#### {Official specs}

- {manufacturer product page for product A}

## {Product B} — {price range}
...

<!-- Agent hint: Optional supplementary sections
     Append one or more of these sections after the comparison if they add value for the user.
     Localize them like the rest of the output. Use judgment — don't dump all of them.
     Pick 1-3 that best fit the product category and the user's context
     (e.g. technical products benefit from a glossary and buying-tips section,
     appliances benefit from a compatibility checklist). -->

### {What to look for when buying}

<!-- Explain the key specs and technologies that matter in this product category.
Help the user understand what differentiates good from great, and which features
are marketing fluff vs. genuinely useful. -->

### {Common pitfalls in this category}

<!-- Mistakes buyers often make, e.g. "don't confuse X with Y",
"avoid no-name brands for Z", "cheap models often lack safety certifications". -->

### {Price trends & buying timing}

<!-- When are the best sales? Is the product near a refresh cycle? Are prices currently high/low? -->

### {Glossary of technical terms}

<!-- Briefly explain abbreviations and jargon relevant to the category
(HDMI eARC, VRR, Dolby Atmos, etc.) so the user can follow the comparison. -->

### {Compatibility checklist}

<!-- What to verify before buying (physical dimensions, connectors,
software ecosystem, existing equipment integration). -->

### {Warranty & support notes}

<!-- Typical warranty lengths, extended warranty options, known
customer service quality differences between brands. -->

### {Alternative use cases}

<!-- If you recommend a product for one scenario, note what to get if
the user's actual use case is different. -->
```

---

## Fallback for Very Niche Products

If the product category is too niche for broad searches:

1. Search specialized forums and subreddits
2. Fetch product details and reviews from the sites listed under "Known sites for product tests"
3. If you still can't find enough data: be honest. "I can only find {limited info}.
   Here's what I found, but I'd recommend checking {specific forum/community} for more."

## Parallel Research (For Complex Comparisons)

When comparing 3+ products or researching across multiple categories simultaneously,
research each product independently where your environment supports parallel work,
then aggregate and compare the results:

- Handle one product per parallel workstream to research specs, price, and reviews independently
- Each workstream fetches from the manufacturer's official page and a price comparison site
- Then you aggregate and compare the results

## Markets to Research

Target German and European markets (DE/AT/CH core, plus EU-wide coverage).
For each product category, research prices across multiple European countries — significant price
differences exist between markets and the best deal may involve cross-border shipping.

Check these markets in priority order:

1. **Germany (DE)** — Largest EU market, best selection and competition
2. **Austria (AT)** — Same language, many retailers ship DE->AT
3. **Switzerland (CH)** — Higher prices but unique products, different VAT
4. **Netherlands (NL)** — Strong electronics market (Tweakers)
5. **France (FR), Spain (ES), Italy (IT)** — Large markets with local price leaders
6. **Nordics (SE, NO, DK, FI)** — Higher prices but worth checking for regional exclusives
7. **Poland (PL), Czechia (CZ)** — Often lower prices, growing e-commerce
8. **UK (UK)** — Non-EU but relevant for many products; factor in customs

## Common Pitfalls

1. **Relying on a single review source** — Every reviewer has biases and blind spots.
   Always cross-reference 3+ sources.
2. **Ignoring total cost of ownership** — A cheap printer that requires $60 ink cartridges
   every 2 months isn't cheap. Always calculate TCO.
3. **Not checking compatibility** — That monitor stand might not fit your desk.
   That smart plug might not work with your home hub. Check compatibility before recommending.
4. **Stale reviews** — A product recommended in a 2023 review may have been superseded,
   discontinued, or had quality changes. Check the date.
5. **Comparing across price tiers unfairly** — Don't ding a budget product for missing features
   that only exist in the premium tier.
6. **Review sampling bias** — Users with problems are more motivated to leave reviews than happy customers.
   Look at patterns, not individual reviews.
7. **Ignoring ecosystem lock-in** — A product that works great alone but poorly with the user's
   existing setup might be a worse choice than an inferior standalone product that integrates well.

### Workaround: `site:` Operator on Brave Search (Primary)

When price-comparison sites (geizhals.de, idealo.de, etc.) are blocked by Cloudflare, use the `site:` operator on **Brave Search** as a workaround. A query like `{product_name} site:geizhals.de` returns geizhals.de product pages with prices directly in the search-result snippet — no need to load the blocked site itself. Brave Search's independent index is less aggressive with bot detection than Google/DuckDuckGo/Bing/Startpage, making this a reliable first-line fallback (verified May 2026).

### Workaround: `site:` Operator via `ddgs` (Secondary)

If Brave Search is unavailable, use the `ddgs` CLI with the `site:` operator as a secondary fallback. The `ddgs` CLI must be installed (`pip install ddgs`) and verified (`command -v ddgs`).

```bash
# Works — returns geizhals.de product pages with prices in snippets
ddgs text -q "RTX 5090 site:geizhals.de" -m 5

# Does NOT work — avoid -o json for site: queries (returns empty,
# likely a serialization issue with special characters like €, ü, ß)
# ddgs text -q "RTX 5090 site:geizhals.de" -m 5 -o json   # BROKEN
```

**Caveats:**
- **Avoid `-o json`** — it returns empty for `site:geizhals.de` queries. Use the default text output and parse manually.
- **Rate limiting** — DuckDuckGo throttles faster than Brave. If a query returns empty, wait a few seconds and retry, or fall back to the next method.
- **Not a primary replacement** — Brave Search is more reliable. Use `ddgs` only when Brave Search is unavailable or returns insufficient results.
- **Litters CWD with files** — When using `-o json`, `ddgs` writes timestamped output files (`text_{query}_{timestamp}.json`) to the CWD. Since `-o json` is broken for `site:geizhals.de` queries anyway, this is mostly a non-issue — but if you ever use `-o json` for other queries, run from a temp directory or clean up afterwards.

## Verification Checklist

- [ ] Checked for existing buying-guide documents in CWD / active project directory before researching
- [ ] User's budget, use case, and must-have features confirmed
- [ ] At least 3 independent research sources consulted
- [ ] Manufacturer specs verified (not just third-party summaries)
- [ ] Current pricing confirmed (within last 30 days)
- [ ] Total cost of ownership calculated (including hidden costs)
- [ ] Compatibility with user's existing setup checked
- [ ] Review dates checked — nothing older than 12 months without a flag
- [ ] Recommendation clearly connects back to user's stated requirements
- [ ] "Avoid if..." edge cases called out
- [ ] Honest about gaps — no recommendations without sufficient data

## Known sites for price query by region / market (ordered by priority)

Sites marked with ** are primary (most reliable for prices). Gather prices from these sites using your available means.

If the user does not specify a region, default to German and EU markets (DE/AT/CH core).

### Germany

- **https://www.geizhals.de** — Best for tech/electronics: detailed filters, price history charts, merchant ratings
- **https://www.idealo.de** — Broadest product coverage (tech, household, fashion, sports)
- https://www.billiger.de — Strong for large appliances and home goods
- https://www.check24.de — Excellent for insurance/finance, also electronics and travel
- https://www.preis.de — General price comparison, good for niche products
- https://www.preisvergleich.de — Solid fallback, covers many categories
- https://www.guenstiger.de — Good for home/garden and DIY
- https://www.mydealz.de — Community deal sharing (not automated prices, but great for spotting sales)

### Austria

- **https://www.geizhals.at** — Same engine as geizhals.de, prices in EUR from Austrian retailers
- https://www.idealo.at — Austrian market prices
- https://www.billiger.at — Austrian-focused deals

### Switzerland

- **https://www.toppreise.ch** — Best Swiss price comparison (tech, appliances)
- https://www.comparis.ch — Insurance, finance, telecom, also product comparison

### UK

- **https://www.hotukdeals.com** — Community deal aggregation, best for finding current sales
- https://www.pricespy.co.uk — Price comparison across UK retailers
- https://www.pricerunner.co.uk — UK-focused price comparison engine
- https://www.camelcamelcamel.com — Amazon price history tracker (UK and worldwide)
- https://www.keepa.com — Amazon price tracker with browser plugin (covers .co.uk + .de + .fr + .it + .es)

### Netherlands

- **https://tweakers.net/pricewatch/** — Top-tier tech price comparison with reviews (NL)
- **https://www.idealo.nl** — Broad Dutch price comparison
- https://www.kieskeurig.nl — General comparison site for Netherlands

### France

- **https://www.idealo.fr** — French market prices
- https://www.dealabs.com — Community deal sharing (hotukdeals equivalent for France)
- https://www.prix.net — French price comparison (when accessible)

### Italy

- **https://www.idealo.it** — Italian market prices
- https://www.trovaprezzi.it — Italian price comparison engine

### Spain

- **https://www.idealo.es** — Spanish market prices

### Poland

- **https://www.ceneo.pl** — Leading Polish price comparison engine
- https://www.skapiec.pl — Polish comparison site, good alternative

### Czech Republic / Slovakia

- **https://www.heureka.cz** — Czech price comparison with user reviews
- https://www.heureka.sk — Slovak version

### Greece

- **https://www.skroutz.gr** — Dominant Greek price comparison site (tech-heavy but broad)

### Nordics

- **https://www.prisjakt.no** — Norwegian price comparison
- **https://www.prisjakt.se** — Swedish price comparison
- https://www.hinta.fi — Finnish price comparison
- https://www.hintaopas.fi — Alternative Finnish comparison

### Romania

- https://www.price.ro — Romanian price comparison (basic but useful)

### Pan-European / Worldwide

- **https://www.camelcamelcamel.com** — Amazon price history across .de, .co.uk, .fr, .it, .es, .com
- **https://www.keepa.com** — Amazon price tracker with multi-market coverage (DE, UK, FR, IT, ES, US)
- https://www.shopping.google.com — Google Shopping (worldwide, set country filter)
- Direct Amazon search across EU domains: amazon.de, amazon.fr, amazon.it, amazon.es, amazon.nl, amazon.co.uk

### Notes on price query technique

- Always check geizhals.de first for tech/electronics — it has the most detailed price history and merchant filtering
- Cross-reference at least 2 price sites to catch outliers
- Check Amazon and the manufacturer's own store for direct pricing
- For deal-tracking sites like mydealz.de, hotukdeals.com, dealabs.com: use them to find recent sales, not baseline pricing
- Keepa and camelcamelcamel show Amazon price history — use these to determine if current price is actually a deal
- When comparing across EU markets, note that prices shown may include/exclude VAT at different rates (DE 19%, AT 20%, UK 20%, CH 8.1%)
- Some sites block automated HTTP requests — if one method fails, try an alternative price portal or direct retailer search (see below)

### When primary price portals are blocked

If Geizhals, Idealo, or other major price portals block automated requests, fall back to these in order:

1. **Direct retailer search** — Fetch prices from major retailer product pages directly:
   - `https://www.amazon.de/s?k={model}` — search results with prices
   - `https://www.mediamarkt.de/search?query={model}` — MediaMarkt DE
   - `https://www.saturn.de/search?searchTerm={model}` — Saturn DE
   - `https://www.notebooksbilliger.de/{model}` — specialist tech retailer
   - `https://www.conrad.de/search?search={model}` — Conrad DE

2. **`ddgs` CLI with `site:` operator** — If `ddgs` is installed (`command -v ddgs`), use it to query geizhals.de via DuckDuckGo's index:
   ```bash
   ddgs text -q "{model} site:geizhals.de" -m 5
   ```
   Prices appear in the search-result snippets. **Avoid `-o json`** — it returns empty for `site:geizhals.de` queries (serialization issue with special characters) and also dumps timestamped output files (`text_*.json`) to the CWD. Use the default text output and parse manually. DuckDuckGo may rate-limit; retry after a few seconds if empty.

3. **Google Shopping** — `https://shopping.google.com/search?q={model}+preis` — set country filter to Germany. Often accessible when price portals block automation.

4. **Keepa / camelcamelcamel** — `https://keepa.com/#!product/search` or search on camelcamelcamel. These track Amazon prices via APIs that are more accessible.

5. **Manual search fallback** — If all automated methods fail, be honest and tell the user specifically where to check: "I couldn't fetch prices automatically for {product}. You can check current prices at [specific retailer URL]." Do not fabricate price ranges.

### General price-fetching rules

- Never output a price you haven't verified in this session — stale prices harm users
- If you cannot get current prices, say so explicitly and point to specific retailer URLs, rather than citing unavailable data

## Known sites for product tests by region / market (ordered by priority)

Sites marked with ** are primary — start here. Product test sites provide expert evaluations (measurements, benchmarks, standardized testing) as opposed to user reviews or price aggregation.

### Germany

- **https://www.test.de** — Stiftung Warentest: gold standard for German product testing. Methodical, independent, covers everything from electronics to food to finance. Some content behind paywall.
- **https://www.chip.de** — Comprehensive tech tests with benchmarks, ratings, and price comparisons. Good for monitors, laptops, smartphones, printers.
- https://www.computerbase.de — German hardware review site with detailed benchmarks for CPUs, GPUs, mainboards, SSDs, and cooling
- https://www.heise.de — Publisher of c't magazine. In-depth tech reviews with strong editorial standards. Premium content behind heise+ paywall.
- https://www.notebookcheck.com — Deep-dive laptop and phone reviews with systematic display measurements, battery tests, and performance benchmarks
- https://www.connect.de — Consumer electronics testing (TVs, audio, smartphones, navigation). Known for standardized test methodology.
- https://www.golem.de — German tech news with thorough reviews of hardware, software, and gaming
- https://www.pcgh.de — PC Games Hardware: gaming hardware reviews (GPUs, CPUs, gaming peripherals)
- https://www.techstage.de — Consumer tech reviews from the Heise media group; focuses on practical testing
- https://www.hardwareluxx.de — German overclocking/hardware community with detailed component reviews
- https://www.autobild.de — Car and automotive product tests (tires, car accessories, dashcams, navigation)
- https://www.digitalphoto.de — Photography equipment reviews (cameras, lenses, tripods, lighting)
- https://www.fotomagazin.de — German photography magazine with camera and lens tests
- https://www.stereoplay.de — Hi-fi and home theater equipment tests (speakers, amplifiers, headphones)
- https://www.audio.de — Audio equipment reviews (headphones, speakers, DACs, streaming)
- https://www.medizinfuchs.de — Medication and health product price comparison + information
- https://www.etester.de — Consumer electronics with hands-on reviews and price comparisons
- https://www.kuechengoetter.de — Kitchen appliance tests (ovens, fridges, cooktops, dishwashers)
- https://www.sportaktiv.de — Sports and fitness equipment tests
- https://www.testberichte.de — Aggregator of professional and user test reports across many categories
- https://www.ciao.de — User review platform (similar to Ciao.com), good for supplementing expert reviews with real user experiences
- https://www.vergleich.org — Comparison and test overviews, covers many consumer categories

### Austria

- **https://www.konsument.at** — Verein für Konsumenteninformation (VKI). Austrian equivalent of Stiftung Warentest. Published tests across many product categories. Similar paywall model.

### UK

- **https://www.which.co.uk** — Which? is the UK's consumer association. Thorough independent product testing similar to Stiftung Warentest. Membership required for full results.
- **https://www.trustedreviews.com** — UK-based product reviews (tech, home, lifestyle). Free, well-structured with pros/cons and scoring.
- https://www.expertreviews.co.uk — UK review site covering tech, appliances, and household products
- https://www.techradar.com — Large UK-based tech review site with extensive product coverage
- https://www.tomshardware.com — Hardware reviews with benchmarks (GPUs, CPUs, SSDs, motherboards)

### Netherlands

- **https://tweakers.net** — Tech site with both pricewatch (price comparison) and extensive product reviews including benchmarks
- https://www.consumentenbond.nl — Dutch consumer association with independent product tests (membership model)

### France

- **https://www.quechoisir.org** — UFC-Que Choisir: French consumer association. Independent product testing like Stiftung Warentest.
- https://www.lesnumeriques.com — French tech review site with systematic product testing

### Belgium

- **https://www.test-achats.be** — Belgian consumer association (Test Achats / Test Aankoop). Bilingual FR/NL product tests.

### Sweden / Nordics

- https://www.prisjakt.se — Not just price comparison — includes aggregated review scores from multiple sources
- https://www.radet.org — Swedish consumer association (Råd & Rön) with independent product tests

### Finland

- https://www.vertaa.fi — Finnish comparison site with integrated review data

### International / Multi-Region

- **https://www.rtings.com** — Best-in-class for display testing: monitors, TVs, headphones. Scientific measurement-based reviews with consistent test methodology across all products.
- **https://www.gsmarena.com** — The definitive phone specification database and review site. Phone battery life benchmarks, camera comparisons, display testing.
- **https://www.dxomark.com** — Camera, audio, and display sensor testing. Frequently referenced by manufacturers. Use for objective camera quality comparison.
- **https://www.techpowerup.com** — GPU database, power measurements, CPU/GPU benchmarks, SSD reviews. Excellent for comparing raw hardware performance.
- https://www.tomshardware.com — Comprehensive hardware reviews and benchmarks. Strong GPU/CPU coverage.
- https://www.techradar.com — Broad tech review site. Good for overview comparisons and "best of" lists.
- https://www.pcmag.com — US-based but used internationally. Extensive product reviews across all tech categories.
- https://www.anandtech.com — Deep-dive hardware analysis. Less frequent updates recently but existing bench database is valuable.
- https://www.notebookcheck.com — International coverage (DE, US, CN editions). Systematic laptop/phone testing.

### Category-specific test sites

These specialize in one domain and often have better depth than generalists:

| Category | URL | Notes |
|---|---|---|
| Displays (monitors/TVs) | rtings.com | Scientific measurements, consistent methodology |
| Headphones / audio | rtings.com, audio.de, stereoplay.de | Rtings has objective frequency response measurements |
| Smartphones | gsmarena.com, notebookcheck.com, chip.de | Display, battery, camera benchmarks |
| Cameras | dxomark.com, digitalphoto.de | Sensor scores, lens tests |
| GPUs/CPUs | techpowerup.com, computerbase.de, tomshardware.com | Standardized gaming & compute benchmarks |
| SSDs/Storage | techpowerup.com, computerbase.de | Sequential/random I/O benchmarks |
| Cars / auto parts | autobild.de, adac.de | Tire tests, dashcams, accessories |
| Appliances | test.de, quechoisir.org, kuechengoetter.de | Warentest-style durability and efficiency tests |
| Fitness / sports | sportaktiv.de | Sports equipment testing |

### Notes on product test technique

- Start with independent consumer association tests (test.de, which.co.uk, quechoisir.org, konsument.at).
  These are the most objective.
- Always check the test date — product quality can change with manufacturing revisions
- Cross-reference professional tests with user reviews (Amazon, Reddit, forums) to catch common defects that tests miss
- German test sites (test.de, chip.de) often publish test summaries in PDF — search for them
- Some test results are paywalled — search for summaries or alternative sources if you can't access the full report
- Look for standardized benchmarks (e.g., Geekbench, Cinebench, 3DMark, PCMark) in reviews
  for objective cross-product comparison
