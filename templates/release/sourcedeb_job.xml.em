<project>
	<actions/>
	<description>Generated at @ESCAPE(now_str) from template '@ESCAPE(template_name)'</description>
@(SNIPPET(
    'log-rotator',
    days_to_keep=180,
    num_to_keep=30,
))@
	<keepDependencies>false</keepDependencies>
	<properties>
@[if job_priority is not None]@
@(SNIPPET(
    'property_job-priority',
    priority=job_priority,
))@
@[end if]@
	</properties>
	<scm class="hudson.scm.NullSCM"/>
	<assignedNode>buildslave</assignedNode>
	<canRoam>false</canRoam>
	<disabled>false</disabled>
	<blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
	<blockBuildWhenUpstreamBuilding>true</blockBuildWhenUpstreamBuilding>
	<triggers/>
	<concurrentBuild>false</concurrentBuild>
	<builders>
@(SNIPPET(
    'builder_shell',
    script='\n'.join([
        'echo "# BEGIN SECTION: Clone custom rosdistro"',
        'rm -fr rosdistro',
        'git clone https://github.com/dirk-thomas/ros-infrastructure_rosdistro.git rosdistro',
        'echo "# END SECTION"',
        '',
        'echo "# BEGIN SECTION: Clone ros_buildfarm"',
        'rm -fr ros_buildfarm',
        'git clone https://github.com/ros-infrastructure/ros_buildfarm.git ros_buildfarm',
        'echo "# END SECTION"',
    ]),
))@
@(SNIPPET(
    'builder_shell',
    script='\n'.join([
        '# generate key files',
        'echo "# BEGIN SECTION: Generate key files"',
    ] + script_generating_key_files + [
        'echo "# END SECTION"',
    ]),
))@
@(SNIPPET(
    'builder_shell',
    script='\n'.join([
        '# generate Dockerfile, build and run it',
        '# generating the Dockerfile for the actual sourcedeb task',
        'echo "# BEGIN SECTION: Generate Dockerfile - sourcedeb task"',
        'mkdir -p $WORKSPACE/docker_sourcedeb',
        'export PYTHONPATH=$WORKSPACE/ros_buildfarm:$PYTHONPATH',
        '$WORKSPACE/ros_buildfarm/scripts/release/run_sourcedeb_job.py' +
        ' --rosdistro-index-url %s' % rosdistro_index_url +
        ' %s' % rosdistro_name +
        ' %s' % pkg_name +
        ' %s' % os_name +
        ' %s' % os_code_name +
        ' ' + ' '.join(apt_mirror_args) +
        ' --source-dir $WORKSPACE/sourcedeb/source' +
        ' --dockerfile-dir $WORKSPACE/docker_sourcedeb',
        'echo "# END SECTION"',
        '',
        'echo "# BEGIN SECTION: Build Dockerfile - generate sourcedeb"',
        'cd $WORKSPACE/docker_sourcedeb',
        'docker build -t sourcedeb .',
        'echo "# END SECTION"',
        '',
        'echo "# BEGIN SECTION: Run Dockerfile - generate sourcedeb"',
        'rm -fr $WORKSPACE/sourcedeb',
        'mkdir -p $WORKSPACE/sourcedeb/source',
        'docker run' +
        ' -v $WORKSPACE/ros_buildfarm:/tmp/ros_buildfarm' +
        ' -v $WORKSPACE/rosdistro:/tmp/rosdistro' +
        ' -v $WORKSPACE/sourcedeb:/tmp/sourcedeb' +
        ' sourcedeb',
        'echo "# END SECTION"',
    ]),
))@
	</builders>
	<publishers>
@(SNIPPET(
    'publisher_build-trigger',
    child_projects=child_projects,
))@
@(SNIPPET(
    'publisher_description-setter',
    regexp="Package '[^']+' version: ([^\s]+)",
))@
@[if notify_maintainers]@
@(SNIPPET(
    'publisher_groovy-postbuild_maintainer-notification',
))@
@[end if]@
@(SNIPPET(
    'publisher_mailer',
    recipients=notify_emails,
    dynamic_recipients=maintainer_emails,
    send_to_individuals=False,
))@
	</publishers>
	<buildWrappers>
@[if timeout_minutes is not None]@
@(SNIPPET(
    'build-wrapper_build-timeout',
    timeout_minutes=timeout_minutes,
))@
@[end if]@
	</buildWrappers>
</project>