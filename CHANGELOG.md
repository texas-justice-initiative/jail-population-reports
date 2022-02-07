# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

For now, both projects will share a changelog and increase versions at the same time. This is just easier for one person to maintain, but could change in the future.

## [0.1.0]

### Added
- Repo boilerplate
- First pass at OCR parser for jail population, immigration, serious incidents, and inmate pregnancy
- Set up initial intermediary tables for all four reports in database
- Add seed data for county and jail metadata
- Add artifacts for documentation website and styled to include TJI information; these currently must be manually generated. Also, because of the way DBT docs are generated, we're keeping a copy of the styled page/css in `public` as well as `docs` to ensure they are not accidentally overwritten
- Added CI for unit tests using Github Actions

### Changed
- Bump DBT version to `1.0.1` to utilize new features around seed data documentation

### Removed
- N/A
