FROM @os_name:@os_code_name
MAINTAINER @maintainer_name @maintainer_email

VOLUME ["/var/cache/apt/archives"]

ENV DEBIAN_FRONTEND noninteractive

@[if os_name == 'ubuntu']@
# Add multiverse
RUN echo deb http://archive.ubuntu.com/ubuntu @os_code_name multiverse | tee -a /etc/apt/sources.list
@[else if os_name == 'debian']@
# Add contrib and non-free to debian images
RUN echo deb http://http.debian.net/debian @os_code_name contrib non-free | tee -a /etc/apt/sources.list
@[end if]@

RUN apt-get update
RUN apt-get install -q -y curl net-tools

RUN mkdir /tmp/keys
@[for i, key in enumerate(distribution_repository_keys)]@
RUN echo "@('\\n'.join(key.splitlines()))" > /tmp/keys/@(i).key
RUN apt-key add /tmp/keys/@(i).key
@[end for]@
@[for url in distribution_repository_urls]@
RUN echo deb @url @os_code_name main | tee /etc/apt/sources.list.d/buildfarm.list
@[end for]@

RUN apt-get update
RUN apt-get install -q -y build-essential python3

RUN useradd -u @uid -m buildfarm

@[for d in dependencies]@
RUN apt-get install -q -y @d
@[end for]@

@[if not testing]@
CMD ["su", "buildfarm", "-c", "PYTHONPATH=/tmp/ros_buildfarm:$PYTHONPATH python3 -u /tmp/ros_buildfarm/scripts/command/catkin_make_isolated_and_install.py --rosdistro-name @rosdistro_name --workspace-root /tmp/catkin_workspace --clean-before"]
@[else]@
CMD ["su", "buildfarm", "-c", "PYTHONPATH=/tmp/ros_buildfarm:$PYTHONPATH python3 -u /tmp/ros_buildfarm/scripts/command/catkin_make_isolated_and_test.py --rosdistro-name @rosdistro_name --workspace-root /tmp/catkin_workspace"]
@[end if]@
