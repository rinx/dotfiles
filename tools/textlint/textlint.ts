import { TextLintEngine } from "npm:textlint";
import { createFormatter } from "npm:@textlint/linter-formatter";
import _ from "npm:textlint-rule-preset-ja-technical-writing";
import _ from "npm:@proofdict/textlint-rule-proofdict";
import _ from "npm:textlint-filter-rule-comments";
const engine = new TextLintEngine();
const results = await engine.executeOnFiles(Deno.args);
const formatter = createFormatter({
  formatterName: "unix",
});
if (engine.isErrorResults(results)) console.log(formatter(results));
