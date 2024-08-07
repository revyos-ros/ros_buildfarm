    <hudson.plugins.groovy.SystemGroovy plugin="groovy@@457.v99900cb_85593">
@[if command]@
      <source class="hudson.plugins.groovy.StringSystemScriptSource">
        <script plugin="script-security@@1341.va_2819b_414686">
          <script>@ESCAPE(command)</script>
          <sandbox>false</sandbox>
        </script>
      </source>
@[end if]@
@[if script_file]@
      <source class="hudson.plugins.groovy.FileSystemScriptSource">
        <scriptFile>@ESCAPE(script_file)</scriptFile>
      </source>
@[end if]@
    </hudson.plugins.groovy.SystemGroovy>
