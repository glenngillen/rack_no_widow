class App

  def call(env)
    response = Rack::Response.new
    request = Rack::Request.new(env)
    response['Content-Type'] = 'text/html'
    response.write front_page
    response.finish
  end

  def front_page
    %Q{
      <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
        <body>
          <h1>Example Heading Number One</h1>
          <h2>Example Heading Number&nbsp;Two</h2>
          <h3>Heading Number Three</h3>
        </body>
      </html>
    }
  end

end
