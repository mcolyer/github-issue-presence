class Page
  @createPage: ->
    locationRegex = /https:\/\/github.com\/([^\/]+\/[^\/]+)\/issues\/?([0-9]+)?/
    [match, repo, issueId] = location.href.match(locationRegex)
    if repo and issueId
      new IssuePage(repo, issueId)
    else if repo
      new IssuesPage(repo)

class IssuesPage extends Page
  @containerTemplate: _.template """
    <ul class="list-group issue-list-group" style=" margin-bottom: 20px;">
      <%= issues %>
    </ul>
  """

  @issueTemplate: _.template """
    <li id="issue_<%= issueId %>" class="list-group-item issue-list-item js-list-browser-item js-navigation-item read selectable">
      <img height="24" width="24" style="float: left; margin-left: -53px;" src="<%= avatarUrl %>">
      <div class="issue-item-unread"></div>
      <span class="list-group-item-number">#<%= issueId %></span>
      <h4 class="list-group-item-name">
        <span class="type-icon octicon octicon-<%= issueType %>-opened open" title="Open <%= issueType %>"></span>
        <a href="/github/atom/issues/<%= issueId %>" class="js-navigation-open"><%= title %></a>
      </h4>
    </li>
  """

  constructor: (@repo) ->
    $.ajax
      url: "http://issue-presence.herokuapp.com/api/presence?repo=#{repo}"
      success: @onSuccess

  onSuccess: (text, status, jqXHR) =>
    data = JSON.parse(text)
    issues = ""

    _.each data, (issue) =>
      issues += @constructor.issueTemplate(issue)

    template = @constructor.containerTemplate({issues})
    $('.chromed-list-browser').prepend(template)

class IssuePage extends Page
  constructor: (@repo, @issueId) ->
    @user = $('a.name').text().trim()
    @title = $('h2.discussion-topic-title').text().trim()
    @avatarUrl = $('a.name img').attr('src')
    @issueType = if $('#show_issue').length > 0 then 'issue' else 'pull'

    @update()
    setInterval =>
      @update()
    , 60000

  update: ->
    $.ajax
      url: 'http://issue-presence.herokuapp.com/api/presence'
      type: 'POST'
      data: {@repo, @user, @title, @avatarUrl, @issueType, @issueId}

page = Page.createPage()
console.log(page)

