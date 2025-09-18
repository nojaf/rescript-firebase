import { $ } from "bun";
import { tmpdir } from "os";
import * as path from "path";

const isDryRun = Bun.argv.includes("--dry-run");
const rootDir = path.resolve(import.meta.dirname, "..");
import packageJson from "../package.json" with { type: "json" };
const lastVersion = packageJson.version;
const notes = await $`bunx changelog --latest-release-full`
  .cwd(rootDir)
  .text()
  .then((v) => v.trim());

const tag = `v${lastVersion}`;

// write notes to a temp file
const notesFile = path.join(tmpdir(), `release-notes-${lastVersion}.md`);
await Bun.write(notesFile, notes);

if (isDryRun) {
  console.log(
    `Dry run: Would publish version to NPM and create GitHub release for ${lastVersion}`,
  );
  await $`bun publish --dry-run`.cwd(rootDir);
} else {
  console.log(`Publishing ${lastVersion} to NPM`);
  await $`bun publish --access public`.cwd(rootDir);
}

if (isDryRun) {
  console.log(`Dry run: Create GitHub release for ${tag}`);
  console.log(`Notes file: ${notesFile}`);
  console.log(notes);
} else {
  console.log(`Creating GitHub release for ${tag}`);
  await $`gh release create ${tag} --title ${lastVersion} --notes-file ${notesFile}`.cwd(
    rootDir,
  );
}
