    <com.cloudbees.jenkins.plugins.sshagent.SSHAgentBuildWrapper plugin="ssh-agent@@367.vf9076cd4ee21">
      <credentialIds>
@[for credential_id in credential_ids]@
        <string>@credential_id</string>
@[end for]@
      </credentialIds>
      <ignoreMissing>false</ignoreMissing>
    </com.cloudbees.jenkins.plugins.sshagent.SSHAgentBuildWrapper>
