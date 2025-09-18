import { $ } from "bun";
import { env } from "process";
import semver from "semver";
import packageJson from "../package.json" with { type: "json" };

// This script detects if there is a new release needed and triggers the release workflow if so.
// If there is need for a new release, it will trigger the workflow.
// Unexpected exit codes will be treated as errors.

// sanity check, should already be covered by the PR checks.
import "./check-version.js";

const githubReleases =
  await $`gh release list --json name,tagName,createdAt`.json();
let needsRelease = false;

if (githubReleases.length === 0) {
  console.log(`No GitHub releases were found.`);
  needsRelease = true;
} else {
  // check if the latest release is lower than the package.json version
  const latestReleaseVersion = githubReleases
    .map((r) => r.tagName?.replace(/^v/, ""))
    .filter(Boolean)
    .sort(semver.rcompare)[0];
  if (semver.gt(packageJson.version, latestReleaseVersion)) {
    console.log(
      `The version in package.json ${packageJson.version} is greater than the latest release ${latestReleaseVersion}`,
    );
    needsRelease = true;
  } else {
    console.log(
      `No new release needed. Latest GitHub release is ${latestReleaseVersion}`,
    );
  }
}

if (needsRelease) {
  console.log(`New release needed for version ${packageJson.version}`);
  const isCI = env.CI === "true";
  if (isCI) {
    await $`gh workflow run release.yml --ref main -f version="${packageJson.version}"`;
    console.log(`Release workflow triggered successfully`);
  } else {
    console.log(`Not in CI, skipping release workflow trigger`);
  }
} else {
  console.log(`No release needed - workflow complete`);
}
