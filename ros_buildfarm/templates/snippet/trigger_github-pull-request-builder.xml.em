    <org.jenkinsci.plugins.ghprb.GhprbTrigger plugin="ghprb@@1.35.0">
      <spec/>
      <triggerPhrase/>
      <adminlist/>
      <allowMembersOfWhitelistedOrgsAsAdmin>true</allowMembersOfWhitelistedOrgsAsAdmin>
      <orgslist>@ESCAPE(github_orgunit)</orgslist>
      <cron/>
      <buildDescTemplate/>
      <onlyTriggerPhrase>false</onlyTriggerPhrase>
      <useGitHubHooks>true</useGitHubHooks>
      <permitAll>true</permitAll>
      <whitelist/>
      <autoCloseFailedPullRequests>false</autoCloseFailedPullRequests>
      <displayBuildErrorsOnDownstreamBuilds>false</displayBuildErrorsOnDownstreamBuilds>
      <whiteListTargetBranches>
        <org.jenkinsci.plugins.ghprb.GhprbBranch>
          <branch>@ESCAPE(branch_name)</branch>
        </org.jenkinsci.plugins.ghprb.GhprbBranch>
      </whiteListTargetBranches>
      <project>@ESCAPE(job_name)</project>
      <extensions>
        <org.jenkinsci.plugins.ghprb.extensions.status.GhprbSimpleStatus>
          <commitStatusContext>@ESCAPE(job_name)</commitStatusContext>
          <triggeredStatus/>
          <startedStatus/>
          <statusUrl/>
        </org.jenkinsci.plugins.ghprb.extensions.status.GhprbSimpleStatus>
      </extensions>
    </org.jenkinsci.plugins.ghprb.GhprbTrigger>
