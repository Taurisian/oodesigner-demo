namespace: Integrations.AOS_application
flow:
  name: deploy_aos
  inputs:
    - target_host: 172.16.239.4
    - target_host_username: root
    - target_host_password:
        default: '!NN0vat3@HP!'
        sensitive: true
  workflow:
    - install_postgres:
        do:
          Integrations.demo.aos.software.install_postgres:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_java
    - install_java:
        do:
          Integrations.demo.aos.software.install_java:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_tomcat
    - install_tomcat:
        do:
          Integrations.demo.aos.software.install_tomcat:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: install_aos_application
    - install_aos_application:
        do:
          Integrations.demo.aos.application.install_aos_application:
            - username: '${target_host_username}'
            - password:
                value: '${target_host_password}'
                sensitive: true
            - tomcat_host: '${target_host}'
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      install_postgres:
        x: 298
        'y': 33
      install_java:
        x: 541
        'y': 67
      install_tomcat:
        x: 725
        'y': 75.5
      install_aos_application:
        x: 885
        'y': 94.5
        navigate:
          4f61b664-f959-9df2-727b-c34c2539b1de:
            targetId: 0b269138-d10d-a0cc-f74e-4a88fb25a3f6
            port: SUCCESS
    results:
      SUCCESS:
        0b269138-d10d-a0cc-f74e-4a88fb25a3f6:
          x: 1032
          'y': 85
