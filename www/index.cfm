<cfset pages = [
    { label = "Hello World", href = "hello.cfm" },
    { label = "Dump CGI Scope", href = "cgi.cfm" },
    { label = "Dump Server Scope", href = "server.cfm" }
]>

<cfoutput>
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>LuCLI Test Harness</title>
    <style>
      html, body { height: 100%; }
      body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif; margin: 2rem; }
      h1 { margin-bottom: 0.5rem; }
      ul { list-style: none; padding: 0; margin: 0; }
      li { margin: 0.5rem 0; }
      a { color: ##0066cc; text-decoration: none; display: inline-block; padding: 0.25rem 0; }
      a:hover { text-decoration: underline; }
      small { color: ##666; }
      .layout { display: flex; gap: 1.5rem; align-items: flex-start; }
      nav { min-width: 200px; }
      .preview { flex: 1; }
      iframe { width: 100%; height: calc(100vh - 200px); border: 1px solid ##ddd; border-radius: 4px; }
    </style>
  </head>
  <body>
    <h1>LuCLI Test Harness</h1>
    <p>
      Application started at
      <strong>#dateTimeFormat(application.startedAt, "yyyy-mm-dd HH:nn:ss")#</strong>.
      Choose a page below to exercise the CFML scopes via Lucee.
    </p>
    <div class="layout">
        <nav>
            <ul>
                <cfloop array="#pages#" index="page">
                    <li>
                        <a href="#page.href#" target="demoFrame">#page.label#</a>
                    </li>
                </cfloop>
            </ul>
        </nav>
        <section class="preview">
            <iframe name="demoFrame" src="hello.cfm" title="CFML Preview"></iframe>
        </section>
    </div>
    <p><small>Rendered at #dateTimeFormat(now(), "yyyy-mm-dd HH:nn:ss")#.</small></p>
</body>
</html>
</cfoutput>
