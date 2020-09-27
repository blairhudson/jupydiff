const { inspect } = require("util");
const core = require("@actions/core");
const github = require("@actions/github");
const fs = require('fs');

function getSha() {
  if (github.context.eventName == "pull_request") {
    return github.context.payload.pull_request.head.sha;
  } else {
    return github.context.sha;
  }
}

async function run(data) {
  try {
    const inputs = {
      token: core.getInput("token"),
      repository: core.getInput("repository"),
      sha: core.getInput("sha"),
      body: core.getInput("body"),
    };

    const [owner, repo] = inputs.repository.split("/");
    const sha = inputs.sha ? inputs.sha : getSha();
   

    const octokit = github.getOctokit(inputs.token);

    await octokit.repos.createCommitComment({
      owner: owner,
      repo: repo,
      commit_sha: sha,
      body: data.length == 0 ? "No Changes" : "```diff \n" + data + "\n ```"
    });
  } 
}

fs.readFile('output.txt', function read(err, data) {
   if (err) {
     throw err;
   }
   run(data.toString());
});
