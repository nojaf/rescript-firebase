import { $ } from "bun";
import * as path from "path";
import packageJson from "../package.json" with { type: "json" };

const rootDir = path.resolve(import.meta.dirname, "..");

const changelogVersion = await $`bunx changelog --latest-release`
  .cwd(rootDir)
  .text()
  .then((v) => v.trim());

const packageJsonVersion = packageJson.version;

if (changelogVersion !== packageJsonVersion) {
  console.log(
    `Changelog version ${changelogVersion} does not match package.json version ${packageJsonVersion}`,
  );
  process.exit(1);
}

console.log(
  `Changelog version ${changelogVersion} matches package.json version ${packageJsonVersion}`,
);
