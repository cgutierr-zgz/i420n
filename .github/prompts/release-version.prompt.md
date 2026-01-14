# Release New Version

Use this prompt to help create a new release of the i420n package.

## Instructions

When releasing a new version:

1. **Determine version bump type** based on changes:
   - `patch` (1.0.x): Bug fixes, documentation updates
   - `minor` (1.x.0): New features, non-breaking changes
   - `major` (x.0.0): Breaking changes

2. **Update these files**:
   - `pubspec.yaml`: Update `version` field
   - `CHANGELOG.md`: Add new version section with changes

3. **Changelog format**:
   ```markdown
   ## [X.Y.Z] - YYYY-MM-DD

   ### Added
   - New features

   ### Changed
   - Changes to existing features

   ### Fixed
   - Bug fixes

   ### Removed
   - Removed features
   ```

4. **After updating files**, run these commands:
   ```bash
   dart pub get
   dart run build_runner build --delete-conflicting-outputs
   dart test
   dart pub global run pana .
   ```

5. **Commit and tag**:
   ```bash
   git add .
   git commit -m "chore: release vX.Y.Z"
   git tag vX.Y.Z
   git push origin master --tags
   ```

## Example Request

"Release version 1.1.0 with these changes:
- Added support for JSON file format
- Fixed plural handling for zero count
- Updated README examples"
