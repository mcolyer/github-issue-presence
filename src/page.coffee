regex = /https:\/\/github.com\/([^\/]+\/[^\/]+)\/issues\/?([0-9]+)?/

[match, repo, issue] = location.href.match(regex)
console.log repo
console.log issue
