# **README**

This is a RESTFUL API to index a page and store its **h1,h2,h3** and **a** tags.
It has 2 End points

# POST
`/v1/urls` with url=> example.com as Param, this gets a url, scrapes all the tags and saves them to database
```json
{
  "status": "success",
  "url": "https://gitlab.com/explore",
  "a": 54,
  "h1": 1,
  "h2": 1,
  "h3": 0
}
```

#GET
`/v1/urls` , this returns all the saved urls and there corresponding tags.
```json
[
  {
    "url": "http://guides.rubyonrails.org/command_line.html#rails-generate",
    "tags": [
      {
        "tagContent": "http://rubyonrails.org/",
        "tag": "a"
      },
      {
        "tagContent": "Guides.rubyonrails.org",
        "tag": "h1"
      },
      {
        "tagContent": "The Rails Command Line",
        "tag": "h2"
      },
      {
        "tagContent": "Chapters",
        "tag": "h3"
      }
    ]
  }
]
```
# Database Creation
`rake db:create`

# Database initialization
`rake db:migrate`

# Model tests
`rake test TEST=test/models/url_test.rb`

# Controller tests
`rake test TEST=test/controllers/urls_controller_test.rb`

# Complete Test Suite
`rake test`

