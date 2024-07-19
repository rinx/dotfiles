import {
  createLinter,
  loadLinterFormatter,
  loadTextlintrc,
} from "npm:textlint";

// rulesets
import _ from "npm:textlint-rule-preset-ja-technical-writing";
import _ from "npm:@proofdict/textlint-rule-proofdict";
import _ from "npm:textlint-filter-rule-comments";

const descriptor = await loadTextlintrc();
const linter = createLinter({
  descriptor,
});
const results = await linter.lintFiles(Deno.args);

// textlint has two types formatter sets for linter and fixer
const formatter = await loadLinterFormatter({ formatterName: "unix" });
const output = formatter.format(results);

console.log(output);
