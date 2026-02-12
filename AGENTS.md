# AGENTS.md

## Project Overview
- Astro + Tailwind static site for Undefined (501(c)(3)).
- Node 22 is used in development instructions.

## Common Commands
- `npm install`
- `npm run dev` (serves at `http://localhost:4321`)
- `npm run build`

## Documents Page & Assets
- `src/pages/documents.astro` renders sections from files in `public/documents/`.
- Meeting PDFs should be named `YYYY-MM-DD-Agenda.pdf` and `YYYY-MM-DD-Minutes.pdf` in `public/documents/meetings/` so they group by date.
- Form 990-EZ files live in `public/documents/files/` using `YYYY 990EZ.pdf` and schedules like `YYYY 990EZ schedule-a.pdf`.
- Insurance PDFs should start with `InsurancePolicy`.
- Marketing assets (logos) are symlinked in `public/documents/` and sourced from `src/assets/`.
- The letterhead template is `public/documents/files/letterhead.dotx`.
- Update `public/documents/README.md` when adding or removing marketing assets.

## Pages & Content Sources
- `/` → `src/pages/index.astro` loads `src/content/home/-index.md`.
- `/documents` → `src/pages/documents.astro` (filesystem-driven listings; see section above).
- `/events` → `src/pages/events.astro` (static event descriptions + external links to K9 Campout, Furwood Campout, Discord/Facebook for Seattle Naked Men, and email CTAs).
- `/donate` → `src/pages/donate.astro` (Venmo link, Benevity link for Microsoft, volunteer + partnership mailto CTAs).
- `/contact` → `src/pages/contact.astro` (email/phone, mailing + service addresses, links to /documents, /terms, /privacy).
- `/privacy` → `src/pages/privacy.astro` loads `src/content/privacy/-index.md`.
- `/terms` → `src/pages/terms.astro` loads `src/content/terms/-index.md`.
- `/search` → `src/pages/search.astro` builds search index from content collections: `documents`, `home`, `terms`, `privacy`.
- Content collections live in `src/content/{home,documents,privacy,terms}/-index.md` and are used by `/search` (and page loaders above).
- `/vortexafters` → `src/pages/vortexafters.astro` client-side redirect to Stripe donation URL.
- `/vortexafters-directions` → `src/pages/vortexafters-directions.astro` (event logistics, Google Maps links, `/images/door.png`).
- `/404` → `src/pages/404.astro` uses `@components/not-found/EntryLayout.astro`.

## Style Notes
- Keep changes minimal and match existing Astro/Tailwind patterns.
