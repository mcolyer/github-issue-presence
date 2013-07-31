class Page
  @createPage: ->
    locationRegex = /https:\/\/github.com\/([^\/]+\/[^\/]+)\/issues\/?([0-9]+)?/
    [match, repo, issueId] = location.href.match(locationRegex)
    if repo and issueId
      new IssuePage(repo, issueId)
    else if repo
      new IssuesPage(repo)

class IssuesPage extends Page
  constructor: (@repo) ->

class IssuePage extends Page
  constructor: (@repo, @issues) ->
    @user = $('a.name').text().trim()
    @title = $('h2.discussion-topic-title').text().trim()
    @avatarUrl = $('a.name img').attr('src')
    @discussionType = if $('#show_issue').length > 0 then 'issue' else 'pull'

page = Page.createPage()
console.log(page)
